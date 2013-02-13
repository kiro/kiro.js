ns = window.BC.namespace("model")
common = window.BC.namespace("common")

ns.model = (arg) ->
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

ns.collection = (args...) -> ko.observableArray(args)
