controls = window.BC.namespace("controls")
m = window.BC.namespace("model")

$.extend(this, controls, m)

describe("Models test", ->
  it("", ->) # Empty test, so that the result of the first test can be attached

  it("Tests select with foreach", ->
    values = collection('One', 'Two', 'Three', 'Four')
    value = model("X")
    text = model("")

    $('.suite').append(element(div(
      select.multiple().foreach(values, (value) -> option(value, value)).bindValue(value),
      span().bindText(value),
      input.text().bindValue(text),
      button('Add', ->
        values.push(text())
        text("")
      )
    )))
  )

  it("Tests select", ->
    value = model("value2")

    $('.suite').append(element(div(
      select(
        option('Value 1', 'value1'),
        option('Value 2', 'value2'),
        option('Value 3', 'value3')
      ).bindValue(value),
      span().bindText(value)
    )))
  )

  it("Tests radio", ->
    value = model('value2')

    $('.suite').append(element(div(
      input.radio('name', 'value1').bindValue(value),
      input.radio('name', 'value2').bindValue(value),
      input.radio('name', 'value3').bindValue(value),
      span().bindText(value, -> value().toString())
    )))
  )

  it("Tests checkbox", ->
    value = model(true)

    $('.suite').append(element(div(
      input.checkbox().bindValue(value),
      input.checkbox().bindValue(value),
      span().bindText(value, -> value().toString())
    )))
  )

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
      button("x^2", -> f((x) -> (x-50)*(x-50) / 30)),
      button("log", -> f((x) -> Math.log(x) * 20)),
      button("sin", -> f((x) -> Math.sin((x-50)/10) * 50 + 50 ))

      div(class: 'area').foreach([1..100], (x) ->
        div(class: 'point').bindCss(f, (fn) ->
          left: x + 'px'
          bottom: fn(x) + 'px'
        )
      )
    )))
  )
)
