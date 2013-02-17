models = window.BC.namespace("models")
common = window.BC.namespace("common")

# Constructs an observable model
models.model = (arg) ->
  value = arg

  o = common.observable()

  model = (newValue) ->
    if _.isUndefined(newValue)
      value
    else
      value = newValue
      o.publish(value)
      value

  model.subscribe = (listener) -> o.subscribe(listener)

  model
