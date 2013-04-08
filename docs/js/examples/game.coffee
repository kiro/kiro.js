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

    initialState = -> ((value: state.EMPTY, mark: false for j in [0...3]) for i in [0...3])

    currentPlayer = null
    player = (name) ->
      object(id: guid(), name: name, lastSeen: Date.now())

    game = (player) ->
      obj = object(
        id: guid()
        players: [player]
        turn: 0
        state: initialState()
        lastSeen: Date.now()
        finished: false
      )
      window.setInterval((-> obj.lastSeen = Date.now()), 10 * 1000)
      obj

    games = collection()
    pusher(games, 'games', getId)

    content = model()

    boardFull = (game) ->
      for i in [0...3]
        for j in [0...3]
          if game.state.at(i).at(j).value != state.EMPTY
            return false
      return true

    checkFinished = (game) ->
      check = (x, y, dx, dy) ->
        currentState = game.state.at(y).at(x).value
        for k in [0...3]
          if game.state.at(y + dy * k).at(x + dx * k).value != currentState
            currentState = undefined

        if currentState and currentState != state.EMPTY and !game.finished
          game.finished = game.players.ar(game.turn).name + " won!"
          for k in [0...3]
            game.state.at(y + dy * k).at(x + dx * k).mark = true

      if boardFull
        game.finished = "Game finished."

      for i in [0...3]
        check(i, 0, 0, 1)
        check(0, i, 1, 0)
      check(0, 0, 1, 1)
      check(2, 0, -1, 1)

    icon = (value) ->
      if value == state.TIC then '<i class="icon-circle-blank"/>'
      else if value == state.TAC then '<i class="icon-remove"/>'
      else ""

    myturn = (game) -> game.players.count() > game.turn and game.players.at(game.turn).id == currentPlayer.id
    otherPlayer = (game) -> game.players.at((game.turn + 1) % 2)
    canPlay = (game) ->
      game.players.count() > 1 and (game.players.at(0).id == currentPlayer.id or
      game.players.at(1).id == currentPlayer.id)

    showGame = (game) -> div(
      h3(map(game, ->
        if game.players.count() <= 1
          "Waiting for other player to join..."
        else if canPlay(game)
          game.players.at(0).name + " vs " + game.players.at(1).name
        else
          "Game is full, you can just observe."
      ))

      h4(map(game, ->
        if game.players.count() >= 2
          if game.finished

          else
            if myturn(game) then "Your turn"
            else otherPlayer(game).name + "s turn."
      )).bindVisible(game.players, -> canPlay(game))

      div(class: 'board').foreach(game.state, (row) ->
        div(class: 'board-row').foreach(row, (field) ->
          div({class: 'icon4 field'}, map(bind(field.value), -> icon(field.value)))
            .on('click', ->
              if myturn(game) and field.value == state.EMPTY and !game.finished
                field.value = if game.turn == 0 then state.TIC else state.TAC
                checkFinished(game)
                game.turn = (game.turn + 1) % 2
            )
            .bindClass(bind(field.mark), -> if field.mark then "mark")
        )
      )

      div(class: 'padding',
        button.primary('Play again', ->
          game.finished = false
          game.state = initialState()
        ).bindVisible(bind(game.finished))

        button("Go back", ->
          game.players.remove(currentPlayer)
          content(gameList())
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