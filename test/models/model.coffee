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

    expectedValue = ""
    expect(flag("")).toEqual("new")
    expect(flag()).toEqual("")
  )

  it("Tests object observable", ->
    obj = models.object(
      firstName: "Kiril"
      lastName: "Minkov"
    )

    objCalls = 0
    obj.subscribe(-> objCalls++)
    firstCalls = 0
    obj.firstName.subscribe(-> firstCalls++)
    lastCalls = 0
    obj.lastName.subscribe(-> lastCalls++)

    obj.firstName = "Test"
    expect(firstCalls).toBe(1)
    expect(objCalls).toBe(1)
    expect(lastCalls).toBe(0)

    obj.lastName = "Mente"
    expect(firstCalls).toBe(1)
    expect(lastCalls).toBe(1)
    expect(objCalls).toBe(2)

    obj.lastName = "Mente"
    expect(firstCalls).toBe(1)
    expect(lastCalls).toBe(2)
    expect(objCalls).toBe(3)
  )

  it("Tests array observable", ->
    arr = models.array([1, 4, 2])
    calls = 0
    arr.subscribe(-> calls++)

    arr.push(1)
    expect(calls).toBe(1)
    expect(arr.toString()).toEqual([1, 4, 2, 1].toString())
    arr.pop()
    expect(arr.toString()).toEqual([1, 4, 2].toString())
    expect(calls).toBe(2)
    arr.sort()
    expect(calls).toBe(3)
    expect(arr.toString()).toEqual([1, 2, 4].toString())
  )

  it("Tests nested object observable", ->
    obj = models.object(
      firstName: "Kiril"
      lastName: "Minkov"
      cities: ["Plovdiv", "Sofia", "San Francisco", "London"]
      language: {
        name: "Bulgarian"
        confidence: "Profficient"
      }
    )

    objCalls = 0
    obj.subscribe(-> objCalls++)
    expect(objCalls).toBe(0)
    obj.firstName = "Mente"
    expect(objCalls).toBe(1)
    languageCalls = 0
    obj.language.subscribe(-> languageCalls++)
    languageNameCalls = 0
    obj.language.name.subscribe(-> languageNameCalls++)
    obj.language.name = "Test"
    expect(objCalls).toBe(2)
    expect(languageCalls).toBe(1)
    expect(languageNameCalls).toBe(1)
  )
)