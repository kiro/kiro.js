controls = window.BC.namespace("controls")
mixins = window.BC.namespace("mixins")
common = window.BC.namespace("common")

$.extend(this, common)

controls.input =
  text : () ->
    value = tag('input')()
      .attr(type: 'text')
      .observable()
    value.on('keyup', (e) -> value.publish($(e.target).val()))

