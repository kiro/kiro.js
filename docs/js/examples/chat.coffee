docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

body = (items...) -> div(items)

docs.examples.chat = -> section(h1("Chat"),
  docs.code.email()

  example("Chat client", "", ->
    type =
      ping: 'ping'
      text: 'text'
      join: 'join'

    message = (type, user, content) -> object(type: type, user: user, content: content)
    messages = collection()




  )
)