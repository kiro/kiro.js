mixins = window.BC.namespace("bootstrap.mixins")

mixins.spannable = ->
  span = (size) ->
    (args...) -> this.addClassAndItems('span' + size, args...)

  span1: span(1)
  span2: span(2)
  span3: span(3)
  span4: span(4)
  span5: span(5)
  span6: span(6)
  span7: span(7)
  span8: span(8)
  span9: span(9)
  span10: span(10)
  span11: span(11)
  span12: span(12)

mixins.offsetable = ->
  offset = (size) ->
    (args...) -> this.addClassAndItems("offset" + size, args...)

  offset1: offset(1)
  offset2: offset(2)
  offset3: offset(3)
  offset4: offset(4)
  offset5: offset(5)
  offset6: offset(6)
  offset7: offset(7)
  offset8: offset(8)
  offset9: offset(9)
  offset10: offset(10)
  offset11: offset(11)
  offset12: offset(12)

mixins.contextual = (prefix) ->
  context = (suffix) ->
    (args...) ->
      if prefix then prefix = prefix + "-"
      this.addClassAndItems(prefix + suffix, args...)

  info: context('info')
  warning: context('warning')
  error: context('error')
  success: context('success')
  inverse: context('inverse')

mixins.textContextual = -> $.extend(mixins.contextual('text'),
  muted: (args...) -> this.addClassAndItems("muted", args)
)

mixins.sizeable = (prefix) ->
  size = (suffix) ->
    () ->
      if prefix then prefix = prefix + "-"
      this.addClass(prefix + suffix)

  mini: size("mini")
  small: size("small")
  medium: size("medium")
  large: size("large")
  xlarge: size("xlarge")
  xxlarge: size("xxlarge")

