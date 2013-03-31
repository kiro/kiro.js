window.BC.define('common', (common) ->
  isComposite = (item) -> item and _.isFunction(item.html) and _.isFunction(item.init)

  common.isModel = (item) -> item and _.isFunction(item.subscribe) and _.isFunction(item._get) and _.isFunction(item._set)

  common.isValid = (item) ->
    _.isUndefined(item) or _.isString(item) or _.isNumber(item) or _.isArray(item) or _.isFunction(item.html) or common.isModel(item)

  # Converts an item to HTML
  common.toHtml = (item) ->
    if _.isUndefined(item) then ""
    else if isComposite(item) then item.html()
    else if _.isString(item) then item
    else if _.isNumber(item) then item
    else if _.isArray(item) then (common.toHtml(subitem) for subitem in item).join(" ")
    else if common.isModel(item) then common.toHtml(item._get())
    else throw Error(item + " is expected to be String, Number, Array, undefined, model or have .html() function")

  # Initializes the item with context.
  common.init = (item, context) ->
    if _.isUndefined(item)
    else if isComposite(item) then item.init(context)
    else if _.isString(item)
    else if _.isNumber(item)
    else if _.isArray(item) then (common.init(subitem, context) for subitem in item).join(" ")
    else if common.isModel(item) then common.init(item._get())
    else throw Error(item + " is expected to be String, Number, Array, undefined or have .init() function")

  common.nextId = ( ->
    id = 0
    -> ++id
  )()

  # Observable
  common.observable = () ->
    listeners = []
    subscribe: (listener) ->
      for existingListener in listeners
        if existingListener == listener
          return
      listeners.push(listener)
      this
    publish: (newValue, path) ->
      listener(newValue, path) for listener in listeners
      this

  # Constructs a DOM element from composite, string, number, array.
  common.element = (composite) ->
    if _.isUndefined(composite)
    else if _.isString(composite)
      composite
    else if _.isNumber(composite)
      composite
    else if _.isFunction(composite.html)
      el = $(composite.html())
      composite.init(el)
      el
    else
      throw Error(composite + " is expected to be string, model, number of composite")

  # Partial application of a function.
  #
  # For example
  #
  # add = (a, b) -> a + b
  # plus3 = curry(add, 3)
  # plus3(4) == 7
  common.partial = (fn, fixedArgs...) ->
    (args...) -> fn(fixedArgs.concat(args)...)

  common.once = (value) ->
    first = true
    () ->
      if first
        first = false
        return value
      else
        return undefined

  common.isComposite = isComposite
)
