window.BC.define('models', (models) ->

  common = window.BC.namespace("common")

  assertArray = (arr) ->
    if not _.isArray(arr)
      throw Error(arr + " is expected to be an array")

  getIndexes = (items, allItems, predicate) ->
    indexes = []
    usedIndex = {}

    for item in allItems
      if predicate(item)
        for i in [0...items.length]
          if !usedIndex[i] and items[i] == item
            indexes.push(i)
            usedIndex[i] = true

    return indexes

  actions =
    CHANGE: 'change' # all items in the collection are changed
    FILTER: 'filter' # items in the collection are filtered
    ADD: 'add' # an item gets added in the collection
    REMOVE: 'remove' # items are removed from the collection
    UPDATE: 'update' # an item is updated

  models.collection = (initial = [], o = null) ->
    assertArray(initial)

    allItems = initial
    items = allItems
    compareFunction = undefined

    filter = () -> true

    action = (name, value, index = -1, oldIndex = -1) ->
      name: name
      value: value
      index: index
      oldIndex: oldIndex

    if !o
      o = common.observable((-> collection()), (newValue) -> collection(newValue))

    collection = (arg) ->
      if _.isUndefined(arg)
        items
      else
        assertArray(arg)
        allItems = arg
        update(-> action(actions.CHANGE, items))

    callUpdate = (item, path) ->
      oldIndex = items.indexOf(item)
      update(-> action(actions.UPDATE, item, items.indexOf(item), oldIndex))

    # TODO(kiro) : Make it to do colleciton_change when the collection has actually changed
    # and make it to pass the changes to the subscribers, so foreach binding can update the
    # DOM more efficiently
    update = (action) ->
      if compareFunction
        allItems.sort(compareFunction)

      items = _.filter(allItems, filter)

      for item in allItems
        if common.isModel(item)
          # if callUpdate is already subscribed to a model it
          # won't be added again
          item.subscribe(callUpdate)

      o.publish(items, action())

    update(-> action(actions.CHANGE, items))

    toPredicate = (arg) ->
      if _.isFunction(arg)
        arg
      else
        (item) -> item == arg

    # Adds to the collection
    #
    # if arg is an array it concats it to the colection,
    # otherwise it pushes it at the end of the collection
    collection.add = (item) ->
      allItems.push(item)
      update(-> action(actions.ADD, item, items.lastIndexOf(item)))

    # Removes elements from the collection
    #
    # It can accept an element and remove all values that are equal
    # or a predicate function and removes all values that satisfy it.
    collection.remove = (item) ->
      predicate = toPredicate(item)

      removeIndexes = getIndexes(items, allItems, predicate)
      removeItems = _.filter(allItems, predicate)
      allItems = _.filter(allItems, (item) -> !predicate(item))
      update(-> action(actions.REMOVE, removeItems, removeIndexes))

    # Removes all elements from the collection
    collection.clear = () ->
      allItems = []
      update(-> action(actions.CHANGE, items))

    # It filters the elements in the collection. The operation does not remove
    # the filtered elements, so if a new filter is set the collection will be
    # updated with all elements.
    #
    # arg can be a function or a value
    collection.filter = (arg) ->
      filter = toPredicate(arg)
      update(-> action(actions.FILTER, items))

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

    # Returns a value with index arg, or if arg is function all values that
    # match the predicate
    collection.find = (predicate) ->
      result = _.filter(items, predicate)
      if result.length == 0
        undefined
      else if result.length == 1
        result[0]
      else
        result

    # Returns the item at index
    collection.at = (index) -> items[index]

    defaultCompare = (a, b) ->
      if a > b then 1
      else if a < b then -1
      else 0

    # Sorts the items in the collection and maintains them in sorted order
    collection.sort = (f = defaultCompare) ->
      compareFunction = f
      update(-> action(actions.CHANGE, items))

    collection.contains = (item) -> _.contains(items, item)

    # converts the collection to JSON
    collection.toJSON = () -> items

    collection.actionHandler = (handler) ->
      (items, action) ->
        if action.name == actions.CHANGE
          handler.change(action.value)
        else if action.name == actions.FILTER
          handler.filter(action.value)
        else if action.name == actions.ADD
          handler.add(action.value, action.index)
        else if action.name == actions.REMOVE
          handler.remove(action.value, action.index)
        else if action.name == actions.UPDATE
          handler.update(action.value, action.index, action.oldIndex)

    $.extend(collection, o)
)
