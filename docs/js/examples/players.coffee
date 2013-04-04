docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")
store = window.BC.namespace("store")

$.extend(this, bootstrap, models, docs)

TIMEOUT = 1000

docs.examples.players = -> section(h1("Players"),
  docs.code.players()

  example("Players app", "", ->
    id = 1
    player = (name, score) -> object(_id: id++, name: name, score: score)

    players = collection([
      player("C++", 5)
      player("Java", 10)
      player("Javascript", 15)
      player("Go", 25)
      player("Python", 20)
    ])

    store.mongoLab(players, 'examples', 'players', TIMEOUT)
    store.pusher(players, 'players', (item) -> ((otherItem) -> item._id == otherItem._id))

    players.sort((player1, player2) ->
      if player1.score < player2.score then 1
      else (if player1.score > player2.score then -1 else 0)
    )

    selected = model()

    body(
      div(id:'outer',
        div(class: 'leader board').foreach(players, (player) ->
          div(class:'player',
            span({class:'name'}, bind(player.name)),
            span({class: 'score'}, bind(player.score))
          ).bindClass(selected, -> 'selected' if selected() == player)
            .on('click', -> selected(player))
        )
      )

      div(class: 'details',
        div({class: 'name'}, map(selected, -> selected().name if selected()))
        button(class: 'inc',"Give 5 points", -> selected().score += 5), '&nbsp;',
        button(class: 'inc',"Take 5 points", -> selected().score -= 5)
      ).bindVisible(selected)

      div(class: 'none', 'Click a player to select')
        .bindVisible(negate(selected))
    )
  )
)