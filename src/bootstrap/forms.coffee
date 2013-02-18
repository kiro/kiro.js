bootstrap = window.BC.namespace("bootstrap")
mixins = window.BC.namespace("bootstrap.mixins")
common = window.BC.namespace("common")

$.extend(this, common)

# Input
bootstrap.input =
  text: (config, type = 'text') ->
    $.extend(
      tag('input', type: type)(config)
        .observable()
        .on('keyup change', (e) -> e.data.publish($(this).val())),
      placeholder: (value) -> this.addAttr('placeholder' : value),
      mixins.sizeable("input"),
      mixins.spannable()
    )

  password: (config) -> this.text(config, 'password')

  checkbox : () ->
    $.extend(
      (tag('input')()
        .addAttr(type: 'checkbox')
        .observable()
        .on('click', (e) -> e.data.publish($(this).is(':checked')))),
      bindValue: (observable) ->
        this.bindAttr(observable, -> checked: observable())
        this.subscribe((value) -> observable(value))
      isCheckbox: true
    )

  radio: (name, value) ->
    $.extend(
      tag('input', type: 'radio', name: name, value: value)()
        .observable()
        .on('click', (e) -> e.data.publish(value)),
      bindValue: (observable) ->
        this.bindAttr(observable, -> checked:(observable() == value))
        this.subscribe((value) -> observable(value))
      isRadio: true
    )

  submit: (name, click) -> tag('input')(name).addAttr(type: 'submit').on('click', click)

# Select
bootstrap.select = (items...) ->
  $.extend(
    tag('select')(items...)
      .observable()
      .on('change', (e) -> e.data.publish($(this).val()) ),
    mixins.spannable()
  )
bootstrap.select.multiple = (items...) -> bootstrap.select(multiple: 'multiple', items)
bootstrap.option = (text, value) -> tag('option', value: value)(text)

# Textarea
bootstrap.textarea = (init) ->
  tag('textarea', init)()
    .observable()
    .on('keyup', (e) -> e.data.publish($(this).val()))

# Forms
form = tag('form')

bootstrap.form = (items, actions...) ->
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

bootstrap.form.search = (items...) -> form(class: "form-search", items)
bootstrap.form.inline = (items...) -> form(class: "form-inline", items)
bootstrap.form.horizontal = (items, actions...) ->
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

bootstrap.help =
  block: (text) -> bootstrap.span(class: 'help-block', text)
  inline: (text) -> bootstrap.span(class: 'help-inline', text)

bootstrap.legend = tag('legend')
bootstrap.fieldset = tag('fieldset')
bootstrap.label = tag('label')
bootstrap.label.inline = tag('label', class: 'inline')

# Prepend and append
toAddOn = (item) ->
  if _.isString(item)
    bootstrap.span(class:'add-on', item)
  else
    item

bootstrap.append = (input, items...) ->
  items = (toAddOn(item) for item in items)
  div(class: "input-append", input, items)

bootstrap.prepend = (items...) ->
  items = (toAddOn(item) for item in items)
  div(class: "input-prepend", items)

# Images
img = (initialConfig = {}) ->
  (config) ->
    tag('img', initialConfig)(config)

bootstrap.img = img()
bootstrap.img.rounded = img(class: 'img-rounded')
bootstrap.img.circle = img(class: 'img-circle')
bootstrap.img.polaroid = img(class: 'img-polaroid')