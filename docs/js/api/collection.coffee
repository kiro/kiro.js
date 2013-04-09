docs = window.BC.namespace("docs")
docs.api = window.BC.namespace("docs.api")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

showCollection = ->

docs.api.collection = -> section(h1("Collection"),
  docs.code.collection()

  example("collection", """
                        Collection contains items. If the items are models it subscribes to them
                        and the collection is updated when a model changes.
                        <p><code>items = collection(array)</code> constructs a new collection</p>
                        <p><code>items()</code> returns the values in the collection</p>
                        <p><code>items([1, 2, 3])</code> replaces all values in a collection</p>
                        """, ->
    items = collection([1, 2, 3])

    # This function will be used in all examples
    showCollection = (collection) ->
      div(class: 'circles')
        .foreach(collection, (item) ->
          div(class: 'circle', item).on('click', -> collection.remove(item))
        )

    body(
      showCollection(items)
      button('Set', -> items([4, 5, 6]))
    )
  )

  example(".add", """<p><code>.add(value)</code> adds an item to the collection. </p>""", ->
    numbers = collection([1, 2, 3])
    value = model("")

    body(
      showCollection(numbers)
      form.inline(
        input.text(value),
        button.success('Add', -> numbers.add(value("")))
      )
    )
  )

  example(".remove", """<p><code>.remove(item)</code> removes item</p>
                        <p><code>.remove(predicate)</code> remove all items that match the predicate.</p>""", ->
    numbers = collection([1, 2, 3, 4, 5, 6])
    limit = model(3)

    biggerThan = (value) -> ((number) -> number > value)

    body(
      form.inline(
        button.danger("Remove", -> numbers.remove(biggerThan(limit()))),
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
                    Filters items in the collection. The filtered items are not removed and
                    once a new filter is set it's applied on all of the initial items.

                    <p><code>.filter(predicate)</code> filters all items that match the predicate </p>
                    <p><code>.filter(string)</code> filters all objects who don't have string field containing the string</p>
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

  example(".find", """<p><code>.find(predicate)</code> gets the items matching the predicate.</p>
                      If there is only one match it returns the value.
                      If there are multiple matches it returns an array.
                   """, ->
    user = (id, name) ->
      id: id
      name: name

    users = collection([user(1, "Check"), user(2, "Test user"), user(3, "User 123")])
    byId = (id) -> ((user) -> user.id.toString() == id.toString())

    body(
      p(JSON.stringify(users.find(byId(1))))
      p(JSON.stringify(users.find((item) -> item.id > 1)))
    )
  )

  example(".sort", """<p>Sorts the elements in the collection and maintains the collection in sorted order.</p>
                      <p><code>sort()</code> sorts the items using default ordering.</p>
                      <p><code>sort(comparator)</code> sorts the items using a comparator.</p>
                   """, ->
    numbers = collection([2, 6, 3])
    numbers.sort()

    factor = 1
    comparator = (left, right) ->
      if left > right then 1 * factor
      else if left < right then -1 * factor
      else 0

    text = model("")
    body(
      "Click on a number to remove it"
      showCollection(numbers)
      form.inline(
        input.text(text),
        button.primary("Add", -> numbers.add(Number(text("")) if text()))
      )
      button.warning('Reverse sorting', ->
        factor *= -1
        numbers.sort(comparator)
      )
    )
  )

  example(".indexOf, .contains, .at", """
                                 <p><code>indexOf(item)</code> returns the index of an item in the collection or -1 if it's not present.</p>
                                 <p><code>contains(item)</code> returns true if an item is in the collection</p>
                                 <p><code>at(index)</code> returns the item at index</p>
                                 """, ->

    numbers = collection([1, 2, 3, 4, 5])
    result = model("")
    value = model("")

    body(
      showCollection(numbers)
      p(result)
      form.inline(
        input.text(value).span1()
        button('indexOf', -> result(numbers.indexOf(Number(value("")))))
        button('contains', -> result(numbers.contains(Number(value("")))))
        button('at', -> result(numbers.at(Number(value("")))))
      )
    )
  )
)