bootstrap = window.BC.namespace("bootstrap")
mixins = window.BC.namespace("bootstrap.mixins")
common = window.BC.namespace("common")

$.extend(this, common, bootstrap)

bootstrap.tabs = (tabs...) ->
  id = nextId()

  active = once("active")
  tabList = ul(class: "nav nav-tabs")
    .foreach(tabs, (tab, index) ->
      li(
        a({id: id + "_" + index, 'data-toggle': 'tab'}, tab.name)
      ).addClass(active())
    )

  active = once("active")
  content = div(class: 'tab-content')
    .foreach(tabs, (tab, index) ->
      div({id: id + "_" + index, class: 'tab-pane'}, tab.content).addClass(active())
    )

  div(class:'tabbable', tabList, content)

bootstrap.tab = (name, content...) ->
  name: name
  content: content
