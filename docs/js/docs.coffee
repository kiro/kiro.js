bootstrap = window.BC.namespace("bootstrap")
docs = window.BC.namespace("docs")

$.extend(this, bootstrap)

docs.example = (title, description, content) ->
  div(
    h2(title),
    p(description),
    content(),
    docs.code()
  )

docs.body = (items...) ->
  div(items).addClass('bs-docs-example')

docs.code = (code) ->
  pre({class: 'prettyprint linenums'}, code)

