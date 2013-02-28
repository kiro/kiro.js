docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.api = () ->
  content = model("")

  div(
    div().span3(
      pills.stacked(
        pill("Bindings", -> content(docs.bindings()))
        pill("Collection", -> content(docs.collection()))
        pill("Model", -> content(docs.model()))
      )
    )
    div().span9().bindHtml(content)
  )
