// Generated by CoffeeScript 1.4.0
(function() {
  var bootstrap, docs, models;

  docs = window.BC.namespace("docs");

  docs.api = window.BC.namespace("docs.api");

  bootstrap = window.BC.namespace("bootstrap");

  models = window.BC.namespace("models");

  $.extend(this, bootstrap, models, docs);

  docs.api.index = function(content) {
    if (content == null) {
      content = docs.api.model();
    }
    return div(div().span3(nav(a({
      href: '#/api/model/'
    }, "Model"), a({
      href: '#/api/collection/'
    }, "Collection"), a({
      href: '#/api/bindings/'
    }, "Bindings"), docs.toLi).addClass('nav-list bs-docs-sidenav sidenav affix')), div().span9(content));
  };

}).call(this);
