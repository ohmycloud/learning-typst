#set text(lang: "zh")
#context text.lang

#let value = context text.lang
#value

#set text(lang: "de")
#value

#set text(lang: "fr")
#value

#set heading(numbering: "1.")

= Introduction
#lorem(5)

#context counter(heading).get()

= Background
#lorem(5)

#context counter(heading).get()
