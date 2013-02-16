bootstrap = window.BC.namespace("bootstrap")
mixins = window.BC.namespace("bootstrap.mixins")
common = window.BC.namespace("common")

$.extend(this, common)

div = (className = "") ->
  (items...) -> $.extend(
    tag('div', class: className)(items...),
    mixins.spannable(),
    mixins.offsetable())

bootstrap.div = div()

bootstrap.div.row = div("row")
bootstrap.div.row.fluid = div("row-fluid")
bootstrap.div.container = div("container")
bootstrap.div.container.fluid = div("container-fluid")
bootstrap.div.controls = div("controls")
bootstrap.div.controls.row = div("controls controls-row")

bootstrap.left = div("pull-left")
bootstrap.right = div("pull-right")
bootstrap.center = div()



