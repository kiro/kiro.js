docs = window.BC.namespace("docs")
docs.bootstrap = window.BC.namespace("docs.bootstrap")
bootstrap = window.BC.namespace("bootstrap")

$.extend(this, bootstrap, docs)

docs.bootstrap.type = -> section(h1("Typography"),
  docs.code.type()

  example("Headings", "Heading styles, correspond to the html tags.", ->
    body(
      h1("Heading 1")
      h2("Heading 2")
      h3("Heading 3")
      h4("Heading 4")
      h5("Heading 5")
      h6("Heading 6")
    )
  )

  example("Emphasis", "Emphasis methods.", ->
    body(
      p(small("Small text"))
      p(bold("Bold text"))
      p(italic("Italics text"))
      p().lead("Lead paragraph")
    )
  )

  example("Text context", "Using builder methods for highlighting the content of a p, each of them can accept the content.", ->
    body(
      p().muted("Fusce dapibus, tellus ac cursus commodo, tortor mauris nibh.")
      p().warning("Etiam porta sem malesuada magna mollis euismod.")
      p().error("Donec ullamcorper nulla non metus auctor fringilla.")
      p().success("Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis.")
      p().info("Duis mollis, est non commodo luctus, nisi erat porttitor ligula.  ")
    )
  )

  example("Address", "Address building", ->
    body(
      address(
        bold("Full Name")
        "Address line 1"
        "Address line 2"
        '<abbr title="Phone">P:</abbr> (123) 456-7890'
      )
    ))

  example("Blockquote", "Using blockquotes.", ->
    body(
      blockquote(
        p("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.")
        small("Kiril Minkov")
      )
    )
  )

  example("List", "", ->
    body(
      ul(
        li('Item 1')
        li('Item 2')
        li('Item 3')
        li('Item 4')
      )
    )
  )

  example("Ordered list", "", ->
    body(
      ol(
        li('Item 1')
        li('Item 2')
        li('Item 3')
        li('Item 4')
      )
    )
  )

  example("Unstyled list", "", ->
    body(
      ul.unstyled(
        li('Item 1')
        li('Item 2')
        li('Item 3')
        li('Item 4')
      )
    )
  )

  example("Inline list", "The ul element has predefined class for inline list.", ->
    body(
      ul.inline(
        li('Item 1')
        li('Item 2')
        li('Item 3')
        li('Item 4')
      )
    )
  )

  example("Description list", "Direct corrspondance with the html elements.", ->
    body(
      dl(
        dt('Description 1')
        dd(span().success('Item 2'))
        dt('Description 3')
        dd(span().warning('Item 4'))
      )
    )
  )

  example("Horizontal description list", "dl has predefined class for horizontal list.", ->
    body(
      dl.horizontal(
        dt('Description 1')
        dd(span().success('Item 2'))
        dt('Description 3')
        dd(span().warning('Item 4'))
      )
    )
  )

  example("Code", "Code inlining.", ->
    body(
      span("For example,", code('System.out.pintln("Hello World")'), 'should be wrapped as inline.')
    )
  )

  example("Pre", "Pre", ->
    body(
      pre(
        "code",
        "code"
      )
    )
  )

  example("Labels", 'Use label to specify different label classes', ->
    body(
      type.label('default')
      type.label().info("info")
      type.label().warning('warning')
      type.label().inverse('inverse')
      type.label().important('error')
      type.label().success('success')
    )
  )

  example("Badges", 'Use badge to specify different badge classes', ->
    body(
      type.badge('default')
      type.badge().info("info")
      type.badge().warning('warning')
      type.badge().inverse('inverse')
      type.badge().important('error')
      type.badge().success('success')
    )
  )
)
