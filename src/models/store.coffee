window.BC.define('store', (store) ->
  store.localStore = () ->
    post: (->)
    put: (->)
    get: (->)
    getAll: (->)
    delete: (->)

  store.mongoLab = () ->
    apiKey = "xR9PQZeYGV7K40N8rXp_RpdJMjQXAgiD"

    post: (obj) ->
    put: (obj) ->
    get: (obj) ->
    getAll: (obj) ->
    delete: (obj) ->

  store.notifications = () ->
    post: ->
    put: ->
    get: ->
    getAll: ->
    delete: ->

  store.pusherNotifications = () ->
    post: ->
    put: ->
    get: ->
    getAll: ->
    delete: ->
)

