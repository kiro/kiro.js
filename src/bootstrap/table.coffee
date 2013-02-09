common = BC.namespace("common")
controls = BC.namespace("controls")
mixins = window.BC.namespace("mixins")

$.extend(this, common)

controls.table = (args...) -> $.extend(
  tag('table', 'table')(args...)
  stripped: (items...) ->
    this.addClass('table-striped')
    this.addItems(items...)
  bordered: (items...) ->
    this.addClass('table-bordered')
    this.addItems(items...)
  hover: (items...) ->
    this.addClass('table-hover')
    this.addItems(items...)
  condensed: (items...) ->
    this.addClass('table-condensed')
    this.addItems(items...)
)

controls.tr = (args...) -> $.extend(
  tag('tr')(args...)
  mixins.contextual('')
)

controls.td = tag('td')
controls.thead = tag('thead')
controls.tbody = tag('tbody')
controls.th = tag('th')
controls.caption = tag('caption')
