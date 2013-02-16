util = window.BC.namespace("test.util")
html = window.BC.namespace("html")

util.show = (items...) ->
  $('.suite').last().append(element(div(
    items
  )))

util.click = (text) ->
  $(".suite").last().find(":contains(#{text})").last().click()

util.el = (text) -> $(":contains(#{text})").last()
