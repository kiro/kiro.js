docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

# email
# search
# todomvc
docs.examples = -> section(h1("Examples"),
  docs.code.examples()

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
)