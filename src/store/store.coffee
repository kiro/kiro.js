window.BC.define('store', (store) ->

  models = window.BC.namespace("models")

  store.mongoLab = (collection, mongoDatabase, mongoCollection) ->
    apiKey = "xR9PQZeYGV7K40N8rXp_RpdJMjQXAgiD"
    baseUrl = "https://api.mongolab.com/api/1/databases/#{mongoDatabase}/collections/#{mongoCollection}?apiKey=#{apiKey}"

    url = (query) ->
      if query then query = '&q=' + query
      baseUrl + query

    request = (method, items, query = "") ->
      $.ajax(
        url:url(query),
        data: JSON.stringify( items ),
        type: method
        contentType: "application/json"
      )

    initialItems = collection()
    collection([])
    $.get(baseUrl, (result) ->
      if result.length == 0
        request('POST', initialItems)
        collection(initialItems)
      else
        collection(models.object(item) for item in result)

      collection.subscribe(handler)
    )

    getIds = (items) ->
      ids = (item._id for item in items).join(",")
      "{_id:{$in:[#{ids}]}}"

    handler = collection.actionHandler(
      change: (items) -> request('PUT', items)
      filter: () ->
      add: (item) -> request('POST', item)
      remove: (items) -> request('PUT', [], getIds(items))
      update: (item) -> request('PUT', item, getIds([item]))
    )

  store.rateLimit = (f) ->
    latestArgs
    (args...) ->
      latestArgs = args
)