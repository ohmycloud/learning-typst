#import "@preview/cetz:0.1.1"
#import "@preview/splash:0.3.0": *

#let cell(color: none, width: none, height: none, body: none) = {
  set text(weight: "bold", fill: rgb(74,181,230), size: 72pt)
  show: rect.with(
    fill: color,
    width: width,
    height: height,
  )
  // locate(loc => loc.position().y)
  align(center)[#body]
}

#let code(body, color) = {
  set text(weight: "bold", fill: rgb(74,181,230), size: 16pt)
  show: box.with(
    fill: color,
    inset: 0.4em,
    radius: 3pt,
    baseline: 0.4em,
    width: 45%,
    height: 85%
  )
  align(center)[#body]
}

#let code_col(body, color) = {
  set text(weight: "bold", fill: rgb(74,181,230), size: 16pt)
  show: box.with(
    fill: color,
    inset: 0.4em,
    radius: 3pt,
    baseline: 0.4em,
    width: 100%,
    height: 45%
  )
  align(center)[#body]
}

#let weekday(title) = [
  #grid(
    columns: (120pt, 120pt, 120pt, 120pt),
    rows: (auto),
    row-gutter: 1pt,
    column-gutter: (-30pt, -30pt, -30pt, -30pt),
    code("Rust", rgb("#FFF7EA")),
    code("Zig", rgb("#BBF2FF")),
    code("Raku", rgb("#83DFFF")),
    code("Smile", rgb("#4FCDFA")),
  )
]

#let weekday_col(title) = [
  #grid(
    columns: (120pt, ),
    rows: (auto, auto, auto),
    row-gutter: 1pt,
    column-gutter: (-30pt, -30pt),
    code_col("Rust", rgb("#FFF7EA")),
    code_col("Zig", rgb("#BBF2FF")),
    code_col("Raku", rgb("#83DFFF")),
    code_col("Smile", rgb("#4FCDFA")),
  )
]

#let half_page() = [
  #align(center)[
      #grid(
        columns: auto,
        row-gutter: (-180pt, 5pt, 5pt,),
        rows: (10cm, 4cm, 5cm, 4cm),
        gutter: 3pt,
        cell(color: rgb(209,242,255), width: 100%, height: 100%),
        align(center)[#text(
          size: 48pt, 
          fill: rgb(74,181,230),
          weight: "bold",
          )[今日计划]
        ],
        weekday("test"),
        cell(color: rgb(255,255,255), width: 40%, height: 100%),
        align(center)[#text(
          size: 48pt, 
          fill: rgb(74,181,230),
          weight: "bold",
          )[Friday]]
      )
  ]
]

#let half_column() = [
    #align(center)[
      #grid(
        columns: (10cm, 10pt, 10pt, 10pt),
        row-gutter: (10pt),
        column-gutter: (13pt, 25pt, 0pt),
        cell(color: rgb(209,242,255), width: 100%, height: 50%, body: "汇总"),
        align(center)[#text(
          size: 48pt, 
          fill: rgb(74,181,230),
          weight: "bold",
          )[今日计划]
        ],
        weekday_col("test"),
        cell(color: rgb(255,255,255), width: 100%, height: 100%),
        align(center)[#text(
          size: 48pt, 
          fill: rgb(74,181,230),
          weight: "bold",
          )[Friday]]
      )
  ]
]

// #half_page()

#half_column()

// #cell(color: rgb(55,255,255), width: 100%, height: 100%, body: "测试"),


  #grid(
    columns: (5pt, ),
    rows: (auto, auto),
    row-gutter: 1pt,
    column-gutter: (-30pt, -30pt),
    code_col("Rust", rgb("#FFF7EA")),
    code_col("Zig", rgb("#BBF2FF")),
  )