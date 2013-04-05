window.BC.define('store', (store) ->

  models = window.BC.namespace("models")

  store.pusher = (collection, channel, comparator) ->
    pusher = new Pusher('9e1249843e69a619bc84')

    channel = pusher.subscribe('private-' + channel)

    handler = collection.actionHandler(
      replaceAll: (items) -> channel.trigger('client-replaceAll', items)
      updateView: () ->
      add: (item) -> channel.trigger('client-add', [item])
      remove: (items) -> channel.trigger('client-remove', items)
      update: (item) -> channel.trigger('client-update', [item])
    )

    channel.bind('pusher:subscription_succeeded', ->
      collection.subscribe(handler)
    )

    eventHandler = (f) ->
      (args...) ->
        collection.unsubscribe(handler)
        f(args...)
        collection.subscribe(handler)

    channel.bind('client-replaceAll', eventHandler(
      (items) -> collection((models.object(item) for item in items))
    ))
    channel.bind('client-add', eventHandler(
      (items) -> collection.add(models.object(item)) for item in items
    ))
    channel.bind('client-remove', eventHandler(
      (items) -> collection.remove(comparator(item)) for item in items
    ))
    channel.bind('client-update', eventHandler(
      (items) ->
        for item in items
          collectionItem = collection.find(comparator(item))
          if collectionItem
            collectionItem.set(item)
          else
            collection.add(models.object(item))
    ))
)

