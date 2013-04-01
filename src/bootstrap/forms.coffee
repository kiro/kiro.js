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

  # Input
  bootstrap.input =
    text: (items...) ->
      model = getModel(items)

      $.extend(
        tag('input', {type: 'text'})(items...)
          .observable()
          .on('keyup change', (e) -> e.data.publish($(this).val()))
          .bindValue(model),
        placeholder: (value) -> this.addAttr('placeholder' : value),
        mixins.sizeable("input"),
        mixins.spannable()
      )

    password: (model) -> this.text({type: 'password'}, model)
    search: (model) -> this.text({class: "search-query", type: 'text'}, model)

    checkbox : (items...) ->
      model = getModel(items)

      $.extend(
        (tag('input')()
          .addAttr({type: 'checkbox', checked: 'checked'})
          .observable()
          .on('click', (e) -> e.data.publish($(this).is(':checked')))),
        bindValue: (observable) ->
          this.bindAttr(observable, -> checked: observable._get().valueOf())
          this.subscribe((value) -> observable._set(value))
        isCheckbox: true
      ).bindValue(model)

    radio: (items...) ->
      model = getModel(items)

      value = items[0].value

      $.extend(
        tag('input', type: 'radio')(items...)
          .observable()
          .on('click', (e) -> e.data.publish(value)),
        bindValue: (observable) ->
          this.bindAttr(observable, -> checked:(observable._get() == value))
          this.subscribe((value) -> observable._set(value))
        isRadio: true
      ).bindValue(model)

    submit: (name, click) -> tag('input')(name).addAttr(type: 'submit').on('click', click)

  # Select
  bootstrap.select = (items...) ->
    model = getModel(items)

    $.extend(
      tag('select')(items...)
        .observable()
        .on('change', (e) -> e.data.publish($(this).val()) )
        .bindValue(model),
      mixins.spannable()
    )
  bootstrap.select.multiple = (model) ->
    bootstrap.select(model, {multiple: 'multiple'})
  bootstrap.option = (text, value) -> tag('option', value: value)(text)

  # Textarea
  bootstrap.textarea = (items...) ->
    model = getModel(items)

    tag('textarea')(items...)
      .observable()
      .on('keyup', (e) -> e.data.publish($(this).val()))
      .bindValue(model)

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
        actions...
      )
    )

  bootstrap.form.actions = (actions...) -> div(class: "form-actions", actions)
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