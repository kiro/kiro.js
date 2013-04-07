window.BC.define('models', (models) ->
  common = window.BC.namespace("common")

  # Constructs an observable model
  models.model = (arg, o) ->
    value = arg

    model = (newValue) ->
      if _.isUndefined(newValue)
        value
      else
        oldValue = value
        value = newValue
        o.publish(value)
        oldValue

    model.toJSON = () -> value

    if !o
      o = common.observable((-> model()), (newValue) -> model(newValue))
    $.extend(model, o)

  latestObservable = null

  makeObservable = (value, observable) ->
    if common.isModel(value)
    else if _.isArray(value)
      value = models.collection((makeObservable(item) for item in value), observable)
    else if _.isObject(value)
      value = models.object(value, observable)

    value

  # Makes all fields of object observable, including fields that are objects or
  # arrays.
  models.object = (obj, o) ->
    if !_.isObject(obj)
      throw Error(obj + " is expected to be an object")
    result = {}
    observables = {}

    if !o
      o = common.observable((-> result), (newValue) -> merge(result, newValue))

    for key, value of obj
      keyObservable = (key) ->
        common.observable((-> result[key]), ((newValue) -> result[key] = newValue))

      observables[key] = keyObservable(key)

      value = makeObservable(value, observables[key])

      listener = (key) ->
        (newValue, valuePath) ->
          o.publish(result, valuePath)
      observables[key].subscribe(listener(key))

      prop = (key, value) ->
        get: () ->
          latestObservable = observables[key]
          latestObservable.key = key
          value
        set: (newValue) ->
          oldValue = value
          value = makeObservable(newValue, observables[key])
          observables[key].publish(value, "")
          latestObservable = observables[key]
          oldValue
        enumerable: true

      Object.defineProperty(result, key, prop(key, value))

    $.extend(result, o)

  models.map = (observable, map = (x) -> x) ->
    if !common.isModel(observable)
      observable = latestObservable
    value = map(observable.get())

    o = common.observable((-> value), -> throw Error("Mapped values don't support set"))
    observable.subscribe((newValue, path) ->
      value = map(newValue)
      o.publish(value, path)
    )
    o

  models.negate = (observable) -> models.map(observable, (x) -> !x)

  models.bind = (field) ->
    if !latestObservable
      throw Error("bind should be used like bind(obj.field)")
    result = latestObservable
    latestObservable = null
    result

  models.guid = () ->
    s4 = ->
      Math.floor((1 + Math.random()) * 0x10000)
        .toString(16)
        .substring(1);

    s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4()

  merge = (left, right) ->
    if common.isModel(right)
      throw Error("merge is expected to work only with basic json objects.")

    left.disableNotifications()
    for key, value of left
      latestObservable = null
      left[key]
      if latestObservable
        if !_.isArray(right[key]) and _.isObject(right[key])
          merge(left[key], right[key])
        else
          left[key] = right[key]

    left.enableNotifications()
    left.publish(left)
)