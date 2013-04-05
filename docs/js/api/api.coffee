docs = window.BC.namespace("docs")
docs.api = window.BC.namespace("docs.api")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.api.index = (content = docs.api.model()) ->
  div(
    div().span3(
      nav(
        a(href: '#/api/model/', "Model")
        a(href: '#/api/bindings/', "Bindings")
        a(href: '#/api/collection/', "Collection")
      ).addClass('nav-list bs-docs-sidenav sidenav affix')
    )
    div().span9(content)
  )