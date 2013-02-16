models = window.BC.namespace("models")
common = window.BC.namespace("common")

models.model = (arg) ->
  if _.isString(arg) then return ko.observable(arg)
  else if _.isNumber(arg) then return ko.observable(arg)
  else if _.isBoolean(arg) then return ko.observable(arg)
  else if _.isFunction(arg) then return ko.observable(arg)
  else if _.isArray(arg) then return ko.observableArray((model(element) for element in arg))
  else if _.isUndefined() then return arg
  else if _.isObject(arg)
    obj = {}
    for key, value in object
      obj[key] = model(value)

models.collection = (args...) -> ko.observableArray(args)
