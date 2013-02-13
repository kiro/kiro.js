common = BC.namespace("controls")
controls = BC.namespace("controls")
mixins = window.BC.namespace("mixins")

$.extend(this, common)

h = (size) -> tag("h" + size)

controls.h1 = h(1)
controls.h2 = h(2)
controls.h3 = h(3)
controls.h4 = h(4)
controls.h5 = h(5)
controls.h6 = h(6)

# TODO(kiro): how to deal with different parameters, maybe pass an object
controls.p = (args...) -> $.extend(
  tag("p")(args...)
  mixins.textContextual()
  lead: -> this.addClass('lead')
)

controls.span = (args...) -> $.extend(
  tag("span")(args...)
  mixins.textContextual()
)

controls.address = (values...) ->
  elements = []
  for value in values
    elements.push(value)
    elements.push('<br>')
  elements.pop()

  tag('address')(elements)

# Text
controls.blockquote = tag('blockquote')
controls.small = tag('small')
controls.bold = tag('strong')
controls.strong = controls.bold
controls.italic = tag('em')
controls.em = controls.italic

# Lists
controls.ul = tag('ul')
controls.ul.unstyled = tag('ul', 'unstyled')
controls.ul.inline = tag('ul', 'inline')
controls.li = tag('li')
controls.ol = tag('ol')
controls.dl = tag('dl')
controls.dl.horizontal = tag('dl', 'dl-horizontal')
controls.dt = tag('dt')
controls.dd = tag('dd')

# Code
controls.code = tag('code')
controls.pre = tag('pre')
controls.pre.scrollable = tag('pre', '.pre-scrollable')


