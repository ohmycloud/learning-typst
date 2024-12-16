#set page(header: locate(loc => {
  let elems = query(
    selector(heading).before(loc),
    loc,
  )
  let academy = smallcaps[
    Typst Academy
  ]
  if elems == () {
    align(right, academy)
  } else {
    let body = elems.last().body
    academy + h(1fr) + emph(body)
  }
}))

= Introduction
#lorem(23)

= Background
#lorem(30)

#pagebreak()

= Analysis
#lorem(15)