window.BC.define('common', (common) ->

  common.attributes = (attr = {}) ->
    isAttributes: (obj) ->
      obj and not _.isArray(obj) and _.isObject(obj) and !_.isFunction(obj['html']) and !_.isFunction(obj['init'])

    merge: (attr2) ->
      if !this.isAttributes(attr2)
        return

      for key, value of attr2
        if attr[key]
          if _.isBoolean(value)
            attr[key] = attr2[key] if value
          else if _.isString(value)
            attr[key] = attr[key] + " " + attr2[key]
          else if _.isNumber(value)
            attr[key] = attr2[key]
          else if _.isUndefined(value)
          else
            throw Error("Unexpected value " + value)
        else
          attr[key] = attr2[key]

    render: () ->
      result = ""

      if attr['id']
        result += "id='#{attr['id']}'"

      for key, value of attr
        if key == 'id' then continue

        if _.isBoolean(value)
          if value then value = key
          else continue

        if result then result += " "
        result += "#{key}='#{value}'"
      result

    get: (name) -> attr[name]
)