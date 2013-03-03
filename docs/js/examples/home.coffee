docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.home = () -> section(h1("Enter Kiro.js"),
  docs.code.home()

  example("Declarative bindings", """Allows to bind the values of html properties to models.""", ->
    text = model("World")
    body(
      input.text().bindValue(text)
      h3().bindText(text, ->  "Hello " + text())
    )
  )

  example("Bootstrap controls", "Succint api around bootstrap controls allows building quick prototypes and web apps.", ->
    user =
      firstName: model("Kiril")
      lastName: model("Minkov")

    text = model("")

    body(
      h5("Buttons")
      button.primary("Primary", -> text("Primary"))

      dropdown(
        button.info("Info", -> text("Info, info")),
        a("Hello", -> text("Hello"))
        dropdown.divider()
        a("Test", -> text("Test"))
      )

      button.group(
        button.warning("Warning", -> text("Warning"))
        button.success("Success", -> text("Success"))
        button.danger("Danger", -> text("Danger"))
      )
      span().bindText(text, -> "I am " + text())

      h5("Forms")
      form(
        "First name" : input.text().bindValue(user.firstName)
        "Last name" : input.text().bindValue(user.lastName)
      )

      h5("Table")
      table().bordered().hover().foreach([1, 2], (row) ->
        tr().foreach([1, 2, 3], (col) ->
          td(row + ", " + col)
        )
      )

      h5("And more...")
    )
  )

  example("Html templating", "Allows building responsive html components", ->
    textEdit = (text) ->
      edit = model(false)

      div(
        span()
          .bindText(text)
          .bindVisible(edit, -> !edit())
          .on('click', -> edit(true))
        input.text()
          .bindValue(text)
          .bindVisible(edit)
          .on('blur', -> edit(false))
          .on('keydown', (e) -> if e.keyCode == 13 then edit(false))
      )

    text = model("Click to edit")

    body(
      textEdit(text)
    )
  )

  example("Todo", "", ->
    todo = (text, done = false) ->
      text: model(text)
      done: model(done)

    todos = collection(todo('first todo'))

    notDone = (todo) -> !todo.done()
    done = (todo) -> todo.done()
    remaining = -> todos.count(notDone) + " of " + todos.total() + " remaining"

    todoText = model("")

    div(
      span().bindText(todos, remaining),
      button.link("archive", -> todos.remove(done)),
      div().foreach(todos, (todo) ->
        form.inline(
          input.checkbox().bindValue(todo.done),
          span().bindText(todo.text)
        )
      ),
      form.inline(
        input.text().bindValue(todoText),
        button.primary('Add', -> todos.add(todo(todoText(""))))
      )
    )
  )
)
