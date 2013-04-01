html = window.BC.namespace("html")
models = window.BC.namespace("models")

$.extend(this, html, models)

ENTER_KEY = 13
nextId = (() ->
  value = 0
  () -> value++)()

# models
todoModel = (title) -> object(id: nextId(), title: title, completed: false)
todos = collection()
todoText = model("")
checkAll = model(false)
selectedFilter = model("")

# helpers
pluralize = (count) -> if count == 1 then "1 item" else count + " items"
done = (todo) -> todo.completed
notDone = (todo) -> !todo.completed
allDone = () -> _.all((todo.completed for todo in todos()))

# controls
textInput = (config, model, handler) ->
  input.text(config, model)
    .on('keydown', (e) -> if e.keyCode == 13 then handler())

filter = (name, filter) ->
  a(name, ->
    todos.filter(filter)
    selectedFilter(name)
  ).bindClass(selectedFilter, 'selected', -> selectedFilter() == name)

renderTodo = (todo) ->
  editing = model(false)

  li(
    div(class: "view",
      input.checkbox({class:"toggle"}, todo.completed)
        .on('click', -> checkAll(allDone()))
      label(todo.title)
      button(class: "destroy", -> todos.remove(todo))
    ).bindVisible(negate(editing))
     .on('dblclick', -> editing(true))

    textInput({class:"edit"}, todo.title, -> editing(false))
      .bindVisible(editing)
      .on('blur', -> editing(false))
  ).bindClass(todo.completed, 'completed', -> todo.completed.valueOf())
   .bindClass(editing, 'editing')

body(
  section(id:"todoapp",
    header(id:"header",
      h1("todos")
      textInput({id:"new-todo", placeholder:"What needs to be done?", autofocus: true}, todoText,
        -> todos.add(todoModel(todoText(""))) if todoText().trim())
    )

    section(id: "main",
      input.checkbox({id:"toggle-all"}, checkAll)
        .on('click', -> (todo.completed = checkAll() for todo in todos()))
      label({for: "toggle-all"}, "Mark all as complete")

      ul(id: "todo-list").foreach(todos, renderTodo)
    ).bindVisible(todos, -> todos.count() > 0)

    footer(id: "footer",
      span({id:"todo-count"}, map(todos, -> pluralize(todos.count(notDone)) + " left"))
      ul(id: "filters",
        li(filter("All", -> true)).addClass('selected')
        li(filter("Active", notDone))
        li(filter("Completed", done))
      )
      button({id: "clear-completed"},
        map(todos, -> "Clear completed (" + todos.count(done) + ")"),
        -> todos.remove(done))
    ).bindVisible(todos, -> todos.total() > 0)

    footer(id:"info",
      p("Double-click to edit a todo")
      p('Created by <a href="http://todomvc.com">you</a>')
      p('Part of <a href="http://todomvc.com">TodoMVC</a>')
    )
  )
)
