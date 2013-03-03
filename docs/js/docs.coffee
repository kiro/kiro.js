bootstrap = window.BC.namespace("bootstrap")
docs = window.BC.namespace("docs")

$.extend(this, bootstrap)

docs.example = (title, description, content) ->
  div(
    h2(title),
    p(description),
    content(),
    pre({class: 'prettyprint linenums', id: 'code ' + title})
  )

docs.body = (items...) ->
  div(items).addClass('bs-docs-example')

