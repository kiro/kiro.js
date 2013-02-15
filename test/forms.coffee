util = window.BC.namespace("test.util")
controls = window.BC.namespace("controls")
m = window.BC.namespace("model")

$.extend(this, controls, m, util)

describe("Models test", ->
  it("", ->) # Empty test, so that the result of the first test can be attached

  it("Shows a standart form", ->
    show(
      form(
        legend : "Legend",
        'Label name' : [
          input.text().placeholder("Type something...")
          help.block("Example block-level help text here.")
        ],
        'Check me out' : input.checkbox(),
        '' : button.submit("Submit me")
      )
    )
  )

  it("Shows a search form", ->
    show(
      form.search(
        input.text(class: "input-medium search-query"),
        button.submit('Search')
      )
    )
  )

  it("Shows inline form", ->
    show(
      form.inline(
        input.text(class: "input-small").placeholder("Email"),
        input.password(class: "input-small").placeholder("Password"),
        label({class: 'checkbox'}, input.checkbox(), "Remember me"),
        button.submit("Sign in")
      )
    )
  )

  it("Shows horizontal form", ->
    show(
      form.horizontal(
        'Email': input.text().placeholder('Email'),
        'Password': input.text().placeholder('Password')
        '' : [ label({class: 'checkbox'}, input.checkbox(), "Remember me"), button.submit("Sign in") ]
      )
    )
  )

  it("Shows a textarea", ->
    value = model("text")

    show(
      textarea(3).bindValue(value),
      span().bindText(value)
    )
  )

  it("Shows stacked radio and checkbox", ->
    show(
      label({class: 'checkbox'}, input.checkbox(), "Option 1"),
      label({class: 'radio'}, input.radio("radio", "value1"), "Option 1"),
      label({class: 'radio'}, input.radio("radio", "value2"), "Option 2")
    )
  )

  it("Shows inline checkboxes", ->
    show(
      label.inline({class: 'checkbox'}, input.checkbox(), "Option 1"),
      label.inline({class: 'radio'}, input.radio("radio", "value1"), "Option 1"),
      label.inline({class: 'radio'}, input.radio("radio", "value2"), "Option 2")
    )
  )

  it("Tests append", ->
    show(
      append(input.text(), "@"),
      append(input.text(), button("Do it!"), button("Another one!"))
    )
  )

  it("Tests prepend", ->
    show(
      prepend("@", input.text()),
      prepend(button("Check"), input.text())
    )
  )

  it("Tests search prepend/append", ->
    show(
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
    )
  )

  it("Tests input sizes", ->
    show(div(class: "controls docs-input-sizes",
      input.text().mini().placeholder('mini'),
      input.text().small().placeholder('small'),
      input.text().medium().placeholder('medium'),
      input.text().large().placeholder('large'),
      input.text().xlarge().placeholder('xlarge'),
      input.text().xxlarge().placeholder('xxlarge')
    ))
  )

  it("Tests input sizes", ->
    items = (option(i) for i in [1..5])

    show(div(class: "controls docs-input-sizes",
      input.text().span2().placeholder('span2'),
      input.text().span4().placeholder('span4'),
      input.text().span6().placeholder('span6'),
      select().span2(items),
      select().span4(items),
      select().span6(items)
    ))
  )

  it("Tests input sizes", ->
    show(div(class: "docs-input-sizes",
      div.controls.row(input.text().span1(), input.text().span5()),
      div.controls.row(input.text().span3(), input.text().span3()),
      div.controls.row(input.text().span5(), input.text().span1())
    ))
  )

  it("Shows form actions in aciton", ->
    show(
      form.horizontal(
        {"First Name" : input.text()
        "Last Name" : input.text()},
        button("Submit"), button("Remove")
      )
    )
  )

  it("Shows different image styles", ->
    show(
      img(class:'image', src: 'img.jpeg')
      img.polaroid(class:'image', src: 'img.jpeg')
      img.circle(class:'image', src: 'img.jpeg')
      img.rounded(class:'image', src: 'img.jpeg')
    )
  )

  it("Shows icons", ->
    show(
      [value for name, value of icon]
    )
  )

  it("Shows buttons with icons", ->
    show(
      button(icon.asterisk, "Asterisk"),
      form(
        "Email" : prepend(icon.envelope, input.text())
      )

      ul(class: "nav nav-list",
        li({class: "active"}, a(icon.home, 'Home')),
        li(a(icon.book, 'Library')),
        li(a(icon.pencil, "Applications")),
        li(a("Misc"))
      )
    )
  )
)