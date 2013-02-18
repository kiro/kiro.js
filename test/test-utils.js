// Generated by CoffeeScript 1.4.0
(function() {
  var html, util,
    __slice = [].slice;

  util = window.BC.namespace("test.util");

  html = window.BC.namespace("html");

  util.show = function() {
    var items;
    items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return $('.suite').last().append(element(div(items)));
  };

  util.click = function(text) {
    return $(".suite").last().find(":contains(" + text + ")").last().click();
  };

  util.el = function(text) {
    return $(":contains(" + text + ")").last();
  };

}).call(this);