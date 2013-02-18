models = window.BC.namespace("models")
common = window.BC.namespace("common")

models.collection = (allItems...) ->
  toArray = (args...) ->
    if args.length == 1 and _.isArray(args[0])
      args[0]
    else
      args

  allItems = toArray(allItems...)
  items = allItems

  o = common.observable()

  filter = () -> true
  collection = (args...) ->
    if args.length == 0
      items
    else
      allItems = toArray(args...)
      update()

  update = () ->
    items = _.filter(allItems, filter)
    o.publish(items)

  toPredicate = (arg) ->
    if _.isFunction(arg)
      arg
    else
      (item) -> item == arg

  # Adds to the collection
  #
  # if arg is an array it concats it to the colection,
  # otherwise it pushes it at the end of the collection
  collection.add = (args...) ->
    allItems = allItems.concat(toArray(args...))
    update.call(collection)

  # Removes elements from the collection
  #
  # It can accept an element and remove all values that are equal
  # or a predicate function and removes all values that satisfy it
  collection.remove = (arg) ->
    predicate = toPredicate(arg)
    allItems = _.filter(allItems, (item) -> !predicate(item))
    update.call(collection)

  # Removes all elements from the collection
  collection.removeAll = () ->
    allItems = []
    update.call(collection)

  # It filters the elements in the collection. The operation does not remove
  # the filtered elements, so if a new filter is set the collection will be
  # updated with all elements.
  #
  # arg can be a function or a value
  collection.filter = (arg) ->
    filter = toPredicate(arg)
    update.call(collection)

  # Counts the elements in the collection
  #
  # if no arguments is passed it returns the number of elements in the collection
  # if arg is function it's expected to be a predicate an it returns the number of
  # elements in the collection that satisfy it.
  collection.count = (arg) ->
    if _.isUndefined(arg)
      items.length
    else if _.isFunction(arg)
      _.reduce(items, ((memo, item) -> if arg(item) then 1 + memo else memo), 0);
    else
      throw Error(arg + " is expected to be function or undefined")

  # Replaces an element in the collection
  #
  # If old value is an object it looks for an equal objects in the collection.
  # If old value is a function, it's expected to be a predicate and it replaces
  # all elements that match it.
  collection.replace = (oldValue, newValue) ->
    predicate = toPredicate(oldValue)

    for i in [0..allItems.length]
      if predicate(allItems[i])
        allItems[i] = newValue

    update.call(collection)

  # Replaces all elements in the collection with new values.
  collection.replaceAll = (newItems...) ->
    allItems = toArray(newItems...)
    console.log(allItems)
    update.call(collection)

  # Returns a value with index arg, or if arg is function all values that
  # match the predicate
  collection.get = (arg) ->
    if _.isFunction(arg)
      _.filter(items, arg)
    else
      items[arg]

  collection.subscribe = (listener) -> o.subscribe(listener)

  collection
