#let amazed(term, color: red) = {
  text(color, box[»ö« #term »ö«])
}

*测试* 123

You are #amazed[beautiful]! \
I am #amazed(color: purple)[amazed]!

#show: doc => amazed(doc, color: blue)
I choose to focus on the good
in my life and let go of any
negative thoughts for beliefs.
In fact, I am amazing!


#let template(doc) = [
  #set text(font: "Inria Serif")
  #show "something cool": [Raku]
  #doc
]

#show: template
I am learning something cool today.
It's going great so far!

