docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

section("Navigation",
  example("Tabs", "It need the tabs bootstrap javascript to run correctly.", ->
    body(
      tabs(
        tab("Tab 1", button("A button in a tab"), p("Boring tab"))
        tab("Tab 2", p("Test Test"), p("Test 2"))
      )
    )
  )

  example("Different tab location", "Tabs can be positioned left, right and below.", ->
    body(
      tabs(tab("Top 1"), tab("Top 2")),
      tabs(tab("Left 1"), tab("Left 2")).left(),
      tabs(tab("Right 1"), tab("Right 2")).right(),
      tabs(tab("Below 1"), tab("Below 2")).below()
    )
  )

  example("Stacked tabs", "Stacked tabs navigation. The tab is expected to take the name of the tab and a click handler.", ->
    body(
      tabs(
        tab(name: "Home", click: -> console.log("Home")),
        tab(name: "About", click: -> console.log("About")),
        tab(name: "Test", click: -> console.log("Test"))
      ).stacked()
    )
  )

  example("Pills", "Displays a list of links as pills.", ->
    body(
      pills(
        pill("Home", -> console.log("Going home"))
        pill("About")
        pill("Blog")
      )
    )
  )

  example("Stacked Pills", "Displays stacked pills and shows disabled", ->
    disabled = model(true)

    body(
      pills.stacked(
        pill("Home", -> console.log("Going home"))
        pill("About")
        pill("Blog").bindClass(disabled, 'disabled')
      )
    )
  )

  example("Basic navbar", "Displays basic navbar, with brand and dividers", ->
    body(
      div.container.fluid(
        navbar(
          navbar.brand('Sample brand')
          nav(
            navbar.divider()
            a("Home")
            a("Examples")
            navbar.divider()
            a("About")
          )
        )
      )
    )
  )

  example("Navbar forms", """navbar.form and navbar.search can be used for normal
                          and search styled forms respectively. The can be aligned
                          using left and right""", ->
    body(
      div.container.fluid(
        navbar(
          right(
            navbar.form(
              input.text().span2().placeholder("Username")
              input.password().span2().placeholder("Password")
              button.success("Login")
            )
          )
          left(
            navbar.search(
              input.search().placeholder("Search")
            )
          )
        )
      )
    )
  )

  example("Navbar positioning", """<code>fixedTop()</code>
                                <code>fixedBottom()</code> <code>staticTop()</code>
                                can be used to set the navbar positioning.
                                <code>inverse()</code> sets inverse color scheme.""", ->
    body(
      div.container.fluid(
        navbar(
          navbar.brand("Brand")
          nav(
            a("Home")
          )
        ).inverse()
      )
    )
  )
)