#show <intro>: set text(blue)

#set heading(numbering: "1.")
= Markup <heading>

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  [*Name*], [*Example*], [*See*],
  [Paragraph break], [Blank line], [#link("https://typst.app/docs/reference/layout/parbreak")[parbreak]],
  [Strong emphasis], [*strong*], [#link("https://typst.app/docs/reference/text/strong")[strong]],
  [Raw text], [`print(1)`], [#link("https://typst.app/docs/reference/text/raw")[raw]],
  [Link], [https://typst.app], [#link("https://typst.app/docs/reference/meta/link")[link]],
  [Label], [\<intro\><intro>], [#link("https://typst.app/docs/reference/construct/label")[label]],
  [Reference], [@heading], [#link("https://typst.app/docs/reference/meta/ref")[ref]],
  [Heading], [= Heading], [#link("https://typst.app/docs/reference/meta/heading")[heading]],
  [Bullet list], [- item], [#link("https://typst.app/docs/reference/layout/list")[list]],
  [Numbered list], [+ item], [#link("https://typst.app/docs/reference/layout/enum")[enum]],
  [Term list], [/ Term: description], [#link("https://typst.app/docs/reference/layout/terms")[terms]],
  [Math], [$x^2$], [#link("https://typst.app/docs/reference/math")[Math]],
  [Line break], [\\], [#link("https://typst.app/docs/reference/text/linebreak")[linebreak]],
  [Smart quote], ['single' or "double"], [#link("https://typst.app/docs/reference/text/smartquote")[smartquote]],
  [Symbol shorthand], [~, ---], [#link("https://typst.app/docs/reference/symbols/sym")[Symbols]],
  [Code expression], [#rect(width: 1cm)], [#link("https://typst.app/docs/reference/scripting/#expressions")[Scripting]],
  [Character escape], [Tweet at us at \#ad], [#link("https://typst.app/docs/reference/syntax/#escapes")[Below]],
  [Comment], [/* block */], [#link("https://typst.app/docs/reference/syntax/#comments")[Below]]
)

= Math mode

Math mode is a special markup mode that is used to typeset mathematical formulas. It is entered by wrapping an equation in \$ characters. The equation will be typeset into its own block if it starts and ends with at least one space (e.g. \$ x^2 \$). Inline math can be produced by omitting the whitespace (e.g. \$x^2\$). An overview over the syntax specific to math mode follows:

#let x = 3

#table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    [*Name*], [*Example*], [*See*],
    [Inline math], [$x^2$], [#link("https://typst.app/docs/reference/math")[Math]],
    [Block-level math], [$ x^2 $], [#link("https://typst.app/docs/reference/math")[Math]],
    [Bottom attachment], [$x_1$], [#link("https://typst.app/docs/reference/math/attach")[attach]],
    [Top attachment], [$x^2$], [#link("https://typst.app/docs/reference/math/attach")[attach]],
    [Fraction], [$1 + (a+b)/5$], [#link("https://typst.app/docs/reference/math/frac")[frac]],
    [Line break], [$x \ y$], [#link("https://typst.app/docs/reference/text/linebreak")[linebreak]],
    [Alignment point], [$x &= 2 \ &= 3$], [#link("https://typst.app/docs/reference/math")[Math]],
    [Variable access], [$#x$, $pi$], [#link("https://typst.app/docs/reference/math")[Math]],
    [Field access], [$arrow.r.long$], [#link("https://typst.app/docs/reference/scripting/#fields")[Scripting]],
    [Implied multiplication], [$x y$], [#link("https://typst.app/docs/reference/math")[Math]],
    [Symbol shorthand], [$->, !=$], [#link("https://typst.app/docs/reference/symbols/sym")[Symbols]],
    [Text/string in math], [$a "is natural"$], [#link("https://typst.app/docs/reference/math")[Math]],
    [Math function call], [$floor(x)$], [#link("https://typst.app/docs/reference/math")[Math]],
    [Code expression], [$#rect(width: 1cm)$], [#link("https://typst.app/docs/reference/scripting/#expressions")[Scripting]],
    [Character escape], [$x\^2$], [#link("https://typst.app/docs/reference/syntax/#escapes")[Below]],
    [Comment], [$/* comment */$], [#link("https://typst.app/docs/reference/syntax/#comments")[Below]]
)

#table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    [*Name*], [*Example*], [*See*],
    [Variable access], [x], [#link("https://typst.app/docs/reference/scripting/#blocks")[Scripting]],
    [Any literal], [1pt, "hey"], [#link("https://typst.app/docs/reference/types")[Types]],
    [Code block], [{ let x = 1; x + 2 }], [#link("https://typst.app/docs/reference/scripting/#blocks")[Scripting]],
    [Content block], [*Hello*], [#link("https://typst.app/docs/reference/scripting/#blocks")[Scripting]],
    [Parenthesized expression], [(1+2)], [#link("https://typst.app/docs/reference/scripting/#blocks")[Scripting]],
    [Array], [(1, 2, 3)], [#link("https://typst.app/docs/reference/types/array/")[Array]],
    [Dictionary], [a: "hi", b: 2], [#link("https://typst.app/docs/reference/types/dictionary")[Dictionary]],
    [Unary operator],[-x], [#link("https://typst.app/docs/reference/scripting/#operators")[Scripting]],
    [Binary operator], [x + y], [#link("https://typst.app/docs/reference/scripting/#operators")[Scripting]],
    [Assignment], [x = 1], [#link("https://typst.app/docs/reference/scripting/#operators")[Scripting]],
    [Field access], [x.y], [#link("https://typst.app/docs/reference/scripting/#operators")[Scripting]],
    [Method call], [x.flatten()], [#link("https://typst.app/docs/reference/scripting/#operators")[Scripting]],
    [Function call], [min(x, y)], [#link("https://typst.app/docs/reference/types/function")[Function]],
    [Argument spreading], [min(..nums)], [#link("https://typst.app/docs/reference/types/arguments")[Arguments]],
    [Unnamed function], [(x, y) => x + y], [#link("https://typst.app/docs/reference/types/function")[Function]],
    [Let binding], [let x = 1], [#link("https://typst.app/docs/reference/scripting/#operators")[Scripting]],
    [Named function], [let f(x) = 2 \* x], [#link("https://typst.app/docs/reference/types/function")[Function]],
    [Set rule], [set text(14pt)], [#link("https://typst.app/docs/reference/styling/#set-rules")[Styling]],
    [Set-if rule], [set text(..) if ..], [#link("https://typst.app/docs/reference/styling/#set-rules")[Styling]],
    [Show-set rule], [show par: set block(..)], [#link("https://typst.app/docs/reference/styling/#set-rules")[Styling]],
    [Show rule with function], [show raw: it => {...}], [#link("https://typst.app/docs/reference/styling/#show-rules")[Styling]],
    [Show-everything rule], [show: columns.with(2)], [#link("https://typst.app/docs/reference/styling/#show-rules")[Styling]],
    [Conditional], [if x == 1 {..} else {..}], [#link("https://typst.app/docs/reference/scripting/#conditionals")[Scripting]],
    [For loop], [for x in (1, 2, 3) {..}], [#link("https://typst.app/docs/reference/scripting/#loops")[Scripting]],
    [While loop], [while x < 10 {..}], [#link("https://typst.app/docs/reference/scripting/#loops")[Scripting]],
    [Loop control flow], [break, continue], [#link("https://typst.app/docs/reference/scripting/#loops")[Scripting]],
    [Return from function], [return x], [#link("https://typst.app/docs/reference/types/function/")[Function]],
    [Include module], [include "bar.typ"], [#link("https://typst.app/docs/reference/scripting/#modules")[Scripting]],
    [import module], [import "bar.typ"], [#link("https://typst.app/docs/reference/scripting/#modules")[Scripting]],
    [Import items from module], [import "bar.typ": a, b, c], [#link("https://typst.app/docs/reference/scripting/#modules")[Scripting]],
    [Comment], [/* block */], [#link("https://typst.app/docs/reference/syntax/#comments")[Below]]
)