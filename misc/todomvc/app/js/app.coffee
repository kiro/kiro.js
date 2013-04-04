html = window.BC.namespace("html")
models = window.BC.namespace("models")

$.extend(this, html, models)

ENTER_KEY = 13
id = 0

# models
todoModel = (title) -> object(id: id++, title: title, completed: false)
todos = collection()
checkAll = model(false)
selectedFilter = model("")

# helpers
pluralize = (count) -> if count == 1 then "1 item" else count + " items"
done = (todo) -> todo.completed
notDone = (todo) -> !todo.completed
allDone = () -> _.all((todo.completed for todo in todos()))

# controls
textInput = (config, model, handler) ->
  config['autofocus'] = true
  input.text(config, model)
    .on('keydown', (e) -> if e.keyCode == 13 then handler())
    .on('blur', -> handler())

filter = (name, filter) ->
  a(name, ->
    todos.filter(filter)
    selectedFilter(name)
  ).bindClass(selectedFilter, -> 'selected' if selectedFilter() == name)

todosHeader = ->
  todoText = model("")

  header(id:"header",
    h1("todos")
    textInput(id:"new-todo", placeholder:"What needs to be done?", todoText,
      -> todos.add(todoModel(todoText(""))) if todoText().trim()
    )
  )

main = ->
  section(id: "main",
    input.checkbox(id:"toggle-all", checkAll)
      .on('click', -> (todo.completed = checkAll() for todo in todos()))

    label(for: "toggle-all", "Mark all as complete")

    ul(id: "todo-list").foreach(todos, renderTodo)
  ).bindVisible(todos, -> todos.count() > 0)

renderTodo = (todo) ->
  edit = () -> textInput(class:"edit", autofocus: true,
    bind(todo.title), -> content(view())
  )
  view = () -> div(class: "view",
    input.checkbox(class:"toggle", bind(todo.completed))
      .on('click', -> checkAll(allDone()))

    label(bind(todo.title))
    button(class: "destroy", -> todos.remove(todo))
  ).on('dblclick', -> content(edit()))

  content = model(view())
  isEdit = false
  content.subscribe(-> isEdit = !isEdit)

  li(content)
    .bindClass(bind(todo.completed), -> 'completed' if todo.completed)
    .bindClass(content, -> 'editing' if isEdit)

todosFooter = ->
  footer(id: "footer",
    span(id:"todo-count",
      map(todos, -> pluralize(todos.count(notDone)) + " left")
    )
    ul(id: "filters",
      li(filter("All", -> true)).addClass('selected')
      li(filter("Active", notDone))
      li(filter("Completed", done))
    )
    button(id: "clear-completed",
      map(todos, -> "Clear completed (" + todos.count(done) + ")"),
      -> todos.remove(done)
    )
  ).bindVisible(todos, -> todos.total() > 0)

info = ->
  footer(id:"info",
    p("Double-click to edit a todo")
    p('Created by <a href="http://todomvc.com">you</a>')
    p('Part of <a href="http://todomvc.com">TodoMVC</a>')
  )

body(
  section(id:"todoapp",
    todosHeader()
    main()
    todosFooter()
    info()
  )
)
