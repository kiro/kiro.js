docs = window.BC.namespace("docs")
docs.api = window.BC.namespace("docs.api")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.api.index = (content = docs.api.model()) ->
  div(
    div().span3(
      nav(
        a("Model", -> navigateTo('#/api/model/'))
        a("Bindings", -> navigateTo('#/api/bindings/'))
        a("Collection", -> navigateTo('#/api/collection/'))
      ).addClass('nav-list bs-docs-sidenav sidenav affix')
    )
    div().span9(content)
  )