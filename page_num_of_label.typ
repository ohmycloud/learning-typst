#show ref: it => {
    let el = it.element
    if el != none {
      numbering("1", ..counter(page).at(el.location()))
    } else {
      it
    }
}

= Introduction <intro>

#lorem(100)

#pagebreak()

= Thesis

#set text(font: "Noto Serif CJK SC")

As we have mentioned in Introduction on page @intro, this paper does nothing.