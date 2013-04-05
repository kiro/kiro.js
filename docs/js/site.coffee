bootstrap = window.BC.namespace("bootstrap")
docs = window.BC.namespace("docs")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models)

content = model(docs.home.index())

site = div.container(
  navbar(
    div.container(
      navbar.brand("kiro.js")
      nav(
        a(href: '#/', "Home")
        a(href: '#/api/', "Api")
        a(href: '#/bootstrap/', "Bootstrap")
        a(href: '#/examples/', "Examples")
      )
    )
  ).inverse().fixedTop()
  div.row().bindHtml(content)
)

app = Sammy('body', ->
  this.get('#/', -> content(docs.home.index()))
  this.get('#/:first/', ->
    first = this.params['first']
    content(docs[first]['index']()))
  this.get('#/:first/:second/', ->
    first = this.params['first']
    second = this.params['second']
    content(docs[first].index(docs[first][second]()))
  )
)

app.raise_errors = true

$(-> app.run('#/'))

$('body').append(
  element(
    site
  )
)