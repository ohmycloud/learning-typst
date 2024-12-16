#import "@preview/rubby:0.8.0": get_ruby

#outline(
    title: "目录",
    target: heading.where(level: 1)
)

#pagebreak(weak: true)

#lorem(20)

= ruby

#let ruby = get_ruby(
    size: 0.5em, // Ruby font size,
    dy: 0pt,     // Vertical offset of the ruby
    pos: top,     // ruby position(top or bottom)
    alignment: "center", // Ruby alignment(center, start, between, around)
    delimiter: "|" , // the delimiter between words
    auto_spacing: true, // Automatically add necessary space around words
)

#let amazed(term, color: blue) = {
    text(color, box[#term])
}

I'am #amazed[Amazing] interest!

// Ruby goes first, base text - second
#ruby[一|二|三|四][壹|贰|叁|肆]

Treat each kanji as a separate word:
#ruby[とう|きょう|こう|ぎょう|だい|がく][東|京|工|業|大|学]

#v(10em)
#raw("#1234567")

= .. Operator

The `..` parameter syntax allows us to represent an indefinite number of arguments as an array.

// pos() returns the captured positional arguments as an array.
#let format(title, ..authors) = {
  let by = authors
    .pos()
    .join(", ", last: " and ")

  [*#title* \ _Written by #by;_]
}

// 调用函数
#format("ArtosFlow", "Jane", "Joe", "Larry", "有知有行")

// named() returns the captured named arguments as a dictionary.
#let named_format(title, ..config) = {
    let dict = config.named()  // code
    for (key, value) in dict { // code
        [#title, #key, $x^2$, #value] // block, 在 block 中变量插值
        [#linebreak()]                // block, 在 block 中调用函数
    }
}

// 调用函数
#named_format("Larry", key1: "value1", key2: "value2")

= Spreading

Inversely to an argument sink, you can spread arguments, arrays and dictionaries into a function call with the ..spread operator:

#let array = (2, 3, 5)
#calc.min(..array)

// 定义一个字典
#let dict = (fill: blue, font: "Cascadia Code")
// 使用 ..spread 操作符把字典展开到函数参数中
#text(..dict)[Hello]

= Regex

// 给定一个颜色, 获取颜色的名称和颜色的值
//  Fr is a fractional unit and 
// 1fr is for 1 part of the available space.
#let get-color-value(color) = {
  let s = repr(color)
  let m = s.match(regex("(.*)\\((.*)\\)"))
  // 定义一个字典, 存储颜色的名称和颜色的值
  let p = (name: m.captures.at(0), value: m.captures.at(1).replace("\"", "", count: 2))
  text(fill: luma(200))[
    #raw(p.name)  // 颜色名称
    #h(1fr)       //  
    #raw(p.value) // 颜色值
  ]
}

#get-color-value(rgb("#c04f17"))

// top level set rules stays in effect until the end of the file.
#set heading(numbering: "I. ")
#set text(
    font: "New Computer Modern",
    fill: blue
)

= Introduction
With set rules, you can style your document.

This list is affected: #[
    #set list(marker: [--])
    - Dash
]

This one is not:
- Bullet

Sometimes, you'll want to apply a set of rules conditionally.
For this, you can use a set-if rule.
#let task(body, critical: false) = {
    set text(red) if critical
    [- #body]
}

#task(critical: true)[今天吃什么?]
#task[面向会议编程]

// With show rules, you can deeply customize the look of a type of element.
// The most basic form of show rule is a show-set rule. 
// Such a rule is written as the show keyword followed by a selector, a colon and then a set rule.
// The most basic form of selector is an element function.
// This lets the set rule only apply to the selected element.

// In the example below, headings become red while all other text stays black.
#show heading: set text(red)
= This is red
But this stays black.

#show heading: set text(blue)
= This is blue
But this stays black.

// For the maximum flexibility, you can instead write a show rule that defines how to format an element from scratch.
// To write such a show rule, replace the set rule after the colon with an arbitrary function.
// This function receives the element in question and can return arbitrary content.
// Different fields are available on the element passed to the function.
// Like set rules, show rules are effect until the end of the current block or file.
// Instead of a function, the right-hand side of a show rule can also take a literal string or content block that should be directly substituted for the element.
// And apart from a function, the left-hand side of a show rule can also take a number of other selectors that define what to apply the transformation to:
#set heading(numbering: "(I)")
#show heading: it => block[
    #set align(center)
    #set text(red, font: "Cascadia Code")
    #it.body
]

#let color_table_header(body, critical: false) = {
    set text(red) if critical
    [#body]
}

#show regex("\d+"): set text(red)

#show "Perl 6": it => block[
    #it - #[Rakulang]
]

#show heading.where(level: 1): it => block[
    #set text(red)
    #it
]

在文本中出现 Perl 6 的地方, 全部替换为 Rakulang。

// Works with string methods.
#let words = "Rust和Rakulang都是工作的好帮手".split(regex("")).filter(x => x.len() > 0)

#let dict = (
    name: "Typst",
    born: 2019,
)

#dict.name \
#(dict.launch = 20)
#dict.launch \
#dict.len() \
#dict.values() \
#dict.keys() \
#dict.at("born", default: "Pairs") \
#dict.insert("city", "Berlin") \
#("city" in dict) \
#dict.pairs() \

#for word in words [
    #stack(dir: ltr, spacing: 1fr, rotate(24deg)[#word])
]

#set text(
    font: "Linux Libertine",
    size: 72pt,
)

// 定义一个变量
#let scedilla = [Ş]
#scedilla // 带有变音符号的字母 S

#set text(lang: "ro", script: "latn")
#scedilla // 带有逗号下标的字母 S

#set text(lang: "ro", script: "grek")
#scedilla // 带有变音符号的字母 S

#set heading(numbering: "(I)")
#show heading: it => [
  #set align(center)
  #set text(font: "Inria Serif")
  \~ #emph(it.body)
     #counter(heading).display() \~
]
= Dragon
#lorem(10)

= Manticore
#lorem(20)

#show "Project": smallcaps
#show "badly": "great"
We started Project in 2019
and are still working on it.
Project is progressing badly.

#emph[Hello] \
#emoji.face \
#"hello".len()

#{
  let a = [from]
  let b = [*world*]
  [hello ]
  a + [ the ] + b
}