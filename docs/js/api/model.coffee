docs = window.BC.namespace("docs")
docs.api = window.BC.namespace("docs.api")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.api.model = -> section(h1("Models"),
  docs.code.model()

  example("model", """Creates an observable value.
                   <p><code>x = model(value)</code> creates a new observable.</p>
                   <p><code>x()</code> gets the value. </p>
                   <p><code>x(newValue)</code> sets a new value </p>
                   <p>Observable values can be bound to properties of the dom elements
                   and they will be automatically updated when the value changes.<p>
                   """, ->
    count = model(0)
    text = map(count, -> "Total count " + count())

    body(
      button.primary("+1", -> count(count() + 1))
      span(text)
    )
  )

  example("object", """<p><code>object(obj)</code> - converts a javascript object to observable</p>
                       <p>It creates a model for the object itself and for each field recursively.
                          All fields and subfields can be bound to. Arrays are converted to collections.</p>
                       <p> <code>obj.field += 1</code> fields can be accessed normally. </p>
                       <p> <code>bind(obj.field)</code> returns the model for a field. </p>

                       <p> If a field or sub field in an object is changed, the change is propagated through all observables up to the root object.<p>
                    """, ->
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
)