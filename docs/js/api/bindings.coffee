docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.bindingsApi = -> section(h1("Bindings"),
  docs.code.bindings()

  p("""Each html element offers number of bindings, which allow to bind the value of a certain
      property to a model. The values of the bindings update automatically when the
      model changes. Each binding applies the builder pattern so they can be chained.
    """)
  example(".bindValue", """
      Binds the value of an element to a model. It's available for input and textarea elements.

      <code>.bindValue(model)</code>

    """, ->
    text = model("initial")
    sex = model("female")
    married = model(false)

    body(
      form.inline(
        input.text().bindValue(text)
        span().bindText(text)
        button.info("Clear", -> text(""))
      )

      input.radio("sex", "male").bindValue(sex)
      input.radio("sex", "female").bindValue(sex)
      input.radio("sex", "other").bindValue(sex)
      span().bindText(sex)

      input.checkbox().bindValue(married)
      span().bindText(married)
    )
  )

  example(".bindCss", """Binds css properties of an element to a model. It expects the value of the model to be
      an object whose fields are names of css properties and have corresponding values.""", ->

    f = model((x) -> x)

    body(
      button.group(
        button("x", -> f((x) -> x)),
        button("x^2", -> f((x) -> (x-50)*(x-50) / 30)),
        button("log", -> f((x) -> Math.log(x) * 20)),
        button("sin", -> f((x) -> Math.sin((x-50)/10) * 50 + 50 ))
      )

      div(class: 'area').foreach([1..100], (x) ->
        div(class: 'point').bindCss(f, (fn) ->
          left: x + 'px'
          bottom: fn(x) + 'px'
        )
      )
    )
  )

  example(".bindClass", "Binds whether class should be set. <code>bindClass(model, className, predicate)</code>", ->
    count = model(0)

    body(
      span().bindText(count),
      button("+1", -> count(count() + 1))
        .bindClass(count, 'btn-danger', -> count() > 3 and count() < 8)
    )
  )

  example(".bindText", "Binds the text of an element.", ->
    text = model("")
    body(
      form.inline(
        input.text().bindValue(text)
        h2().bindText(text)
      )
    )
  )

  example(".bindHtml", "Binds the html content of an element. The html value can be string, number or a composite component", ->
    content = model()

    items = [button.warning("Button"),
             "<h2>Test</h2>",
             form.inline(input.text(), button.info("Add", -> console.log("Test")))]
    i = 0
    content(items[0])
    body(
      button("Next", -> content(items[++i % items.length]))
      h6("html")
      div().bindHtml(content)
    )
  )

  example(".bindDisabled", "Binds whether an element is disabled", ->
    number = model(0)

    isThree = -> number() == 3

    body(
      p("You've clicked ", span().bindText(number), " times"),
      button("Click me", -> number(number() + 1))
        .bindDisabled(number, isThree),
      p("That's too many clicks!", button('Reset Clicks', -> number(0)))
        .bindVisible(number, isThree)
    )
  )

  example(".bindVisible", "Binds whether an element is visible.", ->
    visible = model(false)

    body(
      button.success("Hide", -> visible(!visible()))
        .bindText(visible, -> if visible() then "Hide" else "Show")
      button.primary("Button").bindVisible(visible)
    )
  )

  example(".foreach", """Binds the content of an element to a collection.
                      <code>.foreach(collection, render)</code>
                      <ul>Parameters
                      <li>collection - collection of items</li>
                      <li>render(item, index) - takes an element and optional index and renders the item</li>
                      </ul>
                      """, ->
    numbers = collection([5, 3, 2, 7])

    body(
      div().foreach(numbers, (number, index) ->
        div(type.label(number + " @ " + index))
      )
    )
  )

  example(".on", """ Binds event handlers to an element. It has the same parameters as the jquery on method and it uses it internally.
                     <code>.on(event, filter [optional], callback)</code>

                     <ul>Paramaters
                     <li> event - event name, for example "click" </li>
                     <li> filter - optional element filter <code> ul(li("a"), li("b")).on('click', 'li', -> console.log('test'))</code> </li>
                     <li> handler(eventObject) - event handler that takes the jquery event object. </li>
                     </ul>
                 """, ->
    clicks = model(0)

    body(
      div("Click me").on('click', -> clicks(clicks() + 1))
      "clicks : ", span().bindText(clicks)
    )
  )
)