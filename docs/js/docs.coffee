bootstrap = window.BC.namespace("bootstrap")
docs = window.BC.namespace("docs")
models = window.BC.namespace("models")

$.extend(this, bootstrap)

docs.example = (title, description, content, attr = {}) ->
  div(attr,
    h2(title),
    p(description),
    content(),
    pre({class: 'prettyprint linenums', id: 'code ' + title})
  )

docs.body = (items...) ->
  div(items).addClass('bs-docs-example')

docs.currentLocation = models.model(location.hash)

isActive = (link) ->
  if docs.currentLocation()
    return docs.currentLocation().indexOf(link.getAttr('href')) == 0

docs.toLi = (link) -> li(link)
  .bindClass(docs.currentLocation, -> 'active' if isActive(link))
  .onUpdate((el) ->
    if el.hasClass('active')
      el.parent().parent().find('li').removeClass('active')
      el.addClass('active')
  )
