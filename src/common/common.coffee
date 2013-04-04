window.BC.define('common', (common) ->
  isComposite = (item) -> item and _.isFunction(item.html) and _.isFunction(item.init)
  isModel = (item) -> item and !isComposite(item) and _.isFunction(item.subscribe) and _.isFunction(item.get) and _.isFunction(item.set) and _.isFunction(item.publish)
  isCollection = (item) -> item and _.isFunction(item.add) and _.isFunction(item.remove) and _.isFunction(item.filter) and _.isFunction(item.count) and _.isFunction(item.total)

  common.isValid = (item) ->
    _.isUndefined(item) or _.isString(item) or _.isNumber(item) or _.isArray(item) or _.isFunction(item.html) or common.isModel(item)

  # Converts an item to HTML
  common.toHtml = (item) ->
    if _.isUndefined(item) then ""
    else if isComposite(item) then item.html()
    else if _.isString(item) then item
    else if _.isNumber(item) then item
    else if _.isBoolean(item) then item.toString()
    else if _.isArray(item) then (common.toHtml(subitem) for subitem in item).join(" ")
    else if isModel(item) then common.toHtml(item.get())
    else throw Error(item + " is expected to be String, Number, Array, Boolean, undefined, model or have .html() function")

  # Initializes the item with context.
  common.init = (item, context) ->
    if _.isUndefined(item)
    else if isComposite(item) then item.init(context)
    else if _.isString(item)
    else if _.isNumber(item)
    else if _.isBoolean(item)
    else if _.isArray(item) then (common.init(subitem, context) for subitem in item).join(" ")
    else if isModel(item) then common.init(item.get())
    else throw Error(item + " is expected to be String, Number, Array, Booelan, undefined, model or have .init() function")

  common.nextId = ( ->
    id = 0
    -> ++id
  )()

  # Observable
  common.observable = (_get, _set) ->
    listeners = []
    enabled = true
    subscribe: (listener) ->
      if !_.contains(listeners, listener)
        listeners.push(listener)
      this
    publish: (newValue, path) ->
      if enabled
        listener(newValue, path) for listener in listeners
      this
    unsubscribe: (listener) ->
      listeners = _.filter(listeners, (item) -> item != listener)
    get: () -> _get()
    set: (newValue) -> _set(newValue)
    enableNotifications: -> enabled = true
    disableNotifications: -> enabled = false

  # Constructs a DOM element from composite, string, number, array.
  common.element = (composite) ->
    if _.isUndefined(composite)
    else if _.isString(composite)
      composite
    else if _.isNumber(composite)
      composite
    else if _.isBoolean(composite)
      composite.toString()
    else if _.isFunction(composite.html)
      el = $(composite.html())
      composite.init(el)
      el
    else if common.isModel(composite)
      common.element(composite._get)
    else
      throw Error(composite + " is expected to be String, Number, Boolean or composite")

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
  common.isModel = isModel
  common.isCollection = isCollection
)
