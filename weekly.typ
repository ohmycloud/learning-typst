#import "@preview/cetz:0.1.1"
#import "@preview/splash:0.3.0": *

#let code(body, color) = {
  set text(size: 18pt, weight: "regular")
  show: box.with(
    fill: color,
    inset: 0.4em,
    radius: 3pt,
    baseline: 0.4em,
    width: 100%,
    height: 30%
  )
  align(center)[#body]
}

#show "你": it => {
    text(red)[#it]
}

#show heading.where(level: 1): it => {
    align(left)[#code(text(tol-light.light-blue)[ *#it*], rgb(13,145,156))]
    v(0.25em)
}

#let weeks = ("周一", "周二", "周三", "周四")
#let indices = range(weeks.len())
#let weekly = weeks.zip(indices).map(
  ((v, k)) => 
    if calc.even(k) { code(v, rgb(12,165,160)) }
    else { code(v, rgb(165,250,178)) }
)

#let weekday(title) = [
  #grid(
    columns: (auto,) * weekly.len(),
    rows: (auto),
    row-gutter: 10pt,
    column-gutter: 10pt,
    ..weekly
  )
]

#let weekly_rows(title) = [
    #grid(
    columns: (auto),
    rows: (auto,) * (weekly.len() + 1),
    row-gutter: (10pt, ) * (weekly.len() - 1),
    column-gutter: 10pt,
    ..weekly,
    title
  )
]

#weekday("test")

#pagebreak()

#weekly_rows("title")

Slick 库

= TypeClass

```scala
trait JsonEncoder[A]:
  def encode(a: A): Json
```

Mirror 类型：

- 1. Synthesier
- 2. SyntheticMembers
- 3. Desugar

magnolia1 AutoDerivation!

= Scala 3

given 定义隐式转换, using 是使用隐式转换。

Eta Expansion 自动 Parameter Untupling