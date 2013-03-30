common = window.BC.namespace("common")
models = window.BC.namespace("models")
util = window.BC.namespace("test.util")
bootstrap = window.BC.namespace("bootstrap")

$.extend(this, common, models, util, bootstrap)

describe("Bindings test", ->
  it("Tests observable", ->
    o = observable()
    calls = 0
    listener = () -> calls++

    o.subscribe(listener)
    o.subscribe(listener)
    o.subscribe(listener)

    o.publish(1)
    expect(calls).toBe(1)

    o.publish(2)
    expect(calls).toBe(2)
  )
)