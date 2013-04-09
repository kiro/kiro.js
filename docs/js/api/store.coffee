docs = window.BC.namespace("docs")
docs.api = window.BC.namespace("docs.api")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.api.store = -> section(h1("Store"),
  docs.code.store()

  p("""Storing and syncing collections.""")

  example("model", """Creates an observable value.""", ->
  )
)
