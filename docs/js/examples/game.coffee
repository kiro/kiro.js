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
    player = (name) -> object(id: guid(), name: name, lastSeen: Date.now())

    currentPlayer = player('Player' + Math.floor(Math.random() * 1000))
    players = collection([currentPlayer]).filter()
    pusher(players, 'players', getId)

    if docs.examples.lastUserUpdate
      window.clearInterval(docs.examples.lastUserUpdate)

    docs.examples.lastUserUpdate = window.setInterval(->
      currentPlayer.lastSeen = Date.now()
    , 5 * 1000)

    initialState = () -> ((value: state.EMPTY, mark: false for j in [0...3]) for i in [0...3])
    game = () ->
      obj = object(
        id: 1
        turn: 0
        state: initialState()
        lastSeen: Date.now()
        finished: false
      )
      obj

    game = game()
    games = collection([game])
    pusher(games, 'games', getId)

    content = model()

    checkFinished = (game) ->
      check = (x, y, dx, dy) ->
        currentState = game.state.at(y).at(x).value
        for k in [0...3]
          if game.state.at(y + dy * k).at(x + dx * k).value != currentState
            currentState = undefined

        if currentState and currentState != state.EMPTY and !game.finished
          game.finished = true
          for k in [0...3]
            game.state.at(y + dy * k).at(x + dx * k).mark = true

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
    canPlay = () ->
      game.players.count() > 1 and (game.players.at(0).id == currentPlayer.id or
      game.players.at(1).id == currentPlayer.id)

    showGame = (game) -> div(
      h3(map(game, ->
        if game.players.count() <= 1
          "Waiting for other player to join..."
        else if canPlay()
          game.players.at(0).name + " vs " + game.players.at(1).name
        else
          "Game is full, you can just observe."
      ))

      h4(map(game, ->
        if game.players.count() >= 2
          if myturn(game) then "Your turn"
          else otherPlayer(game).name + "s turn."
      )).bindVisible(game.players, -> canPlay())

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

      div(h3(map(bind(game.finished), -> game.players.at(game.turn).name + " won!!!") if game.players.count() > 1),
        button.primary('Play again!', ->
          game.state = initialState()
          game.finished = false
        )
        button('Go back', -> content(gameList()))
      ).bindVisible(bind(game.finished))
    )

    content(showGame(game))

    body(div(content))
  )
)