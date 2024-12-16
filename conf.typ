#let conf(
  title: none, 
  authors: (), 
  abstract: [], 
  doc,
) = {
    set page(
      paper: "us-letter",
      header: align(
        right + horizon,
        title,
    ),
  )
  set align(center)
  text(17pt, title)

  let count = authors.len()
  let ncols = calc.min(count, 3)
  grid(
    columns: (1fr,) * ncols,
    row-gutter: 24pt,
    ..authors.map(author => [
      #author.name \
      #author.affiliation \
      #link("mailto:" + author.email)
    ]),
  )
  par(justify: false)[
    *Aabstract* \
    #abstract
  ]
  set align(left)
  set text(
    font: "Linux Libertine",
    size: 11pt,
  )
  // Heading show rules
  columns(2, doc)
}

#show: doc => conf(
  title: [Towards Improved Modeling],
  authors: (
    (
      name: "Theresa Tungsten",
      affiliation: "Artos Institude",
      email: "tung@artos.edu",
    ),
    (
      name: "Eugene Deklan",
      affiliation: "Honduras State",
      email: "e.deklan@hstate.hn",
    ),
  ),
  abstract: lorem(80),
  doc,
)

= Introduction
#lorem(140)

= Grammar
#lorem(130)

= Action
#lorem(40)