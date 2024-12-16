#let datebox(month: "", year: []) = box(
  align(center,
    stack(
      dir: ttb,
      spacing: 0.4em,
      text(size: 1em, [#year]),
      text(size: 0.75em, month),
    )
  )
)

#let daterange(
  start: (month: "", year: []), 
  end: (month: "", year: [])
) = box(
  fill: red,
  stack(
    dir: ltr,
    spacing: 0.75em,
    datebox(month: start.month, year: start.year),
    [--],
    datebox(month: end.month, year: end.year)
  )
)

#daterange(
  start: (month: "10.09", year: 2100),
  end: (month: "11.12", year: 2101),
)