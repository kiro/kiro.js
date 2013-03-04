modules = {}
initializers = {}

window.BC =
  namespace : (name) ->
    if _.isUndefined(modules[name])
      modules[name] = {}
    if _.isArray(initializers[name])
      initializer(modules[name]) for initializer in initializers[name]
      initializers[name] = undefined

    modules[name]

  define : (name, fn) ->
    if _.isUndefined(initializers[name])
      initializers[name] = [fn]
    else
      initializers[name].push(fn)