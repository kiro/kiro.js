common = window.BC.namespace("common")

nextId = ( ->
  id = 0
  -> ++id
)()

timePicker = (config) ->
  el = input.text().timepicker(config)

datePicker = (config) ->
  input.text().datepicker()

dateTimePicker = ->
  time = timePicker()
  date = datePicker()

