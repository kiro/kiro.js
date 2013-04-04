window.BC.define('store', (store) ->
  models = window.BC.namespace("models")
  rates = window.BC.namespace("rates")

  store.mongoLab = (collection, mongoDatabase, mongoCollection, request_rate = rates.NO_LIMIT) =>
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

    id = (item) -> item._id

    getIds = (items) ->
      ids = (JSON.stringify(item._id) for item in items).join(",")
      "{_id:{$in:[#{ids}]}}"

    updateCollection = (items) -> request('PUT', items)
    add = (items) -> request('POST', items)
    remove = (items) -> request('PUT', [], getIds(items))
    updateItems = (items) -> request('PUT', items, getIds(items))

    $.extend(this, rates)

    handler = collection.actionHandler(
      change: rate(updateCollection, request_rate, idempotent())
      filter: (->)
      add: rate(add, request_rate, aggregate())
      remove: rate(remove, request_rate, aggregate())
      update: rate(updateItems, request_rate, idempotent(id))
    )
)