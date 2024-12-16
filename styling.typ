This list is affected: #[
  #set list(marker: [--])
  - Dash
  -- Dish
]

This one is not:
- Bullet

#let task(body, critical: false) = {
  set text(red) if critical
  [- #body]
}

#task(critical: true)[Food today?]
#task(critical: false)[Work deadline]

#show heading: set text(blue)

= This is navy-blue
But this stays black.

= Show rules
With show rules, you can deeply customize the look of a type of element.
The most basic of show rule is a show-set rule.
Such a rule is written as the #text(fill: red)[show] keyword followed by a selector, a colon and then a set rule.

The most basic form of selector is an #link("https://typst.app/docs/reference/foundations/function//#element-functions")[element function]. This let the set rule only apply to the selected element.

#set heading(numbering: "(I)")

#let conf(it) = [
  #set align(center)
  #set text(font: "Inria Serif", fill: navy)
  \~ #emph(it.body)
     #counter(heading).display() \~
]
#show heading: conf
= Dragon
With a base health of 15, the dragon is the most powerful creature.

= Manticore
While less powerful than the dragon, the manticonre gets 
extra style points.

#show "Project": smallcaps
#show "badly": "great"

#let re = regex("(\d+).(\d+).(\d+)")
#show re: it => {
  let (year, month, day) = it.text.match(re).captures
  [#year/#month/#day]
}

We started Project in 2019.12.12 and are still
working on it.
Project is progressing badly.