common = window.BC.namespace("common")
html = window.BC.namespace("html")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")
store = window.BC.namespace("store")

$.extend(this, html, common, bootstrap, models, store)

body(
  h1("Make something awesome!")
)
