window.BC.define('models', (models) ->

  common = window.BC.namespace("common")

  assertArray = (arr) ->
    if not _.isArray(arr)
      throw Error(arr + " is expected to be an array")

  models.collection = (initial = [], o = null) ->
    assertArray(initial)

    allItems = initial
    items = allItems
    compareFunction = undefined

    all = () -> true
    filter = all

    collection = (arg) ->
      if _.isUndefined(arg)
        items
      else
        assertArray(arg)
        allItems = arg
        update('change.replaceAll')

    if !o
      o = common.observable((-> collection()), (newValue) -> collection(newValue))

    callUpdate = (item, path) -> update(path)

    # TODO(kiro) : Make it to do colleciton_change when the collection has actually changed
    # and make it to pass the changes to the subscribers, so foreach binding can update the
    # DOM more efficiently
    update = (path = "") ->
      if compareFunction
        allItems.sort(compareFunction)

      items = _.filter(allItems, filter)

      for item in allItems
        if common.isModel(item)
          # if callUpdate is already subscribed to a model it
          # won't be added again
          item.subscribe(callUpdate)

      o.publish(items, path)

    update('init')

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
      update('change.add')

    # Adds all elements in the array to the collection
    collection.addAll = (items) ->
      assertArray(items)
      allItems = allItems.concat(items)
      update('change.addAll')

    # Removes elements from the collection
    #
    # It can accept an element and remove all values that are equal
    # or a predicate function and removes all values that satisfy it
    collection.remove = (arg) ->
      predicate = toPredicate(arg)
      allItems = _.filter(allItems, (item) -> !predicate(item))
      update('change.remove')

    # Removes all elements from the collection
    collection.removeAll = () ->
      allItems = []
      update('change.removeAll')

    # It filters the elements in the collection. The operation does not remove
    # the filtered elements, so if a new filter is set the collection will be
    # updated with all elements.
    #
    # arg can be a function or a value
    collection.filter = (arg) ->
      filter = toPredicate(arg)
      update('change.filter')

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

      update('change.replace')

    # Replaces all elements in the collection with new values.
    collection.replaceAll = (items) ->
      assertArray(items)
      allItems = items
      update('change.replaceAll')

    # Returns a value with index arg, or if arg is function all values that
    # match the predicate
    _get = (arg) ->
      if _.isFunction(arg)
        _.filter(items, arg)
      else
        items[arg]

    defaultCompare = (a, b) ->
      if a > b then 1
      else if a < b then -1
      else 0

    # Sorts the items in the collection and maintains them in sorted order
    collection.sort = (f = defaultCompare) ->
      compareFunction = f
      update('change.sort')

    # converts the collection to JSON
    collection.toJSON = () -> items

    $.extend(collection, o, get: _get)
)
