window.BC.define('common', (common) ->
  # TODO(kiro): make it to take extensions
  common.tag = (name, initialAttr = {}) ->
    (items...) ->
      attr = common.attributes(_.clone(initialAttr))

      if items.length > 0 and attr.isAttributes(items[0])
        attr.merge(items[0])
        items = _.rest(items)

      index = 0
      for item in items
        index++
        if !isValid(item)
          throw Error("Item " + item + " at position " + index + " is expected to be String, Number, Array, undefined" +
            " or have .html() function")

      bindings = common.bindings(_.clone(items))
      result = $.extend(bindings,
        id: () -> attr.get('id')
        html: () ->
          _.template("""
            <#{name} <%=attr%>><% _.each(items, function(item) { %><%=toHtml(item)%><% }) %></#{name}>
           """, {items: items, toHtml: common.toHtml, attr: attr.render()})
        init: (context) ->
          common.init(items, context)
          id = this.id()

          if id and context.attr('id') == id.toString()
            el = context
          else
            el = context.find('#' + id).first() if id
          bindings.initBindings(el)

        addClass: (name) ->
          if name
            attr.merge(class: name)
          this

        addItems: (newItems...) ->
          items = items.concat(newItems)
          this

        addClassAndItems: (name, items...) ->
          this.addClass(name)
          this.addItems(items...)

        addAttr: (value) ->
          attr.merge(value)
          this

        observable: () ->
          $.extend(this, common.observable())
          this

        classes: () -> attr.get('class')
      )

      map = (observable, map = (x) -> x) ->
        value = map(observable._get())

        _get: () -> value
        _set: (newValue) -> throw Error("_set is not supported for mapped values")
        subscribe: (callback) -> observable.subscribe(
          (baseValue) ->
            value = map(baseValue)
            callback(value)
        )

      if items.length == 1 && common.isModel(items[0])
        result.bindHtml(items[0])
      else
        for item in items
          if common.isModel(item)
            throw Error(items + " should have only one model")

      result
)