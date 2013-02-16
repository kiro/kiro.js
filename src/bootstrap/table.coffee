common = BC.namespace("common")
bootstrap = BC.namespace("bootstrap")
mixins = window.BC.namespace("bootstrap.mixins")

$.extend(this, common)

bootstrap.table = (args...) -> $.extend(
  tag('table', class: 'table')(args...)
  stripped: (items...) -> this.addClassAndItems('table-striped', items...)
  bordered: (items...) -> this.addClassAndItems('table-bordered', items...)
  hover: (items...) -> this.addClassAndItems('table-hover', items...)
  condensed: (items...) -> this.addClassAndItems('table-condensed', items...)
)

bootstrap.tr = (args...) -> $.extend(
  tag('tr')(args...)
  mixins.contextual('')
)

bootstrap.td = tag('td')
bootstrap.thead = tag('thead')
bootstrap.tbody = tag('tbody')
bootstrap.th = tag('th')
bootstrap.caption = tag('caption')
