common = window.BC.namespace("common")

# Converts an item to HTML
common.toHtml = (item) ->
  if _.isFunction(item.html) then item.html()
  else if _.isString(item) then item
  else if _.isNumber(item) then item
  else if _.isUndefined(item) then ""
  else if _.isArray(item) then (common.toHtml(subitem) for subitem in item).join(" ")
  else throw Error(item + " is expected to be String, Number, Array, undefined or have .html() function")

# Initializes the item with context.
common.init = (item, context) ->
  if _.isFunction(item.init) then item.init(context)
  else if _.isString(item)
  else if _.isNumber(item)
  else if _.isUndefined(item)
  else if _.isArray(item) then (common.init(subitem, context) for subitem in item).join(" ")
  else throw Error(item + " is expected to be String, Number, Array, undefined or have .init() function")

common.tag = (name) ->
  (classes, items...) ->
    bind = (setter, observable, map = (x) -> x) ->
      setter(map(observable(), observable))
      observable.subscribe( (newValue) ->
        setter(map(newValue, observable))
      )
      return this

    nextId = ( ->
      id = 0
      -> ++id
    )()

    initialized = false
    id = 0
    element = null
    initializers = []

    id: id
    el: (args...) ->
      if initialized
        if args.length == 0
          return element
        else
          element[args[0]](_.rest(args))
      else
        if !id
          id = nextId()
        initializers.push(args)
        return this
    html: () ->
      _.template("""
        <#{name} <% if (classes) { %><%='class="' + classes + '"' %> <% } %> <% if (id) { %><%='id="' + id + '"'%><% } %>><% _.each(items, function(item) { %>
          <%=toHtml(item)%>
        <% }) %></#{name}>
      """, {items: items, toHtml: common.toHtml, classes: classes, id: id})
    init: (context) ->
      common.init(items, context)

      if initializers
        element = context.find('#' + id).first()
        for initializer in initializers
          method = initializer[0]
          params = _.rest(initializer)
          console.log(element)
          console.log(method)
          console.log(params)
          console.log(element[method].apply(element, params))

      initialized = true

    bind: common.curry(bind, (value) => this.el('val', value))
    bindText: common.curry(bind, (value) => this.el('text', value))
    bindVisible: common.curry(bind, (value) => if value then this.el('show') else this.el('hide'))
    bindHtml: common.curry(bind, (value) => this.el('html', value))
    bindCss: common.curry(bind, (value) => this.el('css', value))
    bindStyle: common.curry(bind, (value) => this.el('style', value))
    bindAttr: common.curry(bind, (value) => this.el('attr', value))
    on: (args...) -> this.el('on', args...)

# Constructs a DOM element from composite.
common.element = (composite) ->
  el = $(composite.html())
  composite.init(el)
  el

# Currying a function.
#
# For example
#
# add = (a, b) -> a + b
# plus3 = curry(add, 3)
# plus3(4) == 7
common.curry = (fn, fixedArgs...) ->
  (args...) -> fn(fixedArgs.concat(args)...)

common.list = (collection, render) ->


