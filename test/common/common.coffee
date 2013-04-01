common = window.BC.namespace("common")
models = window.BC.namespace("models")
util = window.BC.namespace("test.util")
bootstrap = window.BC.namespace("bootstrap")

$.extend(this, common, models, util, bootstrap)

describe("Bindings test", ->
  newListener = () ->
    calls = 0
    callback = () -> calls++
    callback.calls = () -> calls
    callback

  it("Tests subscribe", ->
    o = observable()
    listener = newListener()

    o.subscribe(listener)
    o.subscribe(listener)
    o.subscribe(listener)

    o.publish(1)
    expect(listener.calls()).toBe(1)

    o.publish(2)
    expect(listener.calls()).toBe(2)
  )

  it("Tests unsubscribe", ->
    o = observable()
    listener1 = newListener()
    listener2 = newListener()

    o.subscribe(listener1)
    o.subscribe(listener2)

    o.publish(1)
    expect(listener1.calls()).toBe(1)
    expect(listener2.calls()).toBe(1)

    o.unsubscribe(listener2)
    o.publish(1)
    expect(listener1.calls()).toBe(2)
    expect(listener2.calls()).toBe(1)
  )
)