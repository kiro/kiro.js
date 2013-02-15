common = window.BC.namespace("common")

# Converts an item to HTML
common.toHtml = (item) ->
  if _.isUndefined(item) then ""
  else if _.isFunction(item.html) then item.html()
  else if _.isString(item) then item
  else if _.isNumber(item) then item
  else if _.isArray(item) then (common.toHtml(subitem) for subitem in item).join(" ")
  else throw Error(item + " is expected to be String, Number, Array, undefined or have .html() function")

# Initializes the item with context.
common.init = (item, context) ->
  if _.isUndefined(item)
  else if _.isFunction(item.init) then item.init(context)
  else if _.isString(item)
  else if _.isNumber(item)
  else if _.isArray(item) then (common.init(subitem, context) for subitem in item).join(" ")
  else throw Error(item + " is expected to be String, Number, Array, undefined or have .init() function")

nextId = ( ->
  id = 0
  -> ++id
)()

common.tag = (name, initialClasses = "") ->
  (items...) ->
    classes = [initialClasses]
    id = 0
    el = null
    initializers = []
    attr = {}

    # Adds a initializer, which is a jquery call.
    addInitializer = (args...) ->
      if !id then id = nextId()
      initializers.push(args)
      this

    binder = (f, defaultMap = (x) -> x) ->
      (observable, map = defaultMap) ->
        addInitializer(f, map(observable()))
        observable.subscribe( (newValue) -> el[f](map(newValue)) )
        this

    addClass = (name) -> if name then classes.push(name)

    renderAttr = (attr) ->
      result = []
      for key, value of attr
        if _.isBoolean(value)
          result.push(key) if value
        else
          result.push(render(key, value))
      result.join(" ")

    render = (name, value) -> if value then "#{name}=\"#{value}\"" else ""

    if items.length > 0 and _.isObject(items[0]) and _.keys(items[0]).length <= 2
      if items[0].class or items[0].src
        addClass(items[0].class) if items[0].class
        $.extend(attr, src: items[0].src) if items[0].src
        items = _.rest(items)

    id: (value) ->
      id = value if !id
      this

    html: () ->
      _.template("""
        <#{name} <%= classes %> <%= id %> <%= attr %>><% _.each(items, function(item) { %>
          <%=toHtml(item)%>
        <% }) %></#{name}>
      """, {items: items, toHtml: common.toHtml, classes: render('class', classes.join(" ")), id: render('id', id), attr: renderAttr(attr)})
    init: (context) ->
      common.init(items, context)
      el = context.find('#' + id).first() if id

      for initializer in initializers
        method = initializer[0]
        params = _.rest(initializer)
        el[method](params...)

    addClass: (name) ->
      addClass(name)
      this
    addItems: (newItems...) ->
      items = items.concat(newItems)
      this

    bindValue: (observable) ->
      if this.subscribe
        this.subscribe((newValue) -> observable(newValue))
      binder('val')(observable)
      this

    bindText: binder('text')
    bindHtml: binder('html', (x) -> element(x))
    bindCss: binder('css')
    bindStyle: binder('style')
    bindClass: binder('class')
    bindVisible: (observable, condition) ->
      this.bindCss(observable, (value) ->
         display: if condition(value) then "" else "none"
      )
    bindDisabled: (observable, condition = (x) -> x) ->
      this.bindProp(observable, (value) -> disabled: condition(value))
    bindAttr: binder('attr')
    bindProp: binder('prop')

    on: (events, selector, handler) ->
      if !handler
        handler = selector
        selector = ""

      addInitializer('on', events, selector, this, handler)
      this

    trigger: (args...) ->
      addInitializer('trigger', args...)
      this

    foreach: (collection, render) ->
      this.id(nextId())
      initialItems = items.slice(0)

      collectionItems = if _.isFunction(collection) then collection() else collection

      items.push(render(item)) for item in collectionItems

      if _.isFunction(collection)
        collection.subscribe( (newItems) =>
          elements = (common.element(item) for item in initialItems)
          elements = elements.concat (common.element(render(item)) for item in newItems)
          el.html(elements)
        )
      this

    addClassAndItems: (name, items...) ->
      this.addClass(name)
      this.addItems(items...)

    attr: (value) ->
      $.extend(attr, value)
      this

    observable: () ->
      $.extend(this, common.observable())
      this

    classes: () -> classes.join(" ")

# Observable
common.observable = () ->
  listeners = []
  subscribe: (listener) ->
    listeners.push(listener)
    this
  publish: (newValue) ->
    listener(newValue) for listener in listeners
    this

# Constructs a DOM element from composite.
common.element = (composite) ->
  el = $(composite.html())
  composite.init(el)
  el

# Partial application of a function.
#
# For example
#
# add = (a, b) -> a + b
# plus3 = curry(add, 3)
# plus3(4) == 7
common.partial = (fn, fixedArgs...) ->
  (args...) -> fn(fixedArgs.concat(args)...)
