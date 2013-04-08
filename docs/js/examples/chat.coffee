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
    message = (user, content) -> object(user: user, content: content)
    messages = collection([message(name: 'Chat example', "Welcome!")])
    pusher(messages, 'messages')

    currentUser = object(
      _id: Math.floor(Math.random()*1000000),
      name: "User" + Math.floor(Math.random()*1000),
      lastSeen: Date.now()
      lastTyped: 0
    )

    # This is done so that if the chat app is instantiated multiple times,
    # it clears the update for the previous instance.
    if docs.examples.lastUserUpdate
      window.clearInterval(docs.examples.lastUserUpdate)

    docs.examples.lastUserUpdate = window.setInterval((-> currentUser.lastSeen = Date.now()), 5 * 1000)

    users = collection([currentUser])
    pusher(users, 'users', ((item) -> item._id), 2)
    users.filter((user) -> user._id != currentUser._id and (Date.now() - user.lastSeen) < 10 * 1000)

    messageText = model()
    leftPanel = ->
      div().span3(
        input.text(bind(currentUser.name)).span12()
        ul.unstyled().foreach(users, (user) ->
          console.log(user.lastTyped)
          li(span(bind(user.name)),
             right(span().muted('Typing...'))
               .bindVisible(bind(user.lastTyped), -> Date.now() - user.lastTyped < 100))
        )
      )

    rightPanel = ->
      div().span9(
        div(class: 'messages').foreach(messages, (message) ->
          p(strong(message.user.name + ": "), message.content)
        ).onUpdate((el) -> el.scrollTop(el[0].scrollHeight))
        form.inline(
          append(
            input.text(placeholder: 'Enter message...', messageText).span9()
              .on('keydown', -> currentUser.lastTyped = Date.now())
            button.primary('Send', -> messages.add(
              message(currentUser, messageText(""))
            ))
          ).span12()
        )
      )

    body(
      div.container.fluid(
        div.row.fluid(
          leftPanel()
          rightPanel()
        )
      )
    )
  )
)