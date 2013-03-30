docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

# email
# search
# todomvc
docs.examples = -> section(h1("Examples"),
  docs.code.examples()

  example("TodoMVC app", "", ->
    todo = (text, done = false) ->
      text: model(text)
      done: model(done)

    todos = collection([todo('first todo')])
    todoText = model("")

    selectAll = model(false)
    header = form.inline(
      input.checkbox(selectAll)
        .on('click', -> todoItem.done(selectAll()) for todoItem in todos()),
      input.text(todoText),
      button('Add', -> todos.add(todo(todoText(""))))
    )

    todoList =
      table().foreach(todos, (todo) ->
        tr(
          td(input.checkbox(todo.done)),
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

  example("Players", "", ->
    player = (name, score) -> object(name: name, score: score)

    players = collection([
      player("C++", 5)
      player("Java", 10)
      player("Javascript", 15)
      player("Go", 25)
      player("Python", 20)
    ])

    players.sort((player1, player2) ->
      return if player1.score < player2.score then 1 else (if player1.score > player2.score then -1 else 0)
    )

    selected = model()

    body(
      div(id:'outer',
        div(class: 'leader board').foreach(players, (player) ->
          div(class:'player',
            span(class:'name').bindText(player.name)
            span(class: 'score').bindText(player.score)
          ).bindClass(selected, 'selected', -> selected() == player)
           .on('click', -> selected(player))
        )
      )

      div(class: 'details',
        div(class: 'name').bindText(selected, -> selected().name if selected())
        button(class: 'inc',"Give 5 points", -> selected().score += 5)
      ).bindVisible(selected, -> selected())

      div(class: 'none', 'Click a player to select')
        .bindVisible(selected, -> !selected())
    )
  )
)