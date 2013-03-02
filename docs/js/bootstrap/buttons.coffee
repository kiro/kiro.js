docs = window.BC.namespace("docs")
docs.bootstrap = window.BC.namespace("docs.bootstrap")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.bootstrap.buttons = -> section(h1("Buttons"),
  example("Button styles", "Button styles for different actions", ->
    text = model("")

    body(
      button("Default", -> text("I'm default"))
      button.primary("Primary", -> text("Take this primary"))
      button.info("Info", -> text("Info, info"))
      button.warning("Warning", -> text("Warning"))
      button.success("Success", -> text("Success"))
      button.danger("Danger", -> text("Danger"))
      button.inverse("Inverse", -> text("Inverse"))
      button.link("Link", -> text("Link"))
      span().bindText(text)
    )
  )

  example("Dropdown buttons", "Creating dropdown and segmented dropdown buttons", ->
    body(
      dropdown(
        button.info("Hello")
        a("Hi")
        a("How")
        dropdown.divider()
        a("Is it going?"))
      dropdown.segmented(
        button.info("Hello", -> console.log("Hello"))
        a("Hi", -> console.log("Hi"))
        a("How")
        dropdown.divider()
        a("Is it going?"))
    )
  )

  example("Button sizes", "Builder methods for different button sizes", ->
    body(
      button.primary("Large").large()
      button.info("Default")
      button.warning("Small").small()
      button.danger("Mini").mini()
    )
  )

  example("Block level buttons", "Creating block level buttons", ->
    body(
      button.primary("Block").block().large()
      button("Block").block()
    )
  )

  example("Disabled button", "Binding the disabled property of a button", ->
    disabled = model(true)

    body(
      button.danger("Disable", -> disabled(true))
      button.success("Enable", -> disabled(false))
      button("Disabled")
        .bindDisabled(disabled)
        .bindText(disabled, -> (if disabled() then "Disabled" else "Enabled"))
    )
  )

  example("Single button group", "Group button together", ->
    body(
      button.group(
        button("One")
        button.success("Two")
        button.danger("Three")
      )
    )
  )

  example("Button toolbar", "Put groups of button together", ->
    body(
      button.toolbar(
        button.group(
          button("1")
          button("2")
          button("3")
        )
        button.group(
          button("4")
          button("5")
        )
        button.group(
          button("6")
        )
      )
    )
  )

  example("Button group vertical", "Stack buttons vertically", ->
    body(
      button.group.vertical(
        button(icon.arrow_down)
        button(icon.arrow_left)
        button(icon.arrow_right)
        button(icon.arrow_up)
      )
    )
  )
)