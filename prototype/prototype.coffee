common = window.BC.namespace("common")
html = window.BC.namespace("html")
models = window.BC.namespace("models")
events = window.BC.namespace("events")

$.extend(this, html, models, events)

start = moment(event.start_date)
end = moment(event.end_date)
duration = end.clone().subtract(start)

items = (title, items, name, link = (->), className="padding") ->
  div(class: className,
    title
    hr()
    (div(class: 'container',
      left(name(item)),
      right(link(item))
    ) for item in items) if items
  )

showEdit = model(false)

body(
  div(class: 'modal',
    div(
      div(class: 'container',
        left(start.format('dddd Do MMMM H:mm') + " - " + end.format('H:mm') + " ( " + duration.format("H:mm") + " )", button("Edit", -> showEdit(true)))
        right('<i class="icon-remove"></i>')
      )
      div(class: 'container',
        event.description
      )
      div(class: "half left",
        div(
          div(class: 'padding',
            event.state,
            div(class: 'right button',
              'cancel'
            )
          )
        )
        items('Customers', event.customers, ((customer) -> customer.name), ((customer) -> a({href: '#'}, 'view customer')))
        items('Staff', event.staff, ((staff) -> staff.name), ((staff) -> a({href: '#'}, 'view staff')))
        items('Resources', event.resources, ((resource) -> resource.name))
        items('Locations', event.locations, ((location) -> location.name))
      )
      div(class: "half right padding",
        notes(event.notes),
        items('History', event.history, ((item) -> item.action), ((item) -> item.date))
      )
    ).bindVisible(showEdit, -> !showEdit())
    editEvent(showEdit, event)
  )
)