docs = window.BC.namespace("docs")
docs.api = window.BC.namespace("docs.api")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.api.index = () ->
  content = model(docs.api.model())

  div(
    div().span3(
      nav(
        a("Model", -> content(docs.api.model()))
        a("Bindings", -> content(docs.api.bindings()))
        a("Collection", -> content(docs.api.collection()))
      ).addClass('nav-list bs-docs-sidenav sidenav affix')
    )
    div().span9().bindHtml(content)
  )