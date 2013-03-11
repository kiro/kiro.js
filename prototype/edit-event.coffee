common = window.BC.namespace("common")
html = window.BC.namespace("html")
models = window.BC.namespace("models")
events = window.BC.namespace("events")

$.extend(this, html, models)

items = (title, itemName, items, name, className="padding") ->
  div(class: className,
    div(class: 'container',
      left(title)
      right(
        a('add ' + itemName, -> items.add(''))
      )
    )

    hr()
    div().foreach(items, (item) ->
      div(class: 'container',
        left(item[name]),
        right( a('view ' + itemName, (->)), a('remove', -> items.remove(item)))
      )
    )
  )

events.editEvent = (showEdit, event) ->
  div(
    div(class: 'container',
      left("Edit appointment...")
      right(
        button("save", ->
          # save the event
          showEdit(false)
        )
        button("cancel", ->
          # cancel the edit
          showEdit(false)
        )
      )
    )
    div(class: 'container',
      input.text().placeholder("Date")
      input.text().placeholder("Time")
    )
    div(class: 'container',
      select()
      select()
    )
    div(class: "half left",
      items("Customers", "customer", collection(event.customers), "name")
      items("Staff", "staff", collection(event.staff), "name")
      items("Resources", "resource", collection(event.resources), "name")
      items("Locations", "location", collection(event.locations), "name")
    )
    div(class: "half right padding",
      events.notes(event.notes)
    )
  ).bindVisible(showEdit)

