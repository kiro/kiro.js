docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.examples.index = () ->
  content = model(docs.examples.todomvc())

  div(
    div().span3(
      nav(
        a("Todo MVC", -> content(docs.examples.todomvc()))
        a("Players", -> content(docs.examples.players()))
      ).addClass('nav-list bs-docs-sidenav sidenav affix')
    )
    div().span9().bindHtml(content)
  )
