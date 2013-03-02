docs = window.BC.namespace("docs")
docs.bootstrap = window.BC.namespace("docs.bootstrap")
bootstrap = window.BC.namespace("bootstrap")

$.extend(this, bootstrap, docs)

body = (items...) ->
  div(items).addClass('bs-docs-example scaffolding')

docs.bootstrap.scaffolding = -> section(h1("Scaffolding"),
  example("Grid building", "Div has fields for different grid styles", ->
    body(
      div.container(
        div.row(
          div().span2("2"),
          div().span10("10")
        ),
        div.row(
          div().span2("2"),
          div().span5("5"),
          div().span5("5")
        ),
        div.row(
          div().span3("3"),
          div().span3("3"),
          div().span3("3"),
          div().span3("3")
        )
      )
    )
  )

  example("Creating div with passing classes directly", "Div has set of predefined styles for ease of use.", ->
    body(
      div.container(
        div.row(
          div(class:"span12", "12")
        )
      )
    )
  )

  example("Grid with offset", "Using spanX and offsetX builder methods, they can take as additional paramters the content of the div", ->
    body(
      div.container(
        div.row(
          div().span3().offset2("3,2"),
          div().span4().offset3("4,3")
        ),
        div.row(
          div().span3().offset1("3,1"),
          div().span2().offset3("2,3"),
          div().span1().offset2("1,2")
        )
      )
    )
  )

  example("Grid with nested columns", "Using nesting", ->
    body(
      div.container(
        div.row(
          div().span12(
            "Nested",
            div.row(
              div().span6("Nested 6"),
              div().span6("Nested 6")
            )
          )
        )
      )
    )
  )

  example("Fluid layout", "Using div.container.fluid and div.row.fluid", ->
    body(
      div.container.fluid(
        div.row.fluid(
          div().span2().offset4("2,4"),
          div().span3().offset3("3,3")
        ),
        div.row.fluid(
          div().span6(
            "Nested fluid",
            div.row.fluid(
              div().span6("6"),
              div().span6("6")
            )
          ),
          div().span6("6")
        )
      )
    )
  )
)

