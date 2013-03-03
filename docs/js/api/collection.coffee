docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

showCollection = ->

docs.collectionApi = -> section(h1("Collection"),
  docs.code.collection()
  p("Collection is a function and it's value can be set using <code>collection([1, 2, 3])</code> and get using <code>collection()</code> ")

  example(".add", """<p><code>.add(value)</code> <code>.add(1)</code>Appends an item to the collection. </p>
                     <p><code>.add(values)</code> <code>.add(1, 2, 3)</code>Appends a comma separated list of items. </p>
                     <p><code>.add(array)</code> <code>.add([1, 2, 3])</code>Appends items in the array. </p>""", ->
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
        input.text().bindValue(value),
        button.success('Add', -> numbers.add(value("")))
      )
    )
  )

  example(".remove", """<p><code>.remove(value)</code> removes items that have the same value.</p>
                        <p><code>.remove(predicate)</code> remove all items for which the predicate function returns true.</p>""", ->
    numbers = collection([1, 2, 3, 4, 5, 6])
    limit = model(3)

    biggerThan = (number) -> number > limit()

    body(
      form.inline(
        button.danger("Remove", -> numbers.remove(biggerThan)),
        " bigger than ",
        input.text().bindValue(limit)
      ),
      "or click on a number to remove it",
      showCollection(numbers)
    )
  )

  example(".removeAll", "Removes all numbers from a collection.", ->
    numbers = collection([1, 2, 3, 4])

    body(
      showCollection(numbers)
      button.danger("Remove all", -> numbers.removeAll())
    )
  )

  example(".filter", """
                    Filters items from the collection. The filtered items are not removed and
                    once a new filter is set it's applied on all the initial items.

                    <p><code>.filter(predicate)</code> filters all items for which predicate returns false </p>
                    """, ->
    numbers = collection([1, 2, 3, 4, 5, 6])
    limit = model(3)

    biggerThan = (number) -> number > limit()

    body(
      showCollection(numbers)
      form.inline(
        button.danger("Filter", -> numbers.filter(biggerThan)),
        " bigger than ",
        input.text().span1().bindValue(limit)
      )
    )
  )

  example(".count", """Counts the current number of items in a collection. If there is a filter it counts only the
                    items that match it.

                    <p><code>.count()</code> Returns the number of the current items in the collection.</p>
                    <p><code>.count(predicate)</code> Returns the number of the current items in the collection that match the predicate</p>
                    """, ->
    numbers = collection([1, 2, 3, 4, 5, 6])
    numbers.filter((number) -> number > 2)

    body(
      "Click on a number to remove it",
      showCollection(numbers)

      span().bindText(numbers, -> 'Count ' + numbers.count())
      span().bindText(numbers, -> 'Even ' + numbers.count((number) -> number % 2 == 0))
    )
  )

  example(".total", """Counts all the items in a collection, including the filtered.

                    <p><code>.total()</code> Returns the number of items in the collection.</p>
                    <p><code>.total(predicate)</code> Returns the number of items in the collection that match the predicate</p>
                    """, ->
    numbers = collection([1, 2, 3, 4, 5, 6])
    numbers.filter((number) -> number > 2)
    even = (number) -> number % 2 == 0

    body(
      "Click on a number to remove it",
      showCollection(numbers)
      p().bindText(numbers, -> "Showing #{numbers.count()} of #{numbers.total()}")
      p().bindText(numbers, -> 'Even ' + numbers.total(even))
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
        input.text().span1().bindValue(from),
        " with ",
        input.text().span1().bindValue(to)
      )
    )
  )

  example(".replaceAll", """Replaces all items in the collection.""", ->
    numbers = collection([1, 2, 3, 4, 5])

    body(
      showCollection(numbers)
      button.danger("Replace all", -> numbers.replaceAll([7, 8, 9]))
    )
  )

  example(".get", """Gets an item matching a predicate""", ->
    user = (id, name) ->
      id: id
      name: name

    users = collection(user(1, "Bai Mangau"), user(2, "Test user"), user(3, "Mente"))
    byId = (id) -> ((user) -> user.id.toString() == id.toString())

    body(
      # TODO(kiro): make get to return the value directly if it's only one
      p("User 1 : ", users.get(byId(1))[0].name)
      p("User 2 : ", users.get(byId(2))[0].name)
    )
  )

  example(".subscribe", """Subscribes to changes in the collection, useful for building custom controls""", ->
    numbers = collection(1, 2, 3, 4, 5, 6)
    text = model("Total length " + numbers.count())
    numbers.subscribe((items) -> text("Total length " + items.length))

    body(
      "Click on a number to remove it"
      showCollection(numbers)
      span().bindText(text)
    )
  )
)