docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")
store = window.BC.namespace("store")

$.extend(this, bootstrap, models, docs, store)

docs.examples.game = -> section(h1("Game"),
  docs.code.game()

  example("Multiplayer tic tac toe", "Open if different tabs to play the game.", ->
    state = EMPTY:"empty", TIC: "tic", TAC: "tac"

    getId = (item) -> item.id

    currentPlayer = null
    player = (name) ->
      obj = object(id: guid(), name: name, lastSeen: Date.now())
      obj

    game = (player) ->
      obj = object(
        id: guid()
        players: [player]
        turn: 0
        state: ((value: state.EMPTY for j in [0...3]) for i in [0...3])
        lastSeen: Date.now()
        finished: false
      )
      setInterval((-> obj.lastSeen = Date.now()), 1000)
      obj

    games = collection()
    pusher(games, 'games', getId)

    content = model()

    checkFinished = (game) ->
      check = (x, y, dx, dy) ->
        currentState = game.state.at(y).at(x)
        for k in [0...3]
          if game.state.at(y + dy * k).at(x + dx * k) != currentState
            currentState = undefined

        if currentState != state.NONE and !game.finished
          game.finished = true
          for k in [0...3]
            game.state.at(y + dy * k).at(x + dx * k).value += " mark"

      for i in [0...3]
        check(i, 0, 0, 1)
        check(0, i, 1, 0)
      check(0, 0, 1, 1)
      check(2, 0, -1, 1)

    icon = (state) ->
      if state == state.TIC then '<i class="icon-circle-blank"/>'
      else if state == state.TAC then '<i class="icon-remove"/>'
      else ""

    myturn = (game) -> game.players.at(game.turn).id == currentPlayer.id
    otherPlayer = (game) -> game.players.at((game.turn + 1) % 2)

    showGame = (game) -> div(
      h3(map(game.players, ->
        if game.players.count() == 1
          "Waiting for other player to join..."
        else
          game.players.at(0).name + " vs " + game.players.at(1).name
      ))

      h4(map(game, ->
        if game.players.count() == 2
          if myturn(game) then "Your turn"
          else otherPlayer(game).name + "s turn."
      ))

      div(class: 'board').foreach(game.state, (row) ->
        div(class: 'board-row').foreach(row, (field) ->
          div({class: 'icon4 field'}, map(bind(field.value), -> icon(field.value)))
            .on('click', ->
              if myturn(game) and field.value == state.EMPTY and !game.finished
                field.value = if game.turn == 0 then state.TIC else state.TAC
                game.turn = (game.turn + 1) % 2
                checkFinished(game)
            )
        )
      )
    )

    gameList = () ->
      div(
        h2("Create new game")
        button('Create', ->
          newGame = game(currentPlayer)
          games.add(newGame)
          content(showGame(newGame))
        )

        h2("Or join an existing game")
        p(span(map(games, -> games.count())), " currently available")
        table(
          thead(tr(
            th("Players").span3(),
            th("Action"))
          )).foreach(games, (game) -> tr(
            td(ul.inline().foreach(game.players, (player) ->
              li(player.name)
            )).span3()
            td(
              button.primary("Join", ->
                game.players.add(currentPlayer)
                content(showGame(game))
              ).bindVisible(game, -> game.players.count() == 1)
              button.info("Watch", ->
                content(showGame(game))
              ).bindVisible(game, -> game.players.count() == 2)
            )
          )
        )
      )

    enterPlayerName = () ->
      playerName = model("")
      div(
        h3("Enter player name")
        form.inline(
          input.text(playerName)
          button.primary("Enter", ->
            currentPlayer = player(playerName())
            content(gameList())
          )
        )
      )

    content(enterPlayerName())

    body(div(content))
  )
)