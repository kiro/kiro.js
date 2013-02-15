util = window.BC.namespace("test.util")

util.show = (items...) ->
  $('.suite').last().append(element(div(class: "bs-docs-example",
    items
  )))