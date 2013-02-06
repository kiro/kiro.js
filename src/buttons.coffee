controls = window.BC.namespace("controls")
mixins = window.BC.namespace("mixins")
common = window.BC.namespace("common")

$.extend(this, common)

buttonElement = (classes, name, click) ->
  tag('button')(classes, name).on('click', click)

controls.button = curry(buttonElement, 'btn')