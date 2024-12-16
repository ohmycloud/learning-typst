#let title = [
  A fluid dynamic model
  for galcier flow
]

#set page(
  paper: "us-letter",
  header: align(right + horizon)[
    #text(fill: blue)[#title]
  ],
  numbering: "(1/1)",
  // footer: align(left)[
  //   #box(
  //     inset: 0.05em,
  //     text(fill: red)[rakudo.org]
  //   )
  // ],
)

#set par(justify: true)
#set text(
  font: "Cascadia Code PL",
  size: 11pt,
)

#align(center, text(17pt)[
  *#title*
])

#grid(
  columns: (1fr, 1fr),
  align(center)[
    Therese Tungsten \
    Artos Institute \
    #link("mailto:tung@artos.edu")
  ],
  align(center)[
    Dr. John Doe \
    Artos Institute \
    #link("mailto:doe@artos.edu")
  ]
)

#align(center)[
  #set par(justify: false)
  *Abstract* \
  #lorem(20)
]

#show: rest => columns(2, rest)
#show heading.where(
  level: 1
): it => block(width: 100%)[
  #set align(center)
  #set text(12pt, weight: "regular")
  #block(smallcaps(it.body))
]

#show heading.where(
  level: 2
): it => text(
  size: 11pt,
  weight: "regular",
  style: "italic",
  it.body + [.],
)

= Introduction
#lorem(100)

= Ralated Work
#lorem(80)

= Problem Statement
#lorem(40)

== Motivation
#lorem(80)