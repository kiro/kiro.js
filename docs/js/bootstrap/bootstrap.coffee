docs = window.BC.namespace("docs")
docs.bootstrap = window.BC.namespace("docs.bootstrap")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.bootstrap.index = (content = docs.bootstrap.scaffolding()) ->
  div(
    div().span3(
      nav(
        a("Scaffolding", -> navigateTo('#/bootstrap/scaffolding/'))
        a("Tables", -> navigateTo('#/bootstrap/table/'))
        a("Typography", -> navigateTo('#/bootstrap/type/'))
        a("Buttons", -> navigateTo('#/bootstrap/buttons/'))
        a("Forms", -> navigateTo('#/bootstrap/forms/'))
        a("Navigation", -> navigateTo('#/bootstrap/nav/'))
      ).addClass('nav-list bs-docs-sidenav sidenav affix')
    )
    div().span9(content)
  )
