docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

section("Examples",
  example("Simple todo", "", ->
    todo = (text, done = false) ->
      console.log("--" + text)
      text: model(text)
      done: model(done)

    todos = collection(todo('first todo'))

    notDone = (todo) -> !todo.done()
    done = (todo) -> todo.done()
    remaining = -> todos.count(notDone) + " of " + todos.count() + " remaining"

    todoText = model("")
    div(
      h2("Todo"),
      span().bindText(todos, remaining),
      " [", button.link("archive", -> todos.remove(done)), "]",
      div().foreach(todos, (todo) ->
        form.inline(
          input.checkbox().bindValue(todo.done),
          span().bindText(todo.text)
        )
      ),
      form.inline(
        input.text().bindValue(todoText),
        button.primary('Add', -> todos.add(todo(todoText("")))
      )
    )
  )

  example("Todo app", "", ->
    todo = (text, done = false) ->
      text: model(text)
      done: model(done)

    todos = collection(todo('first todo'))
    todoText = model("")

    selectAll = model(false)
    header = form.inline(
      input.checkbox()
        .bindValue(selectAll)
        .on('click', -> todoItem.done(selectAll()) for todoItem in todos()),
      input.text().bindValue(todoText),
      button('Add', -> todos.add(todo(todoText(""))))
    )

    todoList =
      table().foreach(todos, (todo) ->
        tr(
          td(input.checkbox().bindValue(todo.done)),
          td(todo.text())
          td(button("Remove", -> todos.remove(todo)))
        )
      )

    notDone = (todo) -> !todo.done()
    done = (todo) -> todo.done()
    all = -> true

    footer =
      div.row.fluid(
        div().span3(
          span().bindText(todos, -> todos.count(notDone) + " of " + todos.count())
        ),
        div().span6(
          button.link('All', -> todos.filter(all)),
          button.link('Done', -> todos.filter(done)),
          button.link('Left', -> todos.filter(notDone))
        ),
        div().span3(
          a('Remove all', -> todos.removeAll())
        )
      )

    body(
      div.container(div().span6(
        header
        todoList
        footer
      ))
    )
  )

  example("Tests select with foreach", "", ->
    values = collection('One', 'Two', 'Three', 'Four')
    value = model("X")
    text = model("")

    body(div(
      select.multiple().foreach(values, (value) -> option(value, value)).bindValue(value),
      span().bindText(value),
      input.text().bindValue(text),
      button('Add', ->
        values.add(text(""))
      )
    ))
  )

  example("Tests select", "", ->
    value = model("value2")

    body(div(
      select(
        option('Value 1', 'value1'),
        option('Value 2', 'value2'),
        option('Value 3', 'value3')
      ).bindValue(value),
      span().bindText(value)
    ))
  )

  example("Tests radio", "", ->
    value = model('value2')

    body(div(
      input.radio('name', 'value1').bindValue(value),
      input.radio('name', 'value2').bindValue(value),
      input.radio('name', 'value3').bindValue(value),
      span().bindText(value, -> value().toString())
    ))
  )

  example("Tests checkbox", "", ->
    value = model(true)

    body(div(
      input.checkbox().bindValue(value),
      input.checkbox().bindValue(value),
      span().bindText(value, -> value().toString())
    ))
  )

  example("Tests attr, css and text bindings", "", ->
    number = model(0)

    selectColor = (value) ->
        if value > 6 then 'red'
        else if value > 3 then 'orange'
        else 'green'

    body(
      div(
        button("Test", -> number(number() + 1))
          .bindDisabled(number, -> number() == 10),
        span()
          .bindText(number)
          .bindCss(number, -> color: selectColor(number()))
      )
    )
  )

  example("Tests visible and html bindings", "", ->
    number = model(0)

    isThree = -> number() == 3

    body(
      div(
        p("You've clicked ", span("").bindText(number), " times"),
        button("Click me", -> number(number() + 1)).bindDisabled(number, isThree),
        p("That's too many clicks! Please stop before you wear out your fingers. ",
          button('Reset Clicks', -> number(0)))
            .bindVisible(number, isThree)
      )
    )
  )

  example("Tests input element", "", ->
    value = model("test")

    body(
      form.inline(
        input.text().bindValue(value),
        h1().bindText(value)
      )
    )
  )

  example("Tests simple list", "", ->
    item = model("")
    items = collection()

    body(
      div(
        form.inline(
          input.text().bindValue(item),
          button('Add', ->
            items.add(item(""))
            return false
          )
        )
        table(thead(tr(th("Value")))).foreach(items, (item) ->
          tr(td(item))
        )
      )
    )
  )

  example("Displays different functions", "", ->
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
)
