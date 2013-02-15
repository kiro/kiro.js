controls = window.BC.namespace("controls")
m = window.BC.namespace("model")

$.extend(this, controls, m)

describe("Models test", ->
  it("", ->) # Empty test, so that the result of the first test can be attached

  it("Shows a standart form", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      form(
        legend : "Legend",
        'Label name' : [
          input.text().placeholder("Type something...")
          help.block("Example block-level help text here.")
        ],
        'Check me out' : input.checkbox(),
        '' : button.submit("Submit me")
      )
    )))
  )

  it("Shows a search form", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      form.search(
        input.text(class: "input-medium search-query"),
        button.submit('Search')
      )
    )))
  )

  it("Shows inline form", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      form.inline(
        input.text(class: "input-small").placeholder("Email"),
        input.password(class: "input-small").placeholder("Password"),
        label({class: 'checkbox'}, input.checkbox(), "Remember me"),
        button.submit("Sign in")
      )
    )))
  )

  it("Shows horizontal form", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      form.horizontal(
        'Email': input.text().placeholder('Email'),
        'Password': input.text().placeholder('Password')
        '' : [ label({class: 'checkbox'}, input.checkbox(), "Remember me"), button.submit("Sign in") ]
      )
    )))
  )

  it("Shows a textarea", ->
    value = model("text")

    $('.suite').append(element(div(class: "bs-docs-example",
      textarea(3).bindValue(value),
      span().bindText(value)
    )))
  )

  it("Shows stacked radio and checkbox", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      label({class: 'checkbox'}, input.checkbox(), "Option 1"),
      label({class: 'radio'}, input.radio("radio", "value1"), "Option 1"),
      label({class: 'radio'}, input.radio("radio", "value2"), "Option 2")
    )))
  )

  it("Shows inline checkboxes", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      label.inline({class: 'checkbox'}, input.checkbox(), "Option 1"),
      label.inline({class: 'radio'}, input.radio("radio", "value1"), "Option 1"),
      label.inline({class: 'radio'}, input.radio("radio", "value2"), "Option 2")
    )))
  )

  it("Tests append", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      append(input.text(), "@"),
      append(input.text(), button("Do it!"), button("Another one!"))
    )))
  )

  it("Tests prepend", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      prepend("@", input.text()),
      prepend(button("Check"), input.text())
    )))
  )

  it("Tests search prepend/append", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      form.search(
        append(
          input.text(class: "input-medium search-query"),
          button.submit('Search')
        ),
        prepend(
          button.submit('Search'),
          input.text(class: "input-medium search-query")
        )
      )
    )))
  )

  it("Tests input sizes", ->
    $('.suite').append(element(div(class: "controls bs-docs-example docs-input-sizes",
      input.text().mini().placeholder('mini'),
      input.text().small().placeholder('small'),
      input.text().medium().placeholder('medium'),
      input.text().large().placeholder('large'),
      input.text().xlarge().placeholder('xlarge'),
      input.text().xxlarge().placeholder('xxlarge')
    )))
  )

  it("Tests input sizes", ->
    items = (option(i) for i in [1..5])

    $('.suite').append(element(div(class: "controls bs-docs-example docs-input-sizes",
      input.text().span2().placeholder('span2'),
      input.text().span4().placeholder('span4'),
      input.text().span6().placeholder('span6'),
      select().span2(items),
      select().span4(items),
      select().span6(items)
    )))
  )

  it("Tests input sizes", ->
    $('.suite').append(element(div(class: "controls bs-docs-example docs-input-sizes",
      div.controls.row(input.text().span1(), input.text().span5()),
      div.controls.row(input.text().span3(), input.text().span3()),
      div.controls.row(input.text().span5(), input.text().span1())
    )))
  )

  it("Shows form actions in aciton", ->
    $('.suite').append(element(div(class: "bs-docs-example",
      form.horizontal(
        {"First Name" : input.text()
        "Last Name" : input.text()},
        button("Submit"), button("Remove")
      )
    )))
  )
)