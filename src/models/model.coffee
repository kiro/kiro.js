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
    model.map = ->
    model
)