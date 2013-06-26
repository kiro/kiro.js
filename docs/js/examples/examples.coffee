docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.examples.index = (content = docs.examples.players()) ->
  div(
    div().span3(
      nav(
        a(href: '#/examples/players/', "Players")
        a(href: '#/examples/email/', "Email")
        a(href: '#/examples/chat/', "Chat")
        a(href: '#/examples/game/', "Game")
        a(href: '#/examples/projects/', "Projects")
        a(href: '#/examples/hailoChat/', "Hailo Chat")
        docs.toLi
      ).addClass('nav-list bs-docs-sidenav sidenav affix')
    )
    div().span9(content)
  )
