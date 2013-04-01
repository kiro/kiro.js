window.BC.define('models', (models) ->
  common = window.BC.namespace("common")

  # Constructs an observable model
  models.model = (arg) ->
    value = arg

    o = common.observable()

    model = (newValue) ->
      if _.isUndefined(newValue)
        value
      else
        oldValue = value
        value = newValue
        o.publish(value)
        oldValue

    model.subscribe = (listener) -> o.subscribe(listener)
    model._set = (newValue) ->
      value = newValue
      o.publish(value)

    model._get = () -> value
    model

  # Makes an observable array
  models.array = (arr) ->
    if !_.isArray(arr)
      throw new Error(arr + " is expected to be an array.")

    o = common.observable()
    mutators = ['pop', 'push', 'reverse', 'shift', 'sort', 'splice', 'unshift']

    hook = (arr, method) ->
      f = arr[method]
      arr[method] = ->
        result = f.apply(arr, arguments)
        o.publish(arr)
        result

    for method in mutators
      hook(arr, method)

    index = 0
    for value in arr
      if common.isModel(value)
        value.subscribe((newValue, path) -> o.publish(arr, path))
      else if _.isObject(value)
        value = models.object(value)
        arr[index] = value
        value.subscribe((newValue, path) -> o.publish(arr, path))
      index++

    arr.subscribe = (callback) -> o.subscribe(callback)
    arr._get = () -> arr
    arr._set = (newArr) -> throw Error("set is not supported for arrays")
    arr

  # Makes all fields of object observable, including fields that are objects or
  # arrays.
  models.object = (obj) ->
    if !_.isObject(obj)
      throw Error(obj + " is expected to be an object")
    result = {}
    observables = {}

    makeObservable = (obj, key, value) ->
      if _.isString(value)
        value = new String(value)
      else if _.isNumber(value)
        value = new Number(value)
      else if _.isBoolean(value)
        value = new Boolean(value)
      else if _.isUndefined(value)
          throw Error("value of " + key + " shouldn't be undefined")

      value.subscribe = (callback) -> observables[key].subscribe(callback)
      value._set = (newValue) -> obj[key] = newValue
      value._get = () -> obj[key]
      value

    o = common.observable()

    for key, value of obj
      observables[key] = common.observable()

      if _.isArray(value)
        value = models.array(value)
      else if _.isObject(value)
        value = models.object(value)
      else
        value = makeObservable(result, key, value)

      listener = (key) ->
        (newValue, valuePath) -> o.publish(result, key + (if valuePath then "." + valuePath else ""))
      value.subscribe(listener(key))

      prop = (key, value) ->
        get: () ->
          value
        set: (newValue) ->
          oldValue = value
          value = makeObservable(result, key, newValue)
          observables[key].publish(newValue)
          oldValue
        enumerable: true

      Object.defineProperty(result, key, prop(key, value))

    result.subscribe = (callback) -> o.subscribe(callback)
    result._get = () -> result
    result._set = () -> throw Error("set is not supported")

    result

  models.map = (observable, map = (x) -> x) ->
    value = map(observable._get())

    _get: () -> value
    _set: (newValue) -> throw Error("_set is not supported for mapped values")
    subscribe: (callback) -> observable.subscribe(
      (baseValue) ->
        value = map(baseValue)
        callback(value)
    )

  models.negate = (observable) -> models.map(observable, (x) -> !x)

  models.bind = (field) ->
    assert(latestObservable, "bind should be used like bind(obj.field)")
    result = latestObservable
    latestObservable = null
    result
)