controls = window.BC.namespace("controls")
m = window.BC.namespace("model")

$.extend(this, controls, m)

i = 0
number = model(i)

element(div("",
button("Test", -> number(++i)), span("0").bind(number)
))

describe("Models test", ->
  it("Mente", ->) # Empty test, so that the result of the first test can be attached

  i = 0
  number = model(i)

  it("Tests integer model", ->
    $('.suite').append(element(
      div("",
        button("Test", -> number(++i)), span().bind(number)
      )
    ))
  )
)