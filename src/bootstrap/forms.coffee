controls = window.BC.namespace("controls")
mixins = window.BC.namespace("mixins")
common = window.BC.namespace("common")

$.extend(this, common)

controls.input =
  text : () ->
    $.extend(
      tag('input')()
        .attr(type: 'text')
        .observable()
        .on('keyup', (e) -> e.data.publish($(this).val())),
      placeholder: (value) -> this.attr('placeholder', value)
    )

  checkbox : () ->
    $.extend(
      (tag('input')()
        .attr(type: 'checkbox')
        .observable()
        .on('click', (e) -> e.data.publish($(this).is(':checked')))),
      bindValue: (observable) ->
        this.bindProp(observable, -> checked:observable())
        this.subscribe((value) -> observable(value))
    )

  radio: (name, value) ->
    $.extend(
      tag('input')()
        .attr({type: 'radio', name: name, value: value})
        .observable()
        .on('click', (e) -> e.data.publish(value)),
      bindValue: (observable) ->
        this.bindProp(observable, -> checked:(observable() == value))
        this.subscribe((value) -> observable(value))
    )

controls.select = (items...) ->
    tag('select')(items...)
      .observable()
      .on('change', (e) -> e.data.publish($(this).val()) )

controls.select.multiple = (items...) ->
  controls.select(items...).attr(multiple: 'multiple')

controls.option = (text, value) -> tag('option')(text).attr(value: value)

###
button
checkbox
color
date
datetime
datetime-local
email
file
hidden
image
month
number
password
radio
range
reset
search
submit
tel
text
time
url
week
###