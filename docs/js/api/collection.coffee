docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

showCollection = ->

docs.collectionApi = -> section(h1("Collection"),
  docs.code.collection()
  p("Collection is a function and it's value can be set using <code>collection([1, 2, 3])</code> and get using <code>collection()</code> ")

  example(".add", """<p><code>.add(value)</code> Appends an item to the collection. </p>""", ->
    numbers = collection([1, 2, 3])
    value = model("")

    # This function will be used in all examples
    showCollection = (collection) ->
      div(class: 'circles')
        .foreach(collection, (item) ->
          div(class: 'circle', item).on('click', -> collection.remove(item))
        )

    body(
      showCollection(numbers)
      form.inline(
        input.text(value),
        button.success('Add', -> numbers.add(value("")))
      )
    )
  )

  example(".remove", """<p><code>.remove(item)</code> removes item.</p>
                        <p><code>.remove(predicate)</code> remove all items that match the predicate.</p>""", ->
    numbers = collection([1, 2, 3, 4, 5, 6])
    limit = model(3)

    biggerThan = (number) -> number > limit()

    body(
      form.inline(
        button.danger("Remove", -> numbers.remove(biggerThan)),
        " bigger than ",
        input.text(limit)
      ),
      "or click on a number to remove it",
      showCollection(numbers)
    )
  )

  example(".clear", "Removes all items from a collection.", ->
    numbers = collection([1, 2, 3, 4])

    body(
      showCollection(numbers)
      button.danger("clear", -> numbers.clear())
    )
  )

  example(".filter", """
                    Filters items from the collection. The filtered items are not removed and
                    once a new filter is set it's applied on all the initial items.

                    <p><code>.filter(predicate)</code> filters all items that match the predicate </p>
                    """, ->
    numbers = collection([1, 2, 3, 4, 5, 6])
    limit = model(3)

    biggerThan = (number) -> number > limit()

    body(
      showCollection(numbers)
      form.inline(
        button.danger("Filter", -> numbers.filter(biggerThan)),
        " bigger than ",
        input.text(limit).span1()
      )
    )
  )

  example(".count", """Counts the current items in a collection. If there is a filter it counts only the
                    items that match it.

                    <p><code>.count()</code> Returns the number of the current items in the collection.</p>
                    <p><code>.count(predicate)</code> Returns the number of the current items in the collection that match the predicate.</p>
                    """, ->
    numbers = collection([1, 2, 3, 4, 5, 6])
    numbers.filter((number) -> number > 2)

    body(
      "Click on a number to remove it",
      showCollection(numbers)

      span(map(numbers, -> 'Count ' + numbers.count()))
      span(map(numbers, -> 'Even ' + numbers.count((number) -> number % 2 == 0)))
    )
  )

  example(".total", """Counts all items in a collection, including the filtered.

                    <p><code>.total()</code> Returns the number of items in the collection.</p>
                    <p><code>.total(predicate)</code> Returns the number of items in the collection that match the predicate</p>
                    """, ->
    numbers = collection([1, 2, 3, 4, 5, 6])
    numbers.filter((number) -> number > 2)
    even = (number) -> number % 2 == 0

    body(
      "Click on a number to remove it",
      showCollection(numbers)
      p(map(numbers, -> "Showing #{numbers.count()} of #{numbers.total()}"))
      p(map(numbers, -> 'Even ' + numbers.total(even)))
    )
  )

  example(".replace", """Replaces an item in the collection""", ->
    numbers = collection([1, 2, 3, 4, 5, 6])
    from = model("")
    to = model("")

    body(
      showCollection(numbers),
      form.inline(
        button.warning("Replace", -> numbers.replace(parseInt(from()), parseInt(to()))),
        input.text(from).span1(),
        " with ",
        input.text(to).span1()
      )
    )
  )

  example(".get", """<p><code>get(index)</code> gets the item at index.</p>
                     <p><code>get(predicate)</code> gets the items matching the predicate.</p>
                  """, ->
    user = (id, name) ->
      id: id
      name: name

    users = collection([user(1, "Check"), user(2, "Test user"), user(3, "User 123")])
    byId = (id) -> ((user) -> user.id.toString() == id.toString())

    body(
      # TODO(kiro): make get to return the value directly if it's only one
      p("User 1 : ", users.get(byId(1))[0].name)
      p("User 2 : ", users.get(byId(2))[0].name)
    )
  )

  example(".sort", """<code>sort([optional]comparator)</code> Sorts the elements in the collection and maintains the collection in sorted order """, ->
    numbers = collection([2, 6, 3])
    numbers.sort()

    text = model("")
    body(
      "Click on a number to remove it"
      showCollection(numbers)
      form.inline(input.text(text), button("Add", -> numbers.add(Number(text()))))
    )
  )

  example(".subscribe", """<code>subscribe(handler)</code>Subscribes to changes in the collection. This includes changes to the models
                        within the collection. The subscription handler receives the items in the collection
                        and a string which describes the changed value.""", ->
    player = object(name: "Name", count: 0)
    count = model(2)
    pathModel = model("")
    values = model()

    players = collection([player, count, 3])
    players.subscribe((items, path) ->
      pathModel(path)
      values(JSON.stringify(items))
    )

    body(
      form(
        "Name": input.text(bind(player.name))
        "Count": input.text(bind(player.count))
      )
      form.inline(
        span(count),
        button("+1", -> count(count() + 1))
        button("-1", -> count(count() - 1))
      )
      "Path : ", span(pathModel)
      pre(code(values))
    )
  )
)