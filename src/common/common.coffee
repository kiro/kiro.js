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

common.nextId = ( ->
  id = 0
  -> ++id
)()

# Observable
common.observable = () ->
  listeners = []
  subscribe: (listener) ->
    listeners.push(listener)
    this
  publish: (newValue) ->
    listener(newValue) for listener in listeners
    this

# Constructs a DOM element from composite, string, number, array.
common.element = (composite) ->
  if _.isString(composite)
    composite
  else if _.isNumber(composite)
    composite
  else if _.isFunction(composite.html)
    el = $(composite.html())
    composite.init(el)
    el
  else
    throw Error(composite + " is expected to be string, number of composite")

# Partial application of a function.
#
# For example
#
# add = (a, b) -> a + b
# plus3 = curry(add, 3)
# plus3(4) == 7
common.partial = (fn, fixedArgs...) ->
  (args...) -> fn(fixedArgs.concat(args)...)
