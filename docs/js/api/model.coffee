docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.modelApi = -> section(h1("Model"),
  docs.code.model()

  p("""Models are observable. Creating a model returns a function <code>text = model('Hello')</code>.
      To access the values of a model the function can be called <code>text() # -> Hello</code>.
      To set the value, the function is called with a parameter for the new value <code>text("New Value")</code>.
      When seeting the value of a model it returns the old value.
      Models has subscribe method which is used to listen to changes to models and generally is used in bindings.
    """)

  example("Observable primitive", "Making primitive values observable", ->
    count = model(0)
    text = model("")

    count.subscribe(-> text("Total count " + count()))

    body(
      button.primary("+1", -> count(count() + 1))
      span(text)
    )
  )

  example("Observable objects", """Using <code>models.object(obj)</code> makes a new object each field of
                                which is observable. Nested objects and arrays are converted to observables.
                                Changes to a field within the object are propagated upwards, so if you subscribe
                                ot an object changes to all fields and subfields will result in updating the object.""", ->
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
          span(map(obj.locations, -> obj.locations.toString()))
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
)