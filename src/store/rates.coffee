window.BC.define('rates', (rates) ->

  rates.NO_LIMIT = -1

  # the actions is idempotent by id, so if a value with the
  # same id gets added it keeps only the last one
  rates.idempotent = (id = (-> 1)) ->
    value = {}
    set: (newValue) ->
      value[id(newValue)] = newValue
    get: ->
      result = _.values(value)
      value = {}
      result

  # it aggregates the added values
  rates.aggregate = () ->
    value = []
    set: (newValue) ->
      if !_.isArray(newValue)
        newValue = [newValue]
      value = value.concat(newValue)
    get: ->
      result = value
      value = []
      result

  # returns a function that when called aggregates the value
  # according to the aggregator and calls action on timeout
  rates.rate = (action, request_rate, aggregator) ->
    hasTimeout = false
    (item) ->
      aggregator.set(item)
      if request_rate == rates.NO_LIMIT
        action(aggregator.get())
      else if !hasTimeout
        hasTimeout = true
        handler = ->
          action(aggregator.get())
          hasTimeout = false
        window.setTimeout(handler, 1000 / request_rate)
)



