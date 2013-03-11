common = window.BC.namespace("common")
html = window.BC.namespace("html")
models = window.BC.namespace("models")
events = window.BC.namespace("events")

$.extend(this, html, models)

left = (element...) ->
  if (common.isComposite(element[0]) and element[0].length == 1)
    element[0].addClass('left')
  else
    div({class : 'left'}, element)

events.left = left

right = (element...) ->
  if (common.isComposite(element[0]) and element[0].length == 1)
    element[0].addClass('right')
  else
    div({class : 'right'}, element)

events.right = right

viewNote = (note, notes) ->
  div(
    p(note.from(), " ", note.date()),
    p().bindText(note.text),
    div(class: 'container',
      left(a({href:'#'}, "edit", -> note.edit(true))),
      right(a({href:'#'}, "delete", -> notes.remove(note)))
    )
  ).bindVisible(note.edit, -> !note.edit())

editNote = (note, notes) ->
  text = model(note.text())
  div(
    p(note.from(), " ", note.date())
    textarea(class: 'textarea').bindValue(text)
    div(class: 'container',
      left(a({href:'#'}, "save", ->
        note.text(text())
        note.edit(false)
      )),
      right(a({href:'#'}, "cancel", ->
        text(note.text())
        note.edit(false)
      ))
    )
  ).bindVisible(note.edit)

events.notes = (objects) ->
  noteModel = (object) -> {
    text: model(object.text),
    from: model(object.from),
    date: model(object.date),
    edit: model(object.edit ? false)
  }

  notes = collection(
    (noteModel(object) for object in objects)
  )

  div(
    div(class: 'container',
      left(span().bindText(notes, -> "Notes (" + notes.count() + ")"))
      right(a({href: '#'}, 'add note', ->
        notes.add(
          noteModel({text: "", form: "Current user", date: moment().format("D MMMM"), edit: true})
        )
      ))
    )

    div().foreach(notes, (note) ->
      div(
        viewNote(note, notes)
        editNote(note, notes)
      )
    )
  )
