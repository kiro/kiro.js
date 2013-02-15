controls = window.BC.namespace("controls")

$.extend(this, controls)

describe("Type tests", ->
  it("", ->) # Empty test, so that the result of the first test can be attached

  it("Headings test", ->
    show(
      div(class: "bs-docs-example",
        h1("Heading 1"),
        h2("Heading 2"),
        h3("Heading 3"),
        h4("Heading 4"),
        h5("Heading 5"),
        h6("Heading 6")
      )
    )
  )

  it("Emphasis test", ->
    show(
      div(class: "bs-docs-example",
        p(small("Small text")),
        p(bold("Bold text")),
        p(italic("Italics text")),
        p().lead("Lead paragraph")
      )
    )
  )

  it("Text context test", ->
    show(
      div(class: "bs-docs-example",
        p().muted("Fusce dapibus, tellus ac cursus commodo, tortor mauris nibh."),
        p().warning("Etiam porta sem malesuada magna mollis euismod."),
        p().error("Donec ullamcorper nulla non metus auctor fringilla."),
        p().success("Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis."),
        p().info("Duis mollis, est non commodo luctus, nisi erat porttitor ligula.  ")
      )
    )
  )

  it("Address", ->
    show(
      div(class: "bs-docs-example",
        address(
          bold("Full Name"),
          "Address line 1",
          "Address line 2",
          '<abbr title="Phone">P:</abbr> (123) 456-7890'
        )
      )
    ))

  it("Blockquote", ->
    show(
      div(class: "bs-docs-example",
        blockquote(
          p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante."),
          small("Kiril Minkov")
        )
      )
    )
  )

  it("List", ->
    show(
      ul(
        li('Item 1'),
        li('Item 2'),
        li('Item 3'),
        li('Item 4')
      )
    )
  )

  it("Ordered list", ->
    show(
      ol(
        li('Item 1'),
        li('Item 2'),
        li('Item 3'),
        li('Item 4')
      )
    )
  )

  it("Unstyled list", ->
    show(
      ul.unstyled(
        li('Item 1'),
        li('Item 2'),
        li('Item 3'),
        li('Item 4')
      )
    )
  )

  it("Inline list", ->
    show(
      ul.inline(
        li('Item 1'),
        li('Item 2'),
        li('Item 3'),
        li('Item 4')
      )
    )
  )

  it("Description list", ->
    show(
      dl(
        dt('Description 1'),
        dd(span().success('Item 2')),
        dt('Description 3'),
        dd(span().warning('Item 4'))
      )
    )
  )

  it("Horizontal description list", ->
    show(
      dl.horizontal(
        dt('Description 1'),
        dd(span().success('Item 2')),
        dt('Description 3'),
        dd(span().warning('Item 4'))
      )
    )
  )

  it("Code", ->
    show(
      div(class: "bs-docs-example",
        span("For example,", code('System.out.pintln("Hello World")'), 'should be wrapped as inline.')
      )
    )
  )

  it("Pre", ->
    show(
      div(class: "bs-docs-example",
        pre(
          "code",
          "code"
        )
      )
    )
  )
)
