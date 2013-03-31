common = window.BC.namespace("common")
model = window.BC.namespace("model")

$.extend(this, common, model)

t = tag("span", class: 'class1', id: 'span1')

describe("Tag tests", ->

  it("Tests constructor", ->
    expect(t().html()).toBe("<span id='span1' class='class1'></span>")
    expect(t("value").html()).toBe("<span id='span1' class='class1'>value</span>")
    expect(t(1, t(), undefined).html()).toBe("<span id='span1' class='class1'>1<span id='span1' class='class1'></span></span>")
  )

  it("Tests add class", ->
    span = t().addClass("class2").addClass("test test")
    expect(span.html()).toBe("<span id='span1' class='class1 class2 test test'></span>")
    expect(span.classes()).toBe("class1 class2 test test")
  )

  it("Tests add items", ->
    expect(t().addItems("value1", " value2").html()).toBe("<span id='span1' class='class1'>value1 value2</span>")
  )

  it("Tests add Attr", ->
    expect(t().addAttr(disabled: true).html()).toBe("<span id='span1' class='class1' disabled='disabled'></span>")
    expect(t().addAttr(disabled: false).html()).toBe("<span id='span1' class='class1'></span>")
    expect(t().addAttr(type: "text").html()).toBe("<span id='span1' class='class1' type='text'></span>")
  )

  it("Tests attributes", ->
    attr = common.attributes()
    expect(attr.get("class")).toBeUndefined()

    attr = common.attributes(class: "class1")
    expect(attr.get("class")).toBe("class1")

    attr.merge(class: "class2", type: "test")
    expect(attr.get("class")).toBe("class1 class2")
    expect(attr.get("type")).toBe("test")

    f = ->
    expect(-> attr.merge(html: f, init: f, class: "class3")).toThrow()
    expect(attr.get("class")).toBe("class1 class2")
  )

  it("Tests passing invalid argument to tag", ->
    a = tag("a")
    f = (x) -> x
    expect(-> a(null)).toThrow()
    expect(-> a(f)).toThrow()
  )
)