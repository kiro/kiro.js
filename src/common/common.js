// Generated by CoffeeScript 1.4.0
(function() {
  var __slice = [].slice;

  window.BC.define('common', function(common) {
    var isComposite;
    isComposite = function(item) {
      return item && _.isFunction(item.html) && _.isFunction(item.init);
    };
    common.isValid = function(item) {
      return _.isUndefined(item) || _.isString(item) || _.isNumber(item) || _.isArray(item) || _.isFunction(item.html);
    };
    common.toHtml = function(item) {
      var subitem;
      if (_.isUndefined(item)) {
        return "";
      } else if (isComposite(item)) {
        return item.html();
      } else if (_.isString(item)) {
        return item;
      } else if (_.isNumber(item)) {
        return item;
      } else if (_.isArray(item)) {
        return ((function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = item.length; _i < _len; _i++) {
            subitem = item[_i];
            _results.push(common.toHtml(subitem));
          }
          return _results;
        })()).join(" ");
      } else {
        throw Error(item + " is expected to be String, Number, Array, undefined or have .html() function");
      }
    };
    common.init = function(item, context) {
      var subitem;
      if (_.isUndefined(item)) {

      } else if (isComposite(item)) {
        return item.init(context);
      } else if (_.isString(item)) {

      } else if (_.isNumber(item)) {

      } else if (_.isArray(item)) {
        return ((function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = item.length; _i < _len; _i++) {
            subitem = item[_i];
            _results.push(common.init(subitem, context));
          }
          return _results;
        })()).join(" ");
      } else {
        throw Error(item + " is expected to be String, Number, Array, undefined or have .init() function");
      }
    };
    common.nextId = (function() {
      var id;
      id = 0;
      return function() {
        return ++id;
      };
    })();
    common.observable = function() {
      var listeners;
      listeners = [];
      return {
        subscribe: function(listener) {
          listeners.push(listener);
          return this;
        },
        publish: function(newValue) {
          var listener, _i, _len;
          for (_i = 0, _len = listeners.length; _i < _len; _i++) {
            listener = listeners[_i];
            listener(newValue);
          }
          return this;
        }
      };
    };
    common.element = function(composite) {
      var el;
      if (_.isUndefined(composite)) {

      } else if (_.isString(composite)) {
        return composite;
      } else if (_.isNumber(composite)) {
        return composite;
      } else if (_.isFunction(composite.html)) {
        el = $(composite.html());
        composite.init(el);
        return el;
      } else {
        throw Error(composite + " is expected to be string, number of composite");
      }
    };
    common.partial = function() {
      var fixedArgs, fn;
      fn = arguments[0], fixedArgs = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      return function() {
        var args;
        args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        return fn.apply(null, fixedArgs.concat(args));
      };
    };
    common.once = function(value) {
      var first;
      first = true;
      return function() {
        if (first) {
          first = false;
          return value;
        } else {
          return void 0;
        }
      };
    };
    return common.isComposite = isComposite;
  });

}).call(this);
