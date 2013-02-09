common = BC.namespace("common")
controls = BC.namespace("controls")
mixins = window.BC.namespace("mixins")

$.extend(this, common)

controls.table = (args...) -> $.extend(
  tag('table', 'table')(args...)
  stripped: (items...) -> this.addClassAndItems('table-striped', items...)
  bordered: (items...) -> this.addClassAndItems('table-bordered', items...)
  hover: (items...) -> this.addClassAndItems('table-hover', items...)
  condensed: (items...) -> this.addClassAndItems('table-condensed', items...)
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
