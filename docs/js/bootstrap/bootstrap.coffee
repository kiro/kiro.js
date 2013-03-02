docs = window.BC.namespace("docs")
docs.bootstrap = window.BC.namespace("docs.bootstrap")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.bootstrap.index = () ->
  content = model(docs.bootstrap.scaffolding())

  div(
    div().span3(
      nav(
        a("Scaffolding", -> content(docs.bootstrap.scaffolding()))
        a("Tables", -> content(docs.bootstrap.table()))
        a("Typography", -> content(docs.bootstrap.type()))
        a("Buttons", -> content(docs.bootstrap.buttons()))
        a("Forms", -> content(docs.bootstrap.forms()))
        a("Navigation", -> content(docs.bootstrap.nav()))
      ).addClass('nav-list bs-docs-sidenav sidenav affix')
    )
    div().span9().bindHtml(content)
  )
