docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")
store = window.BC.namespace("store")

$.extend(this, bootstrap, models, docs, store)

body = (items...) -> div(class: 'padded', items)

docs.examples.chat = -> section(h1("Chat"),
  docs.code.chat()

  example("Chat app", "You can open the chat example in different tabs.", ->
    lastTyped = 0
    message = (user, content) -> object(user: user, content: content)
    messages = collection([message(name: 'Chat example', "Welcome!")])
    pusher(messages, 'messages')

    currentUser = object(
      _id: Math.floor(Math.random()*1000000),
      name: "User" + Math.floor(Math.random()*1000),
      ping: 0
      typedBefore: 1000
    )

    # This is done so that if the chat app is instantiated multiple times,
    # it clears the update for the previous instance.
    presense = (currentUser, collection) ->
      if docs.examples.lastUserUpdate
        window.clearInterval(docs.examples.lastUserUpdate)

      docs.examples.lastUserUpdate = window.setInterval((->
        currentUser.ping++
        currentUser.typedBefore = Date.now() - lastTyped)
      , 10 * 1000)

      lastSeen = {}
      pusher(users, 'users', ((item) -> item._id), 5)
      users.filter((user) -> user._id != currentUser._id and
        (!lastSeen[user._id] or (Date.now() - lastSeen[user._id]) < 15 * 1000))
      users.subscribe(collection.actionHandler(update: (user) ->  lastSeen[user._id] = Date.now()))

    users = collection([currentUser])
    presense(currentUser, users)

    messageText = model()
    userList = ->
      div().span3(
        input.text(bind(currentUser.name)).span12()
        ul.unstyled().foreach(users, (user) ->
          li(span(bind(user.name)),
             right(span().muted('Typing...'))
               .bindVisible(bind(user.typedBefore),
                  -> user.typedBefore < 500))
        )
      )

    chatMessages = ->
      div().span9(
        div(class: 'messages').foreach(messages, (message) ->
          p(strong(message.user.name + ": "), message.content)
        ).onUpdate((el) -> el.scrollTop(el[0].scrollHeight))
        form.inline(
          append(
            input.text(placeholder: 'Enter message...', messageText).span9()
              .on('keydown', -> currentUser.typedBefore = 0; lastTyped = Date.now())
            button.primary('Send', ->
              currentUser.typedBefore = 1000
              messages.add(
                message(currentUser, messageText(""))
              ))
          ).span12()
        )
      )

    body(
      div.container.fluid(
        div.row.fluid(
          userList()
          chatMessages()
        )
      )
    )
  )
)