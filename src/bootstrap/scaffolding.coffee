controls = window.BC.namespace("controls")
mixins = window.BC.namespace("mixins")
common = window.BC.namespace("common")

$.extend(this, common)

div = (className = "") ->
  (items...) -> $.extend(
    tag('div')(items...).addClass(className),
    mixins.spannable()
    mixins.offsetable())

controls.div = div()

controls.div.row = div("row")
controls.div.row.fluid = div("row-fluid")
controls.div.container = div("container")
controls.div.container.fluid = div("container-fluid")

controls.left = div("pull-left")
controls.right = div("pull-right")
controls.center = div()

