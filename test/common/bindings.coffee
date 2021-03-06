common = window.BC.namespace("common")
models = window.BC.namespace("models")
util = window.BC.namespace("test.util")
bootstrap = window.BC.namespace("bootstrap")

$.extend(this, common, models, util, bootstrap)

describe("Bindings test", ->
  it("Empty test", ->)

  it("Tests tag model binding", ->
    value = model("test")

    show(
      span({id: 'span1'}, value)
    )

    el = $('#span1')
    expect(el.html()).toBe(value())
    value("Check check")
    expect(el.html()).toBe(value())

    content = model(div("Check"))

    show(
      div({id: 'content-div'}, content)
    )

    el = $('#content-div')
    expect(el.html()).toBe("<div>Check</div>")
    content(span("Test"))
    expect(el.html()).toBe("<span>Test</span>")
    content("Text")
    expect(el.html()).toBe("Text")
  )

  it("Tests value binding", ->
    value = model("test")
    text = input.text(value)

    show(
      text,
      span(value)
    )

    expect(value()).toBe("test")

    text.el().val("check check")
    text.el().change()
    expect(value()).toBe("check check")

    value('mente')
    expect(text.el().val()).toBe('mente')
  )

  it("Tests css binding", ->
    size = model(10)

    orange = div(class: 'orange', "Click me!")
      .on('click', -> size(size() + 10))
      .bindCss(size, -> width: size(), height: size())

    show(orange)

    expect(orange.el().css('height')).toBe("10px")
    orange.el().click()
    expect(orange.el().css('height')).toBe("20px")
    orange.el().click()
    expect(orange.el().css('height')).toBe("30px")
  )

  it("Tests class binding", ->
    isOrange = model(false)

    div1 = div(class: 'box')
      .bindClass(isOrange, -> 'orange' if isOrange())

    count = model(5)
    div2 = div(class: 'box')
      .bindClass(count, -> 'orange' if count() == 5)

    show(div1, div2)

    expect(div1.el().hasClass('orange')).toBe(false)
    isOrange(true)
    expect(div1.el().hasClass('orange')).toBe(true)

    expect(div2.el().hasClass('orange')).toBe(true)
    count(4)
    expect(div2.el().hasClass('orange')).toBe(false)
  )

  it("Tests text binding", ->
    value = model("Check")
    text = span().bindText(value)
    show(text)

    expect(text.el().text()).toBe("Check")
    value("Mente")
    expect(text.el().text()).toBe("Mente")
  )

  it("Tests html binding", ->
    value = model("")
    val = span().bindHtml(value)
    show(val)
    value("<h1>Check</h1>")

    expect(val.el().html()).toBe("<h1>Check</h1>")
    value(h2("Mente"))
    expect(val.el().html()).toBe("<h2>Mente</h2>")
  )

  it("Tests disabled binding", ->
    isDisabled = model(false)
    btn1 = button("Button1").bindDisabled(isDisabled)

    count = model(5)
    btn2 = button("Button2").bindDisabled(count, -> count() == 5)

    show(btn1, btn2)
    expect(btn1.el().attr('disabled')).toBeFalsy()
    isDisabled(true)
    expect(btn1.el().attr('disabled')).toBe('disabled')

    expect(btn2.el().attr('disabled')).toBe('disabled')
    count(10)
    expect(btn2.el().attr('disabled')).toBeFalsy()
  )

  it("Tests visible binding", ->
    isVisible = model(true)
    box = div(class: 'box').bindVisible(isVisible)

    show(box)
    expect(box.el().css('display')).toBe("block")
    isVisible(false)
    expect(box.el().css('display')).toBe("none")
    isVisible(true)
    expect(box.el().css('display')).toBe("block")
  )

  it("Tests foreach binding", ->
    values = collection([1, 2, 3])

    list = div("Test").foreach(values, (value) -> value)

    show(list)

    expect(list.el().text()).toBe("Test123")
    values([4, 5, 6])
    expect(list.el().text()).toBe("Test456")

    expectedIndex = 0
    list = div("Mente").foreach(values, (value, index) -> expect(index).toEqual(expectedIndex++))
  )

  it("Tests binding to boolean", ->
    value = model(false)

    show(
      span({id: 'span2'}, value)
    )

    el = $('#span2')
    expect(el.html()).toBe("false")
    value(true)
    expect(el.html()).toBe("true")
  )
)