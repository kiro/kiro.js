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

  example("Model example", "Model methods.", ->
    count = model(0)
    text = model("")

    count.subscribe(-> text("Total count " + count()))

    body(
      button.primary("+1", -> count(count() + 1))
      span().bindText(text)
    )
  )
)