docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.api = () ->
  content = model(docs.bindingsApi())

  div(
    div().span3(
      nav(
        a("Bindings", -> content(docs.bindingsApi()))
        a("Collection", -> content(docs.collectionApi()))
        a("Model", -> content(docs.modelApi()))
      ).addClass('nav-list bs-docs-sidenav sidenav affix')
    )
    div().span9().bindHtml(content)
  )
