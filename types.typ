//#set text(lang: "zh")
#rect(width: 20pt)
#rect(width: 2em)
#rect(width: 1in)

#let poems = ("风回云断雨初晴", "返照湖边暖复明", "青山隐隐水迢迢", "青枫江上秋帆远", "白帝城边古木疏")
#stack(
  dir: ltr,
  spacing: 1fr,
  ..poems
  .map(i => rotate(15deg)[#i]),
)

#set align(center)
#scale(x: 150%)[
  Scaled apart.
]

#rect(width: 100% - 50pt)

在 #h(1fr) 北京 #h(2fr) 没吃饭

#sym.arrow.r \
#sym.gt.eq.not \
$gt.eq.not$ \
#emoji.face.halo
$dif x$

#sym.arrow.r.long.squiggly
