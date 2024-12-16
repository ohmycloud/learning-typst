#let s = state("x", 0)
#let compute(expr) = [
  #s.update(x =>
    eval(expr.replace("x", str(x)))
  )
  New value is #s.display().
]

#let more = [
  #compute("x + 5") \
  #compute("x / 2")
]

Value at `<here>` is
#locate(loc => s.at(
  query(<here>, loc)
    .first()
    .location()
))

#compute("10") \
#compute("x + 3") \
*Here.* <here> \
#compute("x * 2") \
#compute("x - 5") \
// #more

#set heading(numbering: "1.")
#let template(body) = [
  = Outline
  ...
  #body
]

#show: template

= Introduction