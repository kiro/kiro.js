bootstrap = window.BC.namespace("bootstrap")

$.extend(this, bootstrap)

site = div.container(
  navbar(
    navbar.brand("kiro.js")
    nav(
      a("Home", -> navigate.to('/'))
      a("Api", -> navigate.to('#/api'))
      a("Bootstrap", -> navigate.to('#/bootstrap'))
      a("Examples", -> navigate.to('#/examples'))
    )
    right(navbar.search(
      input.search().placeholder('Search')
    ))
  )
)

$('body').append(
  element(
    site
  )
)

