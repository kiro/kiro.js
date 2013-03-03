docs = window.BC.namespace("docs")
docs.bootstrap = window.BC.namespace("docs.bootstrap")
bootstrap = window.BC.namespace("bootstrap")

$.extend(this, bootstrap, docs)

docs.bootstrap.table = -> section(h1("Tables"),
  docs.code.table()

  example("Table", "Table construction.", ->
    body(
      table(
        thead(tr( (th("Column " + i) for i in [1 .. 5])) ),
        (tr( (td(i + "," + j) for j in [1..5]) ) for i in [1..5])
      )
    )
  )

  example("Stripped table", "Builder method for stripped table.", ->
    body(
      table().stripped(
        thead(tr( (th("Column " + i) for i in [1 .. 5])) ),
        (tr( (td(i + "," + j) for j in [1..5]) ) for i in [1..5])
      )
    )
  )

  example("Mega table", "Using builder methods for different table classes, each of them can take as a parameter the content of the table.", ->
    body(
      table().stripped().condensed().hover().bordered(
        thead(tr( (th("Column " + i) for i in [1 .. 5])) ),
        (tr( (td(i + "," + j) for j in [1..5]) ) for i in [1..5])
      )
    )
  )

  example("Row classes", "Builder methods for table row style, each of them can take the row content.", ->
    body(
      table(
        tr().info(td(1), td(2)),
        tr().warning(td(3), td(4)),
        tr().success(td(5), td(6)),
        tr().error(td(7), td(8))
      )
    )
  )
)