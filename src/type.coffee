common = BC.namespace("controls")
controls = BC.namespace("controls")
mixins = window.BC.namespace("mixins")

$.extend(this, common)

h = (size) -> curry(tag("h" + size), "")

controls.h1 = h(1)
controls.h2 = h(2)
controls.h3 = h(3)
controls.h4 = h(4)
controls.h5 = h(5)
controls.h6 = h(6)

pElement = tag("p")

# TODO(kiro): how to deal with different parameters, maybe pass an object
controls.p = (args...) ->
  if args.length > 0 and args.length != 2
    pElement("", args)
  else if args.length == 2
    pElement(args[0], args[1])
  else if args.length == 0
    $.extend(
      mixins.control(),
      mixins.textContextual()
      mixins.composite(pElement)
      lead: curry(pElement, 'lead')
    )

controls.span = (args...) ->
  spanElement = tag("span")
  if args.length != 0
    spanElement(args...)
  else
    $.extend(
      mixins.control(),
      mixins.textContextual(),
      mixins.composite(spanElement)
    )

controls.address = (values...) ->
  elements = []
  for value in values
    elements.push(value)
    elements.push('<br>')
  elements.pop()

  tag('address')('', elements)

# Text
controls.blockquote = curry(tag('blockquote'), '')
controls.small = curry(tag('small'), '')
controls.bold = curry(tag('strong'), '')
controls.strong = controls.bold
controls.italic = curry(tag('em'), '')
controls.em = controls.italic

# Lists
controls.ul = curry(tag('ul'), '')
controls.ul.unstyled = curry(tag('ul'), 'unstyled')
controls.ul.inline = curry(tag('ul'), 'inline')
controls.li = curry(tag('li'), '')
controls.ol = curry(tag('ol'), '')
controls.dl = curry(tag('dl'), '')
controls.dl.horizontal = curry(tag('dl'), 'dl-horizontal')
controls.dt = curry(tag('dt'), '')
controls.dd = curry(tag('dd'), '')

# Code
controls.code = curry(tag('code'), '')
controls.pre = curry(tag('pre'), '')
controls.pre.scrollable = curry(tag('pre'), '.pre-scrollable')


