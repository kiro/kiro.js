common = BC.namespace("common")
bootstrap = window.BC.namespace("bootstrap")
mixins = window.BC.namespace("bootstrap.mixins")

$.extend(this, common)

h = (size) -> tag("h" + size)

bootstrap.h1 = h(1)
bootstrap.h2 = h(2)
bootstrap.h3 = h(3)
bootstrap.h4 = h(4)
bootstrap.h5 = h(5)
bootstrap.h6 = h(6)

# TODO(kiro): how to deal with different parameters, maybe pass an object
bootstrap.p = (args...) -> $.extend(
  tag("p")(args...)
  mixins.textContextual()
  lead: -> this.addClass('lead')
)

bootstrap.span = (args...) -> $.extend(
  tag("span")(args...)
  mixins.textContextual()
)

bootstrap.address = (values...) ->
  elements = []
  for value in values
    elements.push(value)
    elements.push('<br>')
  elements.pop()

  tag('address')(elements)

# Text
bootstrap.blockquote = tag('blockquote')
bootstrap.small = tag('small')
bootstrap.bold = tag('strong')
bootstrap.strong = bootstrap.bold
bootstrap.italic = tag('em')
bootstrap.em = bootstrap.italic

# Lists
bootstrap.ul = tag('ul')
bootstrap.ul.unstyled = tag('ul', class: 'unstyled')
bootstrap.ul.inline = tag('ul', class: 'inline')
bootstrap.li = tag('li')
bootstrap.ol = tag('ol')
bootstrap.dl = tag('dl')
bootstrap.dl.horizontal = tag('dl', class: 'dl-horizontal')
bootstrap.dt = tag('dt')
bootstrap.dd = tag('dd')

# Code
bootstrap.code = tag('code')
bootstrap.pre = tag('pre')
bootstrap.pre.scrollable = tag('pre', class: '.pre-scrollable')

# Section
bootstrap.section = tag('section')
bootstrap.pageHeader = tag('div', class: 'page-header')


