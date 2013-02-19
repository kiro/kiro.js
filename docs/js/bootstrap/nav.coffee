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
)