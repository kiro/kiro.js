window.BC.define('common', (common) ->

  common.bindings = (initialItems) ->
    _el = null
    initializers = []
    updateHandlers = []

    identity = (x) -> x

    el = (value) -> if !_.isUndefined(value) then _el = value else _el

    domUpdated = () -> handler(_el) for handler in updateHandlers

    # Adds a initializer, which is a jquery call.
    addInitializer = (initializer) ->
      this.addAttr(id: common.nextId()) if not this.id()
      initializers.push(initializer)
      this

    binder = (f, defaultMap = identity) ->
      (observable, map = defaultMap) ->
        addInitializer.call(this, ->
          el()[f](map(observable.get()))
          domUpdated()
        )
        addInitializer.call(this, -> observable.subscribe( (newValue) ->
          el()[f](map(newValue))
          domUpdated()
        ))
        this

    initBindings: (element) ->
      el(element)

      for initializer in initializers
        initializer()

    setValue: ->

    # Binds the value of an element to an observable
    bindValue: (observable) ->
      valueHandler = (newValue) ->
        el().val(newValue)
        domUpdated()

      this.setValue = (newValue) ->
        observable.unsubscribe(valueHandler)
        observable.set(newValue)
        observable.subscribe(valueHandler)

      addInitializer.call(this, ->
        el().val(observable.get())
        domUpdated()
      )
      addInitializer.call(this, -> observable.subscribe(valueHandler))
      this

    # Binds the text of an element
    bindText: binder('text')

    # Binds the html of an element
    bindHtml: binder('html', (x) -> element(x))

    # Binds the css properties of an element
    bindCss: binder('css')

    # Binds the class of an element
    bindClass: (observable, map = (x) -> x) ->
      this.addAttr(id: common.nextId()) if !this.id()
      prevClass = map(observable.get())
      this.addAttr(class: prevClass)

      observable.subscribe((value) ->
        el().removeClass(prevClass)
        prevClass = map(value)
        el().addClass(prevClass)
        domUpdated()
      )
      this

    # Binds whether an element is visible
    bindVisible: (observable, condition = identity) ->
      this.bindCss(observable, (value) ->
        display: if condition(value) then "" else "none"
      )

    # Binds whether an element is disabled
    bindDisabled: (observable, condition = (x) -> x) ->
      this.bindAttr(observable, (value) -> disabled: condition(value))

    # Binds the attributes of an element
    bindAttr: binder('attr')

    # Adds event handlers, jquery style
    on: (events, selector, handler) ->
      if !handler
        handler = selector
        selector = ""

      addInitializer.call(this, => el().on(events, selector, this, handler))
      this

    # Calls the handler when the dom is updated from a binding
    onUpdate: (handler) ->
      updateHandlers.push(handler)
      this

    # Binds the content of an element to collection
    foreach: (collection, render) ->
      # HACK: needed because when there is a table tag, the content is automatically wrapped in tbody
      getElOrTbody = () ->
        tbody = el().children('tbody')
        if tbody.length != 0 then tbody else el()

      tag = this
      this.addAttr(id: common.nextId()) if !this.id()

      collectionItems =
        if _.isFunction(collection) then collection()
        else if _.isArray(collection) then collection
        else throw Error(collection + " is expected to be an Array or model")

      index = 0
      this.addItems((render(item, index++) for item in collectionItems)...)

      add = (value, index) ->
        if index == -1 then return
        if getElOrTbody().children().length == 0 or index == 0
          getElOrTbody().prepend(common.element(render(value, index, tag)))
        else
          getElOrTbody().children().eq(index - 1).after(common.element(render(value, index, tag)))
        domUpdated()

      remove = (index) ->
        getElOrTbody().children().eq(index).remove()
        domUpdated()

      renderAll = (items) ->
        index = 0
        elements = (common.element(item) for item in initialItems)
        elements = elements.concat( (common.element(render(item, index++)) for item in items) )
        el().html(elements)
        domUpdated()

      removeItems = (items, indexes) ->
        indexes = indexes.sort().reverse()
        remove(index) for index in indexes

      updateItem = (value, index, oldIndex) ->
        if index < oldIndex
          add(value, index)
          remove(oldIndex + if index == -1 then 0 else 1)
        else if index > oldIndex
          remove(oldIndex)
          add(value, index)

      if _.isFunction(collection.subscribe)
        collection.subscribe( collection.actionHandler(
          replaceAll: renderAll
          updateView: renderAll
          add: add
          remove: removeItems
          update: updateItem
        ))
      this

    # Gets the jquery dom element of the html element, sued mostly for testing, in practice
    # it shouldn't be needed
    el: el
)