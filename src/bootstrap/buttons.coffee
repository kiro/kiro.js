controls = window.BC.namespace("controls")
mixins = window.BC.namespace("mixins")
common = window.BC.namespace("common")

$.extend(this, common)

button = (init) ->
  (args...) ->
    last = _.last(args)
    click = ->
    if _.isFunction(last)
      click = last
      args = args.slice(0, args.length - 1)

    $.extend(
      tag('button')(init, args).on('click', click),
      mixins.sizeable('btn'),
      block: -> this.addClass("btn-block")
    )

controls.button = button(class: 'btn')
controls.button.primary = button(class: 'btn btn-primary')
controls.button.inverse = button(class: 'btn btn-inverse')
controls.button.link = button(class: 'btn btn-link')
controls.button.block = button(class: 'btn btn-block')
controls.button.info = button(class: 'btn btn-info')
controls.button.warning = button(class: 'btn btn-warning')
controls.button.success = button(class: 'btn btn-success')
controls.button.danger = button(class: 'btn btn-danger')

# TODO(kiro): add attr to the config object
controls.button.submit = button(class: 'btn')
controls.a = (args...) ->
  last = _.last(args)
  click = ->
  if _.isFunction(last)
    click = last
    args = args.slice(0, args.length - 1)
  tag('a')(args).on('click', click)

controls.divider = () -> isDivider:true

dropdown = (button, items...) ->
  button
    .addItems(span(class: 'caret'))
    .addClass('dropdown-toggle')
    .attr('data-toggle': "dropdown")

  toLi = (item) ->
    if item.isDivider
      controls.li(class: 'divider')
    else
      controls.li(item)

  [
    button,
    controls.ul(class: "dropdown-menu",
      (toLi(item) for item in items)
    )
  ]

controls.dropdown = (button, items...) ->
  div(class: "btn-group",
    dropdown(button, items...)
  )

controls.dropdown.segmented = (btn, items...) ->
  toggle = controls.button()
    .addClass(btn.classes())

  div(class: "btn-group",
    btn,
    dropdown(toggle, items...)
  )

