#let title = [
  A fluid dynamic model
  for glacier flow
]

#align(center, text(17pt)[
  *#title*
])

#grid(
  columns: (1fr, 1fr),
  align(center)[
    Larry Wall \
    Zoffex \
    #link("mailto:tung@artos.edu")
  ],
  align(center)[
    Dr. John Doe \
    Artos Institude \
    #link("mailto:doe@artos.edu")
  ],
)

#align(center)[
  #set par(justify: false)
  *Abstrcat* \
  #lorem(80)
]

#set page(
  paper: "us-letter",
  header: align(right + horizon, title),
  numbering: "1"
)
#set par(justify: true)
#set text(
  font: "Linux Libertine",
  size: 11pt,
)

#lorem(600)

#show: rest => columns(2, rest)
#show heading.where(level: 1): it => block(width: 100%)[
  #set align(center)
  #set text(12pt, weight: "regular")
  #block(smallcaps(it.body))
]
#show heading.where(level: 2): it => text(
  size: 11pt,
  weight: "regular",
  style: "italic",
  it.body + [.],
)
= Introduction
#lorem(300)

== Related Work
#lorem(200)








