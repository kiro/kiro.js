window.BC.define('bootstrap', (bootstrap) ->
  common = window.BC.namespace("common")
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

  bootstrap.td = (args...) -> $.extend(tag('td')(args...), mixins.spannable())
  bootstrap.thead = tag('thead')
  bootstrap.tbody = tag('tbody')
  bootstrap.th = (args...) -> $.extend(tag('th')(args...), mixins.spannable())
  bootstrap.caption = tag('caption')
)