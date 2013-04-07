window.BC.define('store', (store) ->
  rates = window.BC.namespace("rates")

  $.extend(this, rates)

  bindings =
    REPLACE: 'client-replaceAll'
    ADD: 'client-add'
    REMOVE: 'client-remove'
    UPDATE: 'client-update'

  models = window.BC.namespace("models")
  pusher = new Pusher('9e1249843e69a619bc84')
  channels = {}

  store.pusher = (collection, channelName, id, request_rate = NO_LIMIT) ->
    channelName = 'private-' + channelName
    if channels[channelName]
      for kay, value in bindings
        channels[channelName].unbind(value)
      pusher.unsubscribe(channelName)

    channels[channelName] = pusher.subscribe(channelName)
    channel = channels[channelName]

    replaceAll = (items) -> channel.trigger('client-replaceAll', items)
    add = (items) -> channel.trigger('client-add', items)
    remove = (items) -> channel.trigger('client-remove', items)
    update = (items) -> channel.trigger('client-update', items)

    handler = collection.actionHandler(
      replaceAll: rate(replaceAll, request_rate, idempotent())
      updateView: (->)
      add: rate(add, request_rate, aggregate())
      remove: rate(remove, request_rate, aggregate())
      update: rate(update, request_rate, idempotent(id))
    )

    channel.bind('pusher:subscription_succeeded', ->
      collection.subscribeStore(handler)
    )

    eventHandler = (f) ->
      (args...) ->
        collection.disableStoreNotifications()
        f(args...)
        collection.enableStoreNotifications()

    channel.bind(bindings.REPLACE, eventHandler(
      (items) -> collection((models.object(item) for item in items))
    ))
    channel.bind(bindings.ADD, eventHandler(
      (items) -> collection.add(models.object(item)) for item in items
    ))
    channel.bind(bindings.REMOVE, eventHandler(
      (items) -> collection.remove(comparator(item)) for item in items
    ))
    channel.bind(bindings.UPDATE, eventHandler(
      (items) ->
        for item in items
          collectionItem = collection.find((item2) -> id(item) == id(item2))
          if collectionItem
            collectionItem.set(item)
          else
            collection.add(models.object(item))
    ))
)

