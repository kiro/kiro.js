controls = window.BC.namespace("controls")
m = window.BC.namespace("model")

$.extend(this, controls, m)

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

  it("Tests input element", ->
    value = model("test")

    $('.suite').append(element(
      div(
        input.text().bindValue(value),
        span().bindText(value)
      )
    ))
  )

  it("Tests simple list", ->
    item = model("")
    items = collection()

    $('.suite').append(element(
      div(
        input.text().bindValue(item),
        button('Add', ->
          items.push(item())
          item("")
        ),
        table(thead(tr(th("Value")))).foreach(items, (item) ->
          tr(td(item))
        )
      )
    ))
  )

  it("Displays different functions", ->
    f = model((x) -> x)

    $('.suite').append(element(div(
      button("x", -> f((x) -> x)),
      button("x^2", -> f((x) -> x*x / 100)),
      button("log", -> f((x) -> Math.log(x) * 20)),

      div(class: 'area').foreach([1..100], (x) ->
        div(class: 'point').bindCss(f, (fn) ->
          left: x + 'px'
          bottom: fn(x) + 'px'
        )
      )
    )))
  )
)
