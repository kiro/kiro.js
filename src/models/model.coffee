models = window.BC.namespace("models")
common = window.BC.namespace("common")

# Constructs an observable model
#
# the returned value has subscribe method which can be used
# to subscribe to changes to the model.
#
#
#
models.model = (arg, deep = false) ->
  model = (arg) ->
    value = ""
    if _.isUndefined(arg)
      value
    else
      oldValue = value
      value = arg
      this.publish(value)
      oldValue

  $.extend(model, observable)

  if _.isArray(arg)
    if deep
      model((models.model(item) for item in arg))
    else
      model(arg)
  else if _.isObject(arg)
    if deep
      obj = {}
      for key, value in arg
        obj[key] = models.model(value, deep)

      objModel = common.observable(obj)
      for key, value in arg
        objModel.subscribe(objModel[key], -> objModel.publish(objModel))
    else
      model(arg)
  else
    model(arg)
