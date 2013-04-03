common = window.BC.namespace("common")
models = window.BC.namespace("models")
util = window.BC.namespace("test.util")
bootstrap = window.BC.namespace("bootstrap")

$.extend(this, common, models, util, bootstrap)

describe("Bindings test", ->
  it("Empty test", ->)

  it("Tests dropdown button", ->
    value = ""
    show(
      dropdown(
        button("Test", -> value = "Button")
        a("Item1", -> value = "1")
        a("Item2", -> value = "2")

      )
    )
  )
)