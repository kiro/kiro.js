bootstrap = window.BC.namespace("bootstrap")

$.extend(this, bootstrap)

element(table(tr(td(1), td(2), td(3))))

describe("Table tests", ->
  it("", ->) # Empty test, so that the result of the first test can be attached

  it("5x5 Table", ->
    show(
      table(
        thead(tr( (th("Column " + i) for i in [1 .. 5])) ),
        (tr( (td(i + "," + j) for j in [1..5]) ) for i in [1..5])
      )
    )
  )

  it("Stripped table", ->
    show(
      table().stripped(
        thead(tr( (th("Column " + i) for i in [1 .. 5])) ),
        (tr( (td(i + "," + j) for j in [1..5]) ) for i in [1..5])
      )
    )
  )

  it("Mega table", ->
    show(
      table().stripped().condensed().hover().bordered(
        thead(tr( (th("Column " + i) for i in [1 .. 5])) ),
        (tr( (td(i + "," + j) for j in [1..5]) ) for i in [1..5])
      )
    )
  )

  it("Row classes", ->
    show(
      table(
        tr().info(td(1), td(2)),
        tr().warning(td(3), td(4)),
        tr().success(td(5), td(6)),
        tr().error(td(7), td(8))
      )
    )
  )
)