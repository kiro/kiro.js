window.BC.define('bootstrap', (bootstrap) ->

  mixins = window.BC.namespace("bootstrap.mixins")
  common = window.BC.namespace("common")

  $.extend(this, common, bootstrap)

  activate = (el) ->
    $(el).parent().parent().find('li').removeClass('active')
    $(el).parent().addClass('active')

  bootstrap.nav = (items...) ->
    toLi = if _.isFunction(_.last(items)) then items.pop() else (item) -> li(item)

    item.on('click', -> activate(this)) for item in items

    items = (toLi(item) for item in items)

    if items.length
      items[0].addClass('active')
    ul(class: 'nav').foreach(items, (item) -> item)

  # tabs
  bootstrap.tabs = (tabs...) ->
    id = nextId()
    active = once("active")
    links = _.map(tabs, (tab, index) ->
      a({id: id + "_" + index, 'data-toggle': 'tab'}, tab.name).on('click', tab.click)
    )
    tabList = bootstrap.nav(links...).addClass('nav-tabs')

    active = once("active")
    content = div(class: 'tab-content')
      .foreach(tabs, (tab, index) ->
        div({id: id + "_" + index, class: 'tab-pane'}, tab.content).addClass(active())
      )

    $.extend(
      div(class:'tabbable', tabList, content)
      left: -> this.addClass('tabs-left')
      right: -> this.addClass('tabs-right')
      below: -> this.addClass('tabs-below')
      stacked: -> tabList.addClass('nav-stacked')
    )

  # Single tab it can accept an object with fields name, content and click or two parameters for name and content.
  bootstrap.tab = (args...) ->
    if _.isObject(args[0]) and args.length == 1 then return args[0]

    {name: args[0]
    content: _.rest(args)}

  # pills
  bootstrap.pills = (items...) -> bootstrap.nav(items...).addClass('nav-pills')
  bootstrap.pills.stacked = (items...) -> bootstrap.nav(items...).addClass('nav-pills nav-stacked')
  bootstrap.pill = (name, click) ->
    li(a(name).on('click', click))

  # navbar
  bootstrap.navbar = (items...) ->
    $.extend(
      div(class: 'navbar',
        div(class: 'navbar-inner',
          items
        )
      ),
      fixedTop: () -> this.addClass('navbar-fixed-top')
      fixedBottom: () -> this.addClass('navbar-fixed-bottom')
      staticTop: () -> this.addClass('navbar-static-top')
      inverse: () -> this.addClass('navbar-inverse')
    )

  bootstrap.navbar.brand = (items...) -> a({class: 'brand'}, items...)
  bootstrap.navbar.divider = () -> li(class: 'divider-vertical')
  bootstrap.navbar.form = (items...) -> form.inline(items...).addClass('navbar-form')
  bootstrap.navbar.search = (items...) -> form.inline(items...).addClass('navbar-search')
)