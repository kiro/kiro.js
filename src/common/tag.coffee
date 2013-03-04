window.BC.define('common', (common) ->

  # TODO(kiro): make it to take extensions
  common.tag = (name, initialAttr = {}) ->
    (items...) ->
      attr = common.attributes(_.clone(initialAttr))

      if items.length > 0 and attr.isAttributes(items[0])
        attr.merge(items[0])
        items = _.rest(items)

      bindings = common.bindings(_.clone(items))
      $.extend(bindings,
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

)