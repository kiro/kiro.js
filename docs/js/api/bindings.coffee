docs = window.BC.namespace("docs")
bootstrap = window.BC.namespace("bootstrap")
models = window.BC.namespace("models")

$.extend(this, bootstrap, models, docs)

docs.bindings = -> section("Bindings",
  p("""Each html element offers number of bindings, which allow to bind the value of a certain
      property to a model. The values of the bindings update automatically when the
      model changes. Each binding applies the builder pattern so they can be chained.
    """)
  example("bindValue", """
      Binds the value of an element to a model. It's available for input and textarea elements.

      <code>bindValue(model)</code>

    """, ->
    text = model("initial")
    sex = model("female")
    married = model(false)

    body(
      form.inline(
        input.text().bindValue(text)
        span().bindText(text)
        button.info("Clear", -> text(""))
      )

      input.radio("sex", "male").label("Male").bindValue(sex)
      input.radio("sex", "female").label("Female").bindValue(sex)
      input.radio("sex", "other").label("Other").bindValue(sex)
      span().bindText(sex)

      input.checkbox().label("Married").bindValue(married)
      span().bindText(married)
    )
  )

  example("bindCss", """Binds css properties of an element to a model. It expects the value of the model to be
      an object whose fields are names of css properties and have corresponding values.""", ->

    radius = model(1)

    body(
      div(class: 'square').bindCss(
        radius.get((value) ->
          'border-radius': value
        )
      )
      button("+1", -> radius(radius() + 1))
    )
  )

  example("bindClass", "", ->)
  example("bindText", "", ->)
  example("bindHtml", "", ->)
  example("bindDisabled", "", ->)
  example("bindVisible", "", ->)
  example("foreach", "", ->)
)