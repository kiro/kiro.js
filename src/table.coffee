common = BC.namespace("common")
controls = BC.namespace("controls")
mixins = window.BC.namespace("mixins")

$.extend(this, common)

tableElement = tag('table')

controls.table = (args...) ->
  if args.length != 0
    tableElement("table", args...)
  else
    $.extend(
      mixins.control(),
      mixins.composite((classes, args...) -> tableElement("table " + classes, args...)),
      stripped: () -> this.addClass('table-striped')
      bordered: () -> this.addClass('table-bordered')
      hover: () -> this.addClass('table-hover')
      condensed: () -> this.addClass('table-condensed')
    )

trElement = tag('tr')

controls.tr = (args...) ->
  if args.length != 0
    trElement("", args...)
  else
    $.extend(
      mixins.control(),
      mixins.composite(trElement),
      mixins.contextual('')
    )

controls.td = curry(tag('td'), '')
controls.thead = curry(tag('thead'), '')
controls.tbody = curry(tag('tbody'), '')
controls.th = curry(tag('th'), '')
controls.caption = curry(tag('caption'), '')
