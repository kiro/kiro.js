docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.examples.index = (content = docs.examples.players()) ->
  div(
    div().span3(
      nav(
        a("Players", -> navigateTo('#/examples/players/'))
        a("Email", -> navigateTo('#/examples/email/'))
        a("Chat", -> navigateTo('#/examples/chat/'))
      ).addClass('nav-list bs-docs-sidenav sidenav affix')
    )
    div().span9(content)
  )
