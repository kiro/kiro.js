docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.models = -> section("Model",
  example("Add", "It need the tabs bootstrap javascript to run correctly.", ->
    body(
    )
  )
)