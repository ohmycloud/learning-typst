#locate(loc => query(
  heading.where(level: 1)
    .or(heading.where(level: 2)),
  loc.body,  
))

= This will be found
#lorem(12)
== So will this
#lorem(15)
=== But this will not
#lorem(5)