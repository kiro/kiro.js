docs = window.BC.namespace("docs")
docs.bootstrap = window.BC.namespace("docs.bootstrap")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.bootstrap.index = (content = docs.bootstrap.scaffolding()) ->
  div(
    div().span3(
      nav(
        a(href: '#/bootstrap/scaffolding/', "Scaffolding")
        a(href: '#/bootstrap/table/', "Tables")
        a(href: '#/bootstrap/type/', "Typography")
        a(href: '#/bootstrap/buttons/', "Buttons")
        a(href: '#/bootstrap/forms/', "Forms")
        a(href: '#/bootstrap/nav/', "Navigation")
        docs.toLi
      ).addClass('nav-list bs-docs-sidenav sidenav affix')
    )
    div().span9(content)
  )
