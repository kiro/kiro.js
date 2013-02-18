// Generated by CoffeeScript 1.4.0
(function() {
  var bootstrap, common, div, mixins,
    __slice = [].slice;

  bootstrap = window.BC.namespace("bootstrap");

  mixins = window.BC.namespace("bootstrap.mixins");

  common = window.BC.namespace("common");

  $.extend(this, common);

  div = function(config) {
    return function() {
      var items;
      items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return $.extend(tag('div', config).apply(null, items), mixins.spannable(), mixins.offsetable());
    };
  };

  bootstrap.div = div();

  bootstrap.div.row = div({
    "class": "row"
  });

  bootstrap.div.row.fluid = div({
    "class": "row-fluid"
  });

  bootstrap.div.container = div({
    "class": "container"
  });

  bootstrap.div.container.fluid = div({
    "class": "container-fluid"
  });

  bootstrap.div.controls = div({
    "class": "controls"
  });

  bootstrap.div.controls.row = div({
    "class": "controls controls-row"
  });

  bootstrap.left = div({
    "class": "pull-left"
  });

  bootstrap.right = div({
    "class": "pull-right"
  });

  bootstrap.center = div({
    style: "text-align:center"
  });

}).call(this);
