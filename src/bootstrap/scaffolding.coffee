window.BC.define('bootstrap', (bootstrap) ->

  mixins = window.BC.namespace("bootstrap.mixins")
  common = window.BC.namespace("common")

  $.extend(this, common)

  div = (config) ->
    (items...) -> $.extend(
      tag('div', config)(items...),
      mixins.spannable(),
      mixins.offsetable()
    )

  bootstrap.div = div()

  # Containers and rows
  bootstrap.div.row = div(class: "row")
  bootstrap.div.row.fluid = div(class: "row-fluid")
  bootstrap.div.container = div(class: "container")
  bootstrap.div.container.fluid = div(class: "container-fluid")
  bootstrap.div.controls = div(class: "controls")
  bootstrap.div.controls.row = div(class: "controls controls-row")

  # Alignment
  bootstrap.left = div(class: "pull-left")
  bootstrap.right = div(class: "pull-right")
  bootstrap.center = div(style: "text-align:center")
)



