controls = window.BC.namespace("controls")
mixins = window.BC.namespace("mixins")
common = window.BC.namespace("common")

$.extend(this, common)

controls.input =
  text: (config, type = 'text') ->
    $.extend(
      tag('input')(config)
        .attr(type: type)
        .observable()
        .on('keyup', (e) -> e.data.publish($(this).val())),
      placeholder: (value) -> this.attr('placeholder' : value),
      mixins.sizeable("input"),
      mixins.spannable()
    )

  password: (config) -> this.text(config, 'password')

  checkbox : () ->
    $.extend(
      (tag('input')()
        .attr(type: 'checkbox')
        .observable()
        .on('click', (e) -> e.data.publish($(this).is(':checked')))),
      bindValue: (observable) ->
        this.bindProp(observable, -> checked: observable())
        this.subscribe((value) -> observable(value))
      isCheckbox: true
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
      isRadio: true
    )

  submit: (name, click) -> tag('input')(name).attr(type: 'submit').on('click', click)

controls.select = (items...) ->
  $.extend(
    tag('select')(items...)
      .observable()
      .on('change', (e) -> e.data.publish($(this).val()) ),
    mixins.spannable()
  )

controls.select.multiple = (items...) ->
  controls.select(items...).attr(multiple: 'multiple')

controls.option = (text, value) -> tag('option')(text).attr(value: value)

controls.textarea = (rows) ->
  result = tag('textarea')()
  result.attr(rows: rows) if rows
  result
    .observable()
    .on('keyup', (e) -> e.data.publish($(this).val()))

form = tag('form')

controls.form = (items, actions...) ->
  content = []
  for key, value of items
    if key == 'legend'
      content.push(legend(value))
    else if value.isCheckbox
      content.push(label(class: 'checkbox', value, key))
    else if key == ""
      content.push(value)
    else
      content.push(label(key))
      content.push(value)

  form(
    fieldset(
      content,
      div(class: "form-actions", actions) if actions.length
    )
  )

controls.form.search = (items...) -> form(class: "form-search", items)
# TODO(kiro) : FIX ME
controls.form.inline = (items...) -> form(class: "form-inline", items)
controls.form.horizontal = (items, actions...) ->
  group = (items...) -> div(class: 'control-group', items)
  control = (items...) -> div(class: 'controls', items)

  content = []

  for key, value of items
    if key == 'legend'
      content.push(legend(value))
    else if value.isCheckbox
      content.push(group(control(label(class: 'checkbox', value, key))))
    else if key == ""
      content.push(group(control(value)))
    else
      content.push(
        group(
          label(class: "control-label", key),
          control(value)
        )
      )

  form(class: 'form-horizontal',
    content,
    div(class: "form-actions", actions) if actions.length
  )

controls.help =
  block: (text) -> controls.span(class: 'help-block', text)
  inline: (text) -> controls.span(class: 'help-inline', text)

controls.legend = tag('legend')
controls.fieldset = tag('fieldset')
controls.label = tag('label')
controls.label.inline = tag('label', 'inline')

toAddOn = (item) ->
  if _.isString(item)
    controls.span(class:'add-on', item)
  else
    item

controls.append = (input, items...) ->
  items = (toAddOn(item) for item in items)
  div(class: "input-append", input, items)

controls.prepend = (items...) ->
  items = (toAddOn(item) for item in items)
  div(class: "input-prepend", items)

img = (initialClass) ->
  (config) ->
    tag('img')(config)
      .addClass(initialClass)

controls.img = img()
controls.img.rounded = img('img-rounded')
controls.img.circle = img('img-circle')
controls.img.polaroid = img('img-polaroid')
# TODO(kiro): Add validations

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