controls = window.BC.namespace("controls")
m = window.BC.namespace("model")

$.extend(this, controls, m)

$('body').append(element(button('test', -> console.log('test'))))

describe("Models test", ->
  it("", ->) # Empty test, so that the result of the first test can be attached

  it("Tests attr, css and text bindings", ->
    number = model(0)

    selectColor = (value) ->
        if value > 6 then 'red'
        else if value > 3 then 'orange'
        else 'green'

    $('.suite').append(element(
      div(
        button("Test", -> number(number() + 1))
          .bindDisabled(number, -> number() == 10),
        span()
          .bindText(number)
          .bindCss(number, -> color: selectColor(number()))
      ))
    )
  )

  it("Tests visible and html bindings", ->
    number = model(0)

    isThree = -> number() == 3

    $('.suite').append(element(
      div(
        p("You've clicked ", span("").bindText(number), " times"),
        button("Click me", -> number(number() + 1)).bindDisabled(number, isThree),
        p("That's too many clicks! Please stop before you wear out your fingers. ",
          button('Reset Clicks', -> number(0)))
            .bindVisible(number, isThree)
      )
    ))
  )

)
