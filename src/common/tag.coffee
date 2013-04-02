window.BC.define('common', (common) ->
  # TODO(kiro): make it to take extensions
  common.tag = (name, initialAttr = {}) ->
    (items...) ->
      attr = common.attributes(_.clone(initialAttr))

      # merge the attributes
      if items.length > 0 and attr.isAttributes(items[0])
        attr.merge(items[0])
        items = _.rest(items)

      # if there is only item which is model, bind the html of the tag to it
      if items.length == 1 && common.isModel(items[0])
        o = items[0]
        items.pop()
      else
        for item in items
          if common.isModel(item)
            throw Error(items + " should have only one model")

      # check that the items are valid
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

        classes: () -> attr.get('class')
      )

      if o then result.bindHtml(o)

      result
)