controls = window.BC.namespace("controls")
mixins = window.BC.namespace("mixins")
common = window.BC.namespace("common")

$.extend(this, common)

button = (classes) ->
  (name, click) ->
    tag('button')(name).addClass(classes).on('click', click)

controls.button = button('btn')
controls.a = (name, click) -> tag('a')(name).on('click', click)