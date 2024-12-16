= 指针和引用

指针是一个持有内存地址的值，可以通过解引用来访问它指向的内存地址，理论上可以解引用到任意数据类型；引用是一种特殊的指针，它的解引用访问是受限的，
只能解引用到它所引用的类型，不能用作它用。

= 智能指针

智能指针是一种表现行为很像指针的数据结构，它除了指向数据的指针外，还有元数据以提供额外的处理能力。
智能指针一定是一个胖指针，但胖指针不一定是智能指针。比如 `&str` 就是一个胖指针，它有指向堆内存字符串的指针，同时还有关于字符串长度的元数据。

== 智能指针 String 和 &str 的区别

String 相比 `&str` 多了一个 capacity 字段，但 String 对堆上的值有所有权，而 `&str` 是没有所有权的，这是 Rust 中智能指针和普通胖指针的区别。

我们知道，String 是用结构体定义的，那智能指针和结构体有什么区别呢？

```rust
pub struct String {
  vec: Vec<u8>,
}
```

和普通结构体不同的是，String 实现了 Deref 和 DerefMut，这使得它在解引用的时候，会得到 `&str`，看下面的#link("https://doc.rust-lang.org/src/alloc/string.rs.html#2529-2545")[标准库实现]：

```rust
impl ops::Deref for String {
    type Target = str;

    fn deref(&self) -> &str {
        unsafe { str::from_utf8_unchecked(&self.vec) }
    }
}

impl ops::DerefMut for String {
    fn deref_mut(&mut self) -> &mut str {
        unsafe { str::from_utf8_unchecked_mut(&mut *self.vec) }
    }
}
```

另外，由于堆上分配了数据，String 还需要为其分配的资源做相应的回收。而 String 内部使用了 Vec<u8>，所以它可以依赖 `Vec<T>` 的能力来释放堆内存。
下面是标准库中 `Vec<T>` 的 #link("https://doc.rust-lang.org/src/alloc/vec/mod.rs.html#3063-3074")[Drop trait 的实现]： 

```rust
#[stable(feature = "rust1", since = "1.0.0")]
unsafe impl<#[may_dangle] T, A: Allocator> Drop for Vec<T, A> {
    fn drop(&mut self) {
        unsafe {
            // use drop for [T]
            // use a raw slice to refer to the elements of the vector as weakest necessary type;
            // could avoid questions of validity in certain cases
            ptr::drop_in_place(ptr::slice_from_raw_parts_mut(self.as_mut_ptr(), self.len))
        }
        // RawVec handles deallocation
    }
}
```

所以，再重新定义一下，在 Rust 中，凡是需要做资源回收的数据结构，且实现了 Deref/DerefMut/Drop，都是智能指针。

#grid(
  columns: (1fr, 1fr),
  row-gutter: 10pt,
  [数据结构], [指针类型],
  [String], [智能指针],
  [Box\<T>], [智能指针],
  [Vec\<T>], [智能指针],
  [Rc\<T>], [智能指针],
  [Arc\<T>], [智能指针],
  [PathBuf], [智能指针],
  [Cow\<'a, B>], [智能指针],
  [MutexGuard\<T>], [智能指针],
  [RwLockReadGuard\<T>], [智能指针],
  [RwLockWriteGuar>], [智能指针]
)

== Box\<T>

在 Box\<T> 的定义里，内部就是一个#link("https://doc.rust-lang.org/src/core/ptr/unique.rs.html#36-44")[Unique\<T>]，Unique\<T> 是一个私有的数据结构，我们不能直接使用，它包裹了一个 `*const T` 指针，并唯一拥有这个指针。

```rust
pub struct Unique<T: ?Sized> {
    pointer: *const T,
    _marker: PhantomData<T>,
}
```

自己实现内存分配器

```rust
use std::alloc::{GlobalAlloc, Layout, System};

struct MyAllocator;

unsafe impl GlobalAlloc for MyAllocator {
    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
        let data = System.alloc(layout);
        eprintln!("ALLOC: {:p}, size {}", data, layout.size());
        data
    }

    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
        System.dealloc(ptr, layout);
        eprintln!("FREE: {:p}, size {}", ptr, layout.size());
    }
}

#[global_allocator]
static GLOBAL: MyAllocator = MyAllocator;

#[allow(dead_code)]
struct Matrix {
    // 使用不规则的数字, 如 505 可以让 dbg! 的打印很容易分辨出来
    data: [u8; 505],
}

impl Default for Matrix {
    fn default() -> Self {
        Self { data: [0; 505] }
    }
}

fn main() {
    // 在这句执行之前已经有很多内存分配
    let data = Box::new(Matrix::default());

    // 输出中有一个 1024 大小的内存分配, 是 println! 导致的
    println!(
        "!!! 分配内存：{:p}, 长度：{}",
        &*data,
        std::mem::size_of::<Matrix>()
    );

    // data 在这里 drop， 可以在打印中看到 FREE
    // 之后还有很多其他内存被释放
}
```

注意这里不能使用 println!() 。因为 stdout 会打印到一个由 Mutex 互斥锁保护的共享全局 buffer 中，这个过程中会涉及内存的分配，分配的内存又会触发 println!()，最终造成程序崩溃。而 eprintln! 直接打印到 stderr，不会 buffer。

在使用 Box 分配堆内存的时候要注意，Box::new() 是一个函数，所以传入它的数据会出现在栈上，再移动到堆上（函数传参，值发生 move）。所以，如果我们的 Matrix 结构不是 505 个字节，而是一个非常大的结构，就有可能出问题。

比如下面的代码想在堆上分配 16M 内存，如果在 playground 里运行，直接栈溢出 stack overflow：

```rust
fn main() {
    // 在堆上分配 16M 内存，但它会在栈上出现，再移动到堆上
    let boxed = Box::new([0u8; 1 << 24]);
    println!("len: {}", boxed.len());
}
```

下面的代码效果是一样的：

```rust
fn main() {
    // 在堆上分配 16M 内存，但它会在栈上出现，再移动到堆上
    let data = [0u8; 1 << 24];
    let boxed = Box::new(data);
    println!("len: {}", boxed.len());
}
```

但如果你在本地使用 “cargo run —release” 编译成 `release` 代码运行，会正常执行！这是因为 “cargo run” 或者在 playground 下运行，默认是 debug build，它不会做任何 inline 的优化，而 Box::new() 的实现就一行代码，并注明了要 inline，在 release 模式下，这个函数调用会被优化掉：

```rust
pub fn new(x: T) -> Self {
    box x
}
```

如果不 inline，整个 16M 的大数组会通过栈内存传递给 Box::new，导致栈溢出。这里我们惊喜地发现了一个新的关键字 box。然而 box 是 Rust 内部的关键字，用户代码无法调用，它只出现在 Rust 代码中，用于分配堆内存，box 关键字在编译时，会使用内存分配器分配内存。

搞明白 Box 的内存分配，我们还很关心内存是如何释放的，来看它实现的 Drop trait

```rust
unsafe impl<#[may_dangle] T: ?Sized, A: Allocator> Drop for Box<T, A> {
    fn drop(&mut self) {
        // FIXME: Do nothing, drop is currently performed by compiler.
    }
}
```

哈，目前 drop trait 什么都没有做，编译器会自动插入 deallocate 的代码。这是 Rust 语言的一种策略：在具体实现还没有稳定下来之前，我先把接口稳定，实现随着之后的迭代慢慢稳定。

== Cow\<'a, B>

Cow（Clone-on-Write）是 Rust 里用于提供写时克隆的一种智能指针。它跟虚拟内存管理的写时复制（Copy-on-Write）有异曲同工之妙：包裹一个#text(red)[只读借用]，但如果调用者需要所有权或需要修改内容，那么它会 clone 借用的数据。

Cow 的定义：

```rust
pub enum Cow<'a, B> where B: 'a + ToOwned + ?Sized {
    Borrowed(&'a B),
    Owned(<B as ToOwned>::Owned),
}
```

它是一个枚举类型，要么是一个对类型 B 的只读引用，要么是一个拥有所有权的类型 B。

where 后面又引入了两个 trait，首先是 ToOwned trait，在定义 ToOwned trait 的时候，又引入了 Borrow trait，它们都是 #link("https://doc.rust-lang.org/std/borrow/index.html")[std::borrow] 下的 trait：

```rust
pub trait ToOwned {
    // The resulting type after obtaining ownership.
    type Owned: Borrow<Self>;
    #[must_use = "cloning is often expensive and is not expected to have side effects"]
    fn to_owned(&self) -> Self::Owned;

    fn clone_into(&self, target: &mut Self::Owned) { ... }
}

pub trait Borrow<Borrowed> where Borrowed: ?Sized {
    fn borrow(&self) -> &Borrowed;
}
```

要理解 Cow trait，就要先理解 ToOwned trait。ToOwned 的定义不太好理解，因为 `type Owned: Borrow<Self>` 不好理解。

这里，Owned 是关联类型，需要使用者定义，但是这里 Owned 不能是任意类型，它必须有 trait bound，满足 Borrow\<T> trait。

很多关联类型不带 trait bound，例如下面的 `type Output`：

```rust
/// std::ops::Mul, the trait for types that support `*`.
pub trait Mul<RHS> {
    /// The resulting type after applying the `*` operator
    type Output;

    /// The method for the `*` operator
    fn mul(self, rhs: RHS) -> Self::Output; 
}
```

例如，我们看 #link("https://doc.rust-lang.org/src/alloc/str.rs.html#203-217")[str 对 ToOwned trait 的实现]：

```rust
impl ToOwned for str {
    type Owned = String;
    #[inline]
    fn to_owned(&self) -> String {
        unsafe { String::from_utf8_unchecked(self.as_bytes().to_owned()) }
    }

    fn clone_into(&self, target: &mut String) {
        let mut b = mem::take(target).into_bytes();
        self.as_bytes().clone_into(&mut b);
        *target = unsafe { String::from_utf8_unchecked(b) }
    }
}
```

可以看到关联类型 Owned 被定义为 String，根据 trait bound 要求，String 必须也要实现 `Borrow<Self>`，而现在我们正在为 str 实现 ToOwned trait，所以 `Borrow<Self>` 是 `Borrow<str>`，也就是说，String 要实现 `Borrow<str>`，我们看#link("https://doc.rust-lang.org/std/string/struct.String.html#impl-Borrow%3Cstr%3E-for-String")[String 的文档]，String 的确#link("https://doc.rust-lang.org/src/alloc/str.rs.html#187-193")[实现了这个 trait]：

```rust
impl Borrow<str> for String {
    #[inline]
    fn borrow(&self) -> &str {
        &self[..]
    }
}
```

为什么 Borrow 要定义成一个泛型 trait 呢？难道一个类型还可以被借用成不同的引用吗？

还真是，我们看一个例子：

```rust
use std::borrow::Borrow;

fn main() {
    let s = "hello world!".to_owned(); // String

    // 这里必须显式地写类型注解，因为 String 有多个 Borrow<T> 实现
    let r1: &String = s.borrow(); // 借用为 &String
    let r2: &str = s.borrow();    // 借用为 &str
    
    println!("r1: {:p}, r2: {:p}", r1, r2);
}
```

在这个例子中，String 可以被借用为 &String，也可以被借用为 &str。

== Cow 和 Deref

Cow 是智能指针，所以它自然需要实现 Deref trait：

```rust
impl<B: ?Sized + ToOwned> Deref for Cow<'_, B> {
    type Target = B;

    fn deref(&self) -> &B {
        match *self {
            Borrowed(borrowed) => borrowed,
            Owned(ref owned) => owned.borrow(),
        }
    }
}
```

deref 方法返回对 B 的引用。 匹配 self（Cow 类型实例），根据 self 是 Borrowed 还是 Owned，我们分别取其内容，生成对目标类型 B 的引用：

- 对于 Borrowed，它里面的值本身就是引用，直接返回它里面的值，就是一个引用；
- 对于 Owned，调用其 borrow() 方法，获得引用。

这就很符合人体工程学了。虽然 Cow 是一个枚举，但是通过 Deref 的实现，我们获得了一致的体验，比如 Cow\<str>，使用的感觉和 &str/String 是基本一致的。

== Cow 的使用场景

Cow 是更通用的 Clone。它可以在需要的时候才进行内存的分配和拷贝，较多用于性能优化。如果 Cow\<'a, B> 中的 Owned 数据类型是一个需要在堆上分配内存的类型，如 String、Vec\<T> 等，还能减少堆内存的分配次数，减少不必要的堆内存分配是提升系统效率的关键手段。

在解析 URL 的时候，我们经常需要将 querystring 中的参数，提取成 KV pair 来进一步使用。绝大多数语言中，提取出来的 KV 都是新的字符串，在每秒钟处理几十 k 甚至上百 k 请求的系统中，你可以想象这会带来多少次堆内存的分配。但在 Rust 中，我们可以用 Cow 类型轻松高效处理它，在读取 URL 的过程中：每解析出一个 key 或者 value，我们可以用一个 &str 指向 URL 中相应的位置，然后用 Cow 封装它；而当解析出来的内容不能直接使用，需要 decode 时，比如 “hello%20world”，我们可以生成一个解析后的 String，同样用 Cow 封装它。

看下面的例子：（cargo add url）

```rust
use url::Url;

fn show_cow(cow: Cow<str>) -> String {
    match cow {
        Cow::Borrowed(v) => format!("Borrowed {}", v),
        Cow::Owned(v) => format!("Owned {}", v)
    }
}

fn print_cow(key: Cow<str>, value: Cow<str>) {
    println!("key: {}, value: {}", show_cow(key), show_cow(value));
}

fn main() {
    let url = Url::parse("https://tyr.com/rust?page=1024&sort=desc&extra=hello%20world").unwrap();
    let mut pairs = url.query_pairs();
    assert_eq!(pairs.count(), 3);

    while let Some((mut k, v)) = pairs.next() {
        // 因为 k, v 都是 Cow<str>, 它们使用起来感觉和 &str 或者 String 一样
        // 此时，它们都是 Borrowed。
        println!("key: {}, v: {}", k, v);

        // 当修改发生时, k 变成 Owned
        k.to_mut().push_str(" rocks");
        print_cow(k, v);
    }
}
```

类似 URL parse 这样的处理方式，在 Rust 标准库和第三方库中非常常见。比如 Rust 下著名的 serde 库，可以非常高效地对 Rust 数据结构，进行序列化 / 反序列化操作，它对 Cow 就有很好的支持。我们可以通过如下代码将一个 JSON 数据反序列化成 User 类型，同时让 User 中的 name 使用 Cow 来引用 JSON 文本中的内容:

```bash
cargo add serde --features=derive
cargo add serde_json
```

代码如下:

```rust
use serde::Deserialize;

#[derive(Debug, Deserialize)]
struct User<'input> {
    #[serde(borrow)]
    name: Cow<'input, str>,
    age: u8,
}

fn main() {
    let input = r#"{"name": "Camelia", "age": 28}"#;
    let user: User = serde_json::from_str(input).unwrap();

    match user.name {
        Cow::Borrowed(name) => println!("borrowed {}", name),
        Cow::Owned(name) => println!("Owned {}", name),
    }
}
```