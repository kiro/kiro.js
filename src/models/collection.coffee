models = window.BC.namespace("models")
common = window.BC.namespace("common")

models.collection = (allItems...) ->
  items = allItems

  filter = () -> true
  collection = (args...) ->
    if args.length == 0
      items
    else
      allItems = args
      update()

  update = () ->
    items = _.filter(allItems, filter)
    this.publish(items)

  toPredicate = (arg) ->
    if not _.isFunction(arg)
      (item) -> item == arg
    else
      arg

  # Adds to the collection
  #
  # if arg is an array it concats it to the colection,
  # otherwise it pushes it at the end of the collection
  collection.add = (arg) ->
    if _.isArray(arg)
      allItems = allItems.concat(arg)
    else
      allItems.push(arg)

    update()

  # Removes elements from the collection
  #
  # It can accept an element and remove all values that are equal
  # or a predicate function and removes all values that satisfy it
  collection.remove = (arg) ->
    allItems = _.filter(allItems, toPredicate(arg))
    update()

  # It filters the elements in the collection. The operation does not remove
  # the filtered elements, so if a new filter is set the collection will be
  # updated with all elements.
  #
  # arg can be a function or a value
  collection.filter = (arg) ->
    filter = toPredicate(arg)
    update()

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
  colleciton.replace = (oldValue, newValue) ->
    predicate = toPredicate(oldValue)

    for i in [0..allItems.length]
      if predicate(allItems[i])
        allItems[i] = newValue

    update()

  # Replaces all elements in the collection with new values.
  collection.replaceAll = (newItems...) ->
    allItems = newItems
    update()

  # Replaces a new value in the collection at certain index
  collection.put = (index, item) ->
    allItems[index] = item
    update()

  $.extend(collection, common.observable())

