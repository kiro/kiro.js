docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")
store = window.BC.namespace("store")

$.extend(this, bootstrap, models, docs, store)

body = (items...) -> div(class: 'padded', items)

docs.examples.chat = -> section(h1("Chat"),
  docs.code.chat()

  example("Chat app", "You can open chat examples in different ", ->
    message = (user, content) -> object(user: user, content: content)
    messages = collection([message(name: 'Chat example', "Welcome!")])
    pusher(messages, 'messages')

    user = object(
      _id: Math.floor(Math.random()*1000000),
      name: "User" + Math.floor(Math.random()*1000),
      lastSeen: Date.now()
    )
    window.setInterval((-> user.lastSeen = Date.now()), 10 * 1000)

    users = collection()
    pusher(users, 'users', (item) -> ((otherItem) -> item._id == otherItem._id))
    users.add(user)
    users.filter((user) -> (Date.now() - user.lastSeen) > 20 * 1000)

    messageText = model()
    leftPanel = ->
      div().span3(
        input.text(bind(user.name)).span12()
        ul.unstyled().foreach(users, (user) ->
          li(bind(user.name))
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
            button.primary('Send', -> messages.add(
              message(user, messageText(""))
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