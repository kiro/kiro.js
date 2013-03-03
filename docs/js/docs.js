// Generated by CoffeeScript 1.4.0
(function() {
  var bootstrap, docs,
    __slice = [].slice;

  bootstrap = window.BC.namespace("bootstrap");

  docs = window.BC.namespace("docs");

  $.extend(this, bootstrap);

  docs.example = function(title, description, content) {
    return div(h2(title), p(description), content(), pre({
      "class": 'prettyprint linenums',
      id: 'code ' + title
    }));
  };

  docs.body = function() {
    var items;
    items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return div(items).addClass('bs-docs-example');
  };

}).call(this);
