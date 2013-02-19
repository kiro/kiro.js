bootstrap = window.BC.namespace("bootstrap")
docs = window.BC.namespace("docs")

$.extend(this, bootstrap)

docs.section = (title, items...) ->
  $('#examples').append(element(bootstrap.section(h1(title), items)))

docs.example = (title, description, content) ->
  div(
   h2(title),
   p(description),
   content(),
   docs.code()
  )

docs.body = (items...) ->
  div({class: 'bs-docs-example'}, items)

docs.code = (code) ->
  pre({class: 'prettyprint linenums'}, code)

