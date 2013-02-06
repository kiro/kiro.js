
todo = (text, done = false) -> model(
  text: text
  done: done
)

todos = collection(todo('first todo'))
todoText = model()

div(
  input.checkbox("", -> todo.done = this.val() for todo in todos),
  input.text().bind(todoText, 'text'),
  button('Add', ->
    todos.add(todo(todoText())),
    todoText("")
  ),
  list(todos, (todo) ->
    input.checkbox().bind(todo.done),
    input.text().bind(todo.text)
  )
  div(
    left(
      span().bind(todos, -> todos.count((todo) -> !todo.done))), " of "
      span().bind(todos, -> todos.count())
    ),
    right(a('Remove all', -> todos.clear()))
  )
)

folders = ['Inbox', 'Outbox', 'Sent', 'Deleted']
fields = ['From', 'To', 'Subject', 'Date']
currentPanel = model()

showFolder = (folder) ->
  currentPanel(loading())
  $.get('folder', (emails) ->
    currentPanel(element(
      table(
        thead(th(td(field) for field in fields)),
        (tr(
          td(email.from),
          td(email.to),
          td(email.subject),
          td(email.date)
        ).on('click', -> showEmail(email)) ) for email in emails
    ))
  )

showEmail = (email) ->
  currentPanel(
    form(
      'From' : email.from,
      'To' : email.to,
      'Subject' : email.subject,
      'Content' : textArea(email.content).editable(false)
    )
  )

navbar((a(folder, -> showFolder(folder)) for folder in folders)),
panel().bindHtml(currentPanel)

reset = model("")
clicks = model(0)

div(
  "Number of clicks ", span().bind(clicks), button('Click', ->
    if clicks() == 3
      reset(element('Reset the number of clicks', button('Reset', -> (clicks(0), reset(""))))
    else
      -> clicks(clicks() + 1))
  ),
  div().bindHtml(reset)
)

items = collection()
itemText = model("")
selected = model()

input.text().bind(itemText),
button('Add', -> items.add(itemText()), itemText(""))),
p('Your items'),
select.multi(list(items, (item) -> option(item))).bind(selected)

button('Remove', -> items.remove(selected())).bindEnabled(selected, -> selected())
button('Sort', items.sort()).bindEnabled(items, -> items.count() > 0)

