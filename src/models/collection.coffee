window.BC.define('models', (models) ->

  common = window.BC.namespace("common")

  assertArray = (arr) ->
    if not _.isArray(arr)
      throw Error(arr + " is expected to be an array")

  models.collection = (initial = []) ->
    assertArray(initial)

    allItems = initial
    items = allItems

    o = common.observable()

    filter = () -> true
    collection = (arg) ->
      if _.isUndefined(arg)
        items
      else
        assertArray(arg)
        allItems = arg
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
    collection.add = (arg) ->
      allItems.push(arg)
      update.call(collection)

    # Adds all elements in the array to the collection
    collection.addAll = (items) ->
      assertArray(items)
      allItems = allItems.concat(items)
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

    # Counts all element in the collection including the filtered elements.
    #
    # if no arguments is passed it returns the number of elements in the collection
    # if arg is function it's expected to be a predicate an it returns the number of
    # elements in the collection that satisfy it.
    collection.total = (arg) ->
      if _.isUndefined(arg)
        allItems.length
      else if _.isFunction(arg)
        _.reduce(allItems, ((memo, item) -> if arg(item) then 1 + memo else memo), 0);
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
    collection.replaceAll = (items) ->
      assertArray(items)
      allItems = items
      update.call(collection)

    # Returns a value with index arg, or if arg is function all values that
    # match the predicate
    collection.get = (arg) ->
      if _.isFunction(arg)
        _.filter(items, arg)
      else
        items[arg]

    collection.subscribe = (listener) ->
      o.subscribe(listener)
      this

    collection
)
