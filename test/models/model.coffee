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
    bind(obj.firstName).subscribe(-> firstCalls++)
    lastCalls = 0
    bind(obj.lastName).subscribe(-> lastCalls++)

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
    bind(obj.language).subscribe(-> languageCalls++)
    languageNameCalls = 0
    bind(obj.language.name).subscribe(-> languageNameCalls++)
    obj.language.name = "Test"
    expect(objCalls).toBe(2)
    expect(languageCalls).toBe(1)
    expect(languageNameCalls).toBe(1)
  )

  it("Tests map", ->
    value = model(0)
    mapped = models.map(value, -> if value() < 3 then "Less than 3" else "Bigger than 3")

    expected = "Less than 3"
    calls = 0
    mapped.subscribe((val) ->
      calls++
      expect(val).toEqual(expected)
    )
    value(2)
    expect(calls).toBe(1)
    value(1)
    expect(calls).toBe(2)
    expected = "Bigger than 3"
    value(3)
    expect(calls).toBe(3)
    value(4)
    expect(calls).toBe(4)
  )

  it("Tests path", ->
    obj = object(
      name: "Test"
      checked: true
      numbers: [1, 2, 3]
      sub: [
        {key: "key1", value: "value1"}
        {key: "key2", value: "value2"}
      ]
      subsub:
        name:
          first: "Kiril"
          last: "Minkov"
        age: "I don't want to think about it"
    )

    expectedPath = ""
    calls = 0
    obj.subscribe((value, path) ->
      console.log(path)
      expect(path).toEqual(expectedPath)
      calls++
    )
    expectedPath = "name"
    obj.name = "Mente"
    expect(calls).toBe(1)

    expectedPath = "checked"
    obj.checked = false
    expect(calls).toBe(2)

    expectedPath = "numbers.add"
    obj.numbers.add(4)
    expect(calls).toBe(3)

    expectedPath = "sub.update"
    obj.sub.get(0).key = "kkk"
    expect(calls).toBe(4)

    expectedPath = "sub.update"
    obj.sub.get(0).value = "vvv"
    expect(calls).toBe(5)

    expectedPath = "subsub.name.first"
    obj.subsub.name.first = "first"
    expect(calls).toBe(6)

    expectedPath = "subsub.age"
    obj.subsub.age = 30
    expect(calls).toBe(7)
  )

  it("Tests negate", ->
    visible = model(false)

    notVisible = models.negate(visible)

    expected = false
    calls = 0
    notVisible.subscribe((value) ->
      calls++
      expect(value).toEqual(expected)
    )

    expect(notVisible.get()).toEqual(true)
    visible(true)
    expect(calls).toEqual(1)
    expected = true
    visible(false)
    expect(calls).toEqual(2)
  )

  it("Tests a bug with set", ->
    obj = object(
      name:
        key: "key"
        value: false
    )

    expect(obj.name.value).toBe(false)
    bind(obj.name.value).set(true)
    expect(obj.name.value).toBe(true)
  )

  it("Tests a trivial object", ->
    obj = object(
      value : 1
    )

    calls = 0
    obj.subscribe(-> calls++)
    obj.value = 2
    expect(calls).toBe(1)
  )

  it("Tests bind", ->
    obj = object(
      name: "Test"
      value:
        check: false
        name: "name"
    )

    check = bind(obj.value.check)
    expect(obj.value.check).toBe(false)
    check.set(true)
    expect(obj.value.check).toBe(true)
  )
)