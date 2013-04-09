docs = window.BC.namespace("docs")
docs.api = window.BC.namespace("docs.api")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")
store = window.BC.namespace("store")

$.extend(this, bootstrap, models, docs, store)

docs.api.html = -> section(h1("Html templating."),
  docs.code.html()

  p("""Building html templates.""")

  example("Tags", """Each html tag has a corresponding function.""", ->
    div(id: 'items', class: 'something'

    )
  )

  example("Tag builder", """Each tag has a builder methods for customization""", ->
  )
)