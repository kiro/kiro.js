html = window.BC.namespace("html")
common = window.BC.namespace("common")

$.extend(this, common)

composite = ['abbr', 'address', 'b', 'blockquote', 'caption', 'cite', 'code', 'dd', 'div', 'dl', 'dt', 'em', 'fieldset',
             'footer', 'form', 'h1', 'h2', 'h3', 'h5', 'h6', 'header', 'label', 'legend', 'li', 'nav', 'ol', 'optgroup',
             'option', 'p', 'pre', 'q', 'section', 'small', 'span', 'strong', 'sub', 'table', 'tbody', 'td', 'tfoot',
             'th', 'thead', 'tr', 'tt', 'u', 'ul']
clickable = ['a', 'button']
single = ['br', 'hr']

html.div = tag("div")
html.input = (config) -> tag('input', config)()
    .observable()
    .on('keyup change', (e) -> e.data.publish($(this).val()))

html.input.text = -> html.input(type: 'text')
html.span = tag("span")

# TODO(kiro): make it to accept multiple parameters for the name
html.button = (name, click) ->
  tag('button')(name).on('click', click)


#html.img
#html.select
#html.textarea




