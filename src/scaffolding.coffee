controls = window.BC.namespace("controls")
mixins = window.BC.namespace("mixins")
common = window.BC.namespace("common")

$.extend(this, common)

divElement = tag("div")

controls.div = (args...) ->
  if args.length != 0
    divElement(args...)
  else
    $.extend(
      mixins.control(),
      mixins.composite(divElement),
      mixins.spannable(),
      mixins.offsetable())

controls.div.row = curry(divElement, "row")
controls.div.row.fluid = curry(divElement, "row-fluid")
controls.div.container = curry(divElement, "container")
controls.div.container.fluid = curry(divElement, "container-fluid")

