common = window.BC.namespace("common")
models = window.BC.namespace("models")
util = window.BC.namespace("test.util")

$.extend(this, common, models, util)

describe("Model tests", ->
  it("Tests model", ->
    flag = model(true)

    expect(flag()).toBe(true)

    subscriptionCalls = 0
    expectedValue = false

    flag.subscribe((value) ->
      subscriptionCalls++
      expect(value).toBe(expectedValue)
    )

    flag(false)
    expect(subscriptionCalls).toBe(1)

    expectedValue = 1
    flag(1)
    expect(subscriptionCalls).toBe(2)

    expectedValue = "test"
    flag("test")
    expect(subscriptionCalls).toBe(3)
    expectedValue = "new"
    expect(flag("new")).toEqual("test")
  )
)