window.BC.define('bootstrap', (bootstrap) ->
  mixins = window.BC.namespace("bootstrap.mixins")
  common = window.BC.namespace("common")
  models = window.BC.namespace("models")

  $.extend(this, common)

  getModel = (items) ->
    model = _.last(items)
    if _.isUndefined(model) or !common.isModel(model)
      model = models.model("")
    else
      items.pop()
    model

  input = (init, changeEvents, getValue, items...) ->
    tag('input', init)(items...)
      .on(changeEvents, (e) -> e.data.setValue(getValue(this)))

  # Input
  bootstrap.input =
    text: (items...) ->
      model = getModel(items)
      $.extend(
        input({type: 'text'}, 'keyup change', ((el) -> $(el).val()), items...)
        placeholder: (value) -> this.addAttr('placeholder' : value)
        mixins.sizeable("input")
        mixins.spannable()
      ).bindValue(model)

    password: (items...) ->
      model = getModel(items)
      this.text(items...)
        .addAttr(type: 'password')
        .bindValue(model)

    search: (items...) ->
      model = getModel(items)
      this.text(items...)
        .addClass("search-query")
        .bindValue(model)

    checkbox : (items...) ->
      model = getModel(items)
      $.extend(
        input({type: 'checkbox'}, 'click', ((el) -> $(el).is(':checked')), items...)
        isCheckbox: true
        label: (value) -> label({class: 'checkbox'}, this, value)
        inlineLabel: (value) -> label.inline({class: 'checkbox'}, this, value)
      ).bindValue(model)
       .bindAttr(model, -> checked: model.get())

    radio: (items...) ->
      model = getModel(items)
      value = items[0].value
      $.extend(
        input({type: 'radio'}, 'click', (-> value), items...)
        label: (value) -> label({class: 'radio'}, this, value)
        inlineLabel: (value) -> label.inline({class: 'radio'}, this, value)
        isRadio: true
      ).bindValue(model)
       .bindAttr(model, -> checked: model.get() == value)

    submit: (name, click) -> tag('input')(name).addAttr(type: 'submit').on('click', click)

  # Select
  bootstrap.select = (items...) ->
    model = getModel(items)

    $.extend(
      tag('select')(items...)
        .on('change', (e) -> e.data.setValue($(this).val()) )
        .bindValue(model),
      mixins.spannable()
    )
  bootstrap.select.multiple = (model) ->
    bootstrap.select(model, {multiple: 'multiple'})
  bootstrap.option = (text, value, selected = false) -> tag('option', {value: value, selected: selected})(text)

  # Textarea
  bootstrap.textarea = (items...) ->
    model = getModel(items)

    tag('textarea')(items...)
      .on('keyup change', (e) -> e.data.setValue($(this).val()))
      .bindValue(model)

  # Forms
  form = tag('form')

  bootstrap.form = (items, actions...) ->
    content = []
    for key, value of items
      if key == 'legend'
        content.push(legend(value))
      else if key == 'actions'
        actions = div(class: "form-actions", value)
      else if value.isCheckbox
        content.push(value.label(key))
      else if key == ""
        content.push(value)
      else
        content.push(label(key))
        content.push(value)

    form(
      fieldset(
        content,
        actions
      )
    )

  bootstrap.form.search = (items...) -> form(class: "form-search", items)
  bootstrap.form.inline = (items...) -> form(class: "form-inline", items)
  bootstrap.form.horizontal = (items) ->
    group = (items...) -> div(class: 'control-group', items)
    control = (items...) -> div(class: 'controls', items)

    content = []

    for key, value of items
      if key == 'legend'
        content.push(legend(value))
      else if key == 'actions'
        actions = div(class: "form-actions", value)
      else if value.isCheckbox
        content.push(group(control(value.label(key))))
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
      actions
    )

  bootstrap.form.actions = (items...) -> div(class: "form-actions", items)

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

  bootstrap.header = tag('header')
  bootstrap.section = tag('section')
  bootstrap.footer = tag('footer')
  bootstrap.br = tag('br')
)