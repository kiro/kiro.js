docs = window.BC.namespace("docs")
docs.api = window.BC.namespace("docs.api")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.api.model = -> section(h1("Model"),
  docs.code.model()

  p("""Models constructs observables from values or objects.""")

  example("Model", """Creates an observable value. <code>x = model(value)</code> creates a new observable.
                   Calling <code>x()</code> gets the value of the observable. <code>x(newValue)</code> sets
                   the value of the observable. Observable values can be bound to properties of the dom elements
                   and they will be automatically updated when the value changes.
                   """, ->
    count = model(0)
    text = model("")

    count.subscribe(-> text("Total count " + count()))

    body(
      button.primary("+1", -> count(count() + 1))
      span(text)
    )
  )

  example("Object", """Using <code>object(obj)</code> makes a new object each field of
                       which is observable. Nested objects are also converted to observable
                       and nested arrays to collection, the objects it arrays are also converted to
                       observables. To get the observable for a field <code>bind(obj.field)</code> must
                       be used. Changes to a field within the object are propagated upwards,
                       so if you subscribe to an object changes to all fields and subfields will
                       result calling the subscription.""", ->
    obj = object(
      name: "Kiril Minkov"
      cool: true
      age: 25
      locations: ["London", "Cambridge"]
      language:
        name: "Bulgarian"
        native: false
    )

    location = model("")
    body(
      form(
        "Name": input.text(bind(obj.name))
        "Cool": input.checkbox(bind(obj.cool))
        "Age": input.text(bind(obj.age))
        "Locations" : [
          div().foreach(obj.locations, (location) ->
            span(
              type.label(location).on('click', -> obj.locations.remove(location))
              "&nbsp;"
            )
          )
          append(
            input.text(location).placeholder("Add location...")
            button("Add", -> obj.locations.add(location("")))
          )
        ]
        "Language": input.text(bind(obj.language.name))
        "Native": input.checkbox(bind(obj.language.native))
      )

      pre(code(map(obj, -> JSON.stringify(obj, null, 4))))
    )
  )

  example("Map", "Creates a new model that maps the value of a model. ", ->
    count = object(value: 1)

    body(
      button("+1", -> count.value++)
        .bindDisabled(map(bind(count.value), -> count.value > 3))
      span(bind(count.value))
    )
  )
)