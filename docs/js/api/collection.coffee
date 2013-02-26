docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

# add, remove, removeAll, filter, count, total, replace, replaceAll, get, subscribe

section("Colection",
  example("Add", "It need the tabs bootstrap javascript to run correctly.", ->
    body(
    )
  )
)