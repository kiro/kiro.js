html = window.BC.namespace("html")
common = window.BC.namespace("common")
models = window.BC.namespace("models")

$.extend(this, common)

composite = [
  "abbr", "acronym", "address", "applet", "area", "b", "base", "basefont", "bdo", "big", "blockquote",
  "br", "button", "caption", "center", "cite", "code", "col", "colgroup", "dd", "del", "dfn", "dir", "div", "dl",
  "dt", "em", "fieldset", "font", "form", "frame", "frameset", "h1", "h2", "h3", "h4", "h5", "h6", "head", "hr",
  "html", "i", "iframe", "img", "input", "ins", "isindex", "kbd", "label", "legend", "li", "link", "map", "menu",
  "meta", "noframes", "noscript", "object", "ol", "optgroup", "option", "p", "param", "pre", "q", "s", "samp", "script",
  "select", "small", "span", "strike", "strong", "style", "sub", "sup", "table", "tbody", "td","tfoot",
  "th", "thead", "title", "tr", "tt", "u", "ul", "var", "header", "section", "footer"
]

for tagname in composite
  html[tagname] = tag(tagname)

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
html.input =
  text: (items...) ->
    model = getModel(items)
    $.extend(
      input({type: 'text'}, 'keyup change', ((el) -> $(el).val()), items...)
      placeholder: (value) -> this.addAttr('placeholder' : value)
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

    input({type: 'checkbox'}, 'click', ((el) -> $(el).is(':checked')), items...)
      .bindValue(model)
      .bindAttr(model, -> checked: model.get())

  radio: (items...) ->
    model = getModel(items)
    value = items[0].value

    input({type: 'radio'}, 'click', (-> value), items...)
      .bindValue(model)
      .bindAttr(model, -> checked: model.get() == value)

  submit: (name, click) -> tag('input')(name).addAttr(type: 'submit').on('click', click)

# Select
html.select = (items...) ->
  model = getModel(items)

  tag('select')(items...)
  .on('change', (e) -> e.data.setValue($(this).val()) )
  .bindValue(model)

html.div = tag("div")
html.span = tag("span")
html.textarea = (config) ->
  tag('textarea', config)()
    .on('keyup', (e) -> e.data.publish($(this).val()))
    .observable()

# TODO(kiro): make it to accept multiple parameters for the name
html.button = (args...) ->
  last = _.last(args)
  click = -> return false
  if _.isFunction(last)
    click = (args...) ->
      last(args...)
      return false
    args = args.slice(0, args.length - 1)

  tag('button')(args...).on('click', click)

html.a = (args...) ->
  last = _.last(args)
  click = -> return false
  if _.isFunction(last)
    click = (args...) ->
      last(args...)
      return false
    args = args.slice(0, args.length - 1)

  tag('a', {href:'#'})(args...).on('click', click)

html.body = (composite) ->
  $('body').html(
    common.element(composite)
  )

html.select = (items...) ->
  $.extend(
    tag('select')(items...)
    .observable()
    .on('change', (e) -> e.data.publish($(this).val()) )
  )
html.select.multiple = (items...) -> bootstrap.select(multiple: 'multiple', items)
html.option = (text, value) -> tag('option', value: value)(text)

#html.img
#html.select






