window.BC.define('bootstrap', (bootstrap) ->

  mixins = window.BC.namespace("bootstrap.mixins")
  common = window.BC.namespace("common")

  $.extend(this, common)

  # Buttons
  button = (init) ->
    (args...) ->
      last = _.last(args)
      click = -> return false
      if _.isFunction(last)
        click = (args...) ->
          last(args...)
          return false
        args = args.slice(0, args.length - 1)

      $.extend(
        tag('button', init)(args...).on('click', click),
        mixins.sizeable('btn'),
        block: -> this.addClass("btn-block")
      )

  bootstrap.button = button(class: 'btn')
  bootstrap.button.primary = button(class: 'btn btn-primary')
  bootstrap.button.inverse = button(class: 'btn btn-inverse')
  bootstrap.button.link = button(class: 'btn btn-link')
  bootstrap.button.block = button(class: 'btn btn-block')
  bootstrap.button.info = button(class: 'btn btn-info')
  bootstrap.button.warning = button(class: 'btn btn-warning')
  bootstrap.button.success = button(class: 'btn btn-success')
  bootstrap.button.danger = button(class: 'btn btn-danger')
  bootstrap.button.submit = button(class: 'btn', type: 'submit')

  bootstrap.button.group = tag('div', class: 'btn-group')
  bootstrap.button.group.vertical = tag('div', class: 'btn-group btn-group-vertical')
  bootstrap.button.toolbar = tag('div', class: 'btn-toolbar')

  # Link
  bootstrap.a = (args...) ->
    last = _.last(args)
    click = -> return false
    if _.isFunction(last)
      click = (args...) ->
        last(args...)
        return false
      args = args.slice(0, args.length - 1)
    tag('a')(args...).on('click', click)

  # Dropdown
  dropdown = (button, items...) ->
    button
      .addItems(span(class: 'caret'))
      .addClass('dropdown-toggle')
      .addAttr('data-toggle': "dropdown")

    toLi = (item) ->
      if item.isDivider
        bootstrap.li(class: 'divider')
      else
        bootstrap.li(item)

    [
      button,
      bootstrap.ul(class: "dropdown-menu",
        (toLi(item) for item in items)
      )
    ]

  bootstrap.dropdown = (button, items...) ->
    div(class: "btn-group",
      dropdown(button, items...)
    )

  bootstrap.dropdown.segmented = (btn, items...) ->
    toggle = bootstrap.button()
      .addClass(btn.classes())

    div(class: "btn-group",
      btn,
      dropdown(toggle, items...)
    )

  bootstrap.dropdown.divider = () -> isDivider:true
)
