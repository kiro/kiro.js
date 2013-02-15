controls = window.BC.namespace("controls")
m = window.BC.namespace("model")

$.extend(this, controls, m)

describe("Buttons test", ->
  it("", ->) # Empty test, so that the result of the first test can be attached

  it("Shows different buttons", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      button("Default"),
      button.primary("Primary"),
      button.info("Info"),
      button.warning("Warning"),
      button.success("Success"),
      button.danger("Danger"),
      button.inverse("Inverse"),
      button.link()
    )))
  )

  it("Shows a dropdown buttons", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      dropdown(button.info("Hello"),
        a("Hi"),
        a("How"),
        divider(),
        a("Is it going?"))
      dropdown.segmented(button.info("Hello", -> console.log("Hello")),
        a("Hi", -> console.log("Hi")),
        a("How"),
        divider(),
        a("Is it going?"))
    )))
  )

  it("Shows different button sizes", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      button.primary("Large").large()
      button.info("Default")
      button.warning("Small").small()
      button.danger("Mini").mini()
    )))
  )

  it("Shows block level button", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      button.primary("Block").block().large()
      button("Block").block()
    )))
  )

  it("Shows disabled button", ->
    disabled = model(true)
    $('.suite').append(element(div(class: "bs-docs-example",
      button.danger("Disable", -> disabled(true))
      button.success("Enable", -> disabled(false))
      button("Disabled").bindDisabled(disabled)
    )))
  )
)