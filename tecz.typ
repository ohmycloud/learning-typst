#import "@preview/cetz:0.1.1"
#import "@preview/splash:0.3.0": *

#set page(columns: 2, margin: .5cm)

#let code(body) = {
  set text(weight: "regular")
  show: box.with(
    fill: luma(249),
    inset: 0.4em,
    radius: 3pt,
    baseline: 0.4em,
    width: 50%,
  )
  [#body]
}

#show heading.where(level: 1): it => {
    align(left)[#code(text(red)[ *#it*])]
    v(0.25em)
}

= IEC104 帧格式 
IEC104 数据帧的由起始字符、APDU 长度、控制域和 ASDU(可选)组成。

= IEC104 规约设计
#lorem(140)


= IEC104 客户端
#lorem(100)

- Python
- Raku
- Rust
- Scala

IEC104 使用 Raku 做出原型设计, 然后 Python 做辅助测试, 使用 Scala 运行在生产环境, 使用 Rust 作优化探索。

#colbreak(weak: true)
= 27930 规约解析
Through rigorous experimentation
and analysis, we have discovered
a hitherto uncharacterized process
that defies our current
understanding of the fundamental
laws of nature.

= 27930 ETL 设计
#lorem(50)

= 27930 数据解析
#lorem(100)

= 27930 ETL 设计
#lorem(80)

#place(top+left, [
#cetz.canvas(length: 2.5cm, {
  import cetz.draw: *
  set-style(
    line: (
      fill: red,
      stroke: (dash: "dashed")), 
    )
  line((0, 0), (0, 5.2), close: false, stroke: (paint: red))
  line((0, 0), (0, -5.8), close: false, stroke: (paint: blue))
})], dx: -15pt, dy: -8pt)

#pagebreak()

= iot_27930
#lorem(50)

iot_27930 这个 crate 对外提供 27930 协议的报文解析功能。该 crate 有一个 #text(xcolor.cyan)[lib.rs] 和 一个 #text(xcolor.cyan)[main.rs]。 

该 crate 的依赖:

```toml
[dependencies]
clap = { version = "4.4.3", features = ["derive"] }
hex = "0.4.3"
iot_common = { path = "../iot_common" }
```

= iot_iec104
#lorem(50)

iot_iec104 这个 crate 对外提供 IEC104 协议的报文解析功能。该 crate 有一个 #text(xcolor.cyan)[lib.rs] 和 一个 #text(xcolor.cyan)[main.rs]。 

该 crate 的依赖:

```toml
[dependencies]
clap = { version = "4.4.3", features = ["derive"] }
hex = "0.4.3"
iot_common = { path = "../iot_common" }
```

#colbreak()
= iot_common

iot-common 是通用 iot 库, 它对外提供 bytes 到数字的转换函数, iot_27930 和 iot_iec104 这两个 crate 都依赖于 iot_common。

= workspace

workspace 由多个 crates 组成, 用于管理组织代码结构。例如该项目的 workspace 由 "iot_27930", "iot_iec104" 和 "iot_common" 组成。

```toml
[workspace]
members = ["iot_27930", "iot_iec104", "iot_common"]
```