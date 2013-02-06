controls = window.BC.namespace("controls")

$.extend(this, controls)

describe("Scaffolding test", ->
  it("", ->) # Empty test, so that the result of the first test can be attached

  it("Shows a grid", ->
    $('.suite').append(
      element(
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
  )

  it("Tests creating div without the builder", ->
    $('.suite').append(element(
      div.container(
        div.row(
          div("span12", "12")
        )
      )
    ))
  )

  it("Shows a grid with offset", ->
    $('.suite').append(
      element(div.container(
        div.row(
          div().span3().offset2("3,2"),
          div().span4().offset3("4,3")
        ),
        div.row(
          div().span3().offset1("3,1"),
          div().span2().offset3("2,3"),
          div().span1().offset2("1,2")
        )
      ))
    )
  )

  it("Shows a grid with nested columns", ->
    $('.suite').append(
      element(div.container(
        div.row(
          div().span12(
            "Nested",
            div.row(
              div().span6("Nested 6"),
              div().span6("Nested 6")
            )
          )
        )
      ))
    )
  )

  it("Shows a fluid layout", ->
    $('.suite').append(element(
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
    ))
  )
)

