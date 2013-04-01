docs = window.BC.namespace("docs")
docs.examples = window.BC.namespace("docs.examples")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.examples.meteortodo = -> section(h1("Meteor todo"), ->
  docs.code.meteortodo()

  example("Meteor todo app", "", ->
    tag = (name) -> object(name: name)
    todo = (name) -> object(name: name, done: false, tags [])
    todoList = (name) -> object(name: name, todos: [])
    allLists = array([])

    filter = () ->
      selectedTag = model()

      div(id: "top-tag-filter",
        div({id: "tag-filter", class: "tag-list"},
          div(class:"label", "Show:").foreach(tags, (tag) ->
            div(class: "tag",
              tag.text, span({class: "count"}, tag.count)
            ).bindClass(selectedTag, -> 'selected' if selectedTag() == tag)
             .on('click', -> selectedTag(tag))
          )
        )
      )

    main = () ->
      div(id:"main-pane",
        todos(list)
      )

    side = () ->
      selectedList = model()
      newList = model("")

      div(id:"side-pane",
        h3("Todo Lists"),
        div(id: "lists").foreach(lists, (list) ->
          editing = model(false)

          div(class: "list",
            div(class: "edit",
              input.text({class: "list-name-input", id: "list-name-input"}, list.name)
            ).bindVisible(editing)

            div(class: "display",
              a({class: "list-name {{name_class}}", href:"/{{_id}}"},
                list.name
              ).on('click', ->)
            ).bindVisible(editing, -> !editing())
          )
        )
        div(id: "createList",
          input.text({id:"new-list", placeholder:"New list"}, newList)
        )
      )

    todos = (list) ->
      newTodoText = model()
      div(id:"items-view",
        div(id:"new-todo-box",
          input.text({id: "new-todo", placeholder: "New item"}, newTodoText)
        )
        ul(id:"item-list").foreach(list.todos, (todo) -> todo_item(todo))
      )

    todo_item = (todo) ->
      editing = model(false)
      addingTag = model(false)
      tagText = model("")

      li(class: "todo",
        div(class:"edit",
          input.text({id:"todo-input"}, todo.text)
        ).bindVisible(editing)

        div(
          div(class: "destroy"),
          div(class: "display",
            input.checkbox({class:"check", name:"markdone"}, todo.done)
            div({class:"todo-text"}, todo.text)
          )
        ).bindVisible(editing, -> !editing())

        div(class:"item-tags").foreach(todo.tags, (tag) ->
          div(class: "tag removable_tag",
            div({class: "name"}, tag.name)
            div(class: "remove")
          )
        )

        div(class:"tag edittag",
          input.text(id: "edittag-input", tagText)
            .on('keydown', -> )
        ).bindVisible(addingTag)

        div(class:"tag addtag",
          "+tag"
        ).bindVisible(addingTag, -> !addingTag())
          .on('click', -> addingTag(true))
      ).bindClass(todo.done, -> 'done' if todo.done)

    body(
      filter()
      main()
      side()
    )
  )
)
