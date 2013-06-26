docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")
store = window.BC.namespace("store")

$.extend(this, bootstrap, models, docs, store)

body = (items...) -> div(class: 'padded', items)

docs.examples.hailoChat = -> section(h1("Chat"),
  docs.code.hailoChat()

  example("Hailo chat app", "Hailo chat.", ->
    socket = new WebSocket("ws://localhost:8888")
    userId =
    socket.onmessage((msg) -> )

    body(
      div.container.fluid(
        div.row.fluid(

        )
      )
    )
  )
)