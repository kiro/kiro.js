// Generated by CoffeeScript 1.4.0
(function() {

  window.BC.define('common', function(common) {
    return common.bindings = function(initialItems) {
      var addInitializer, binder, el, identity, initializers;
      el = null;
      initializers = [];
      identity = function(x) {
        return x;
      };
      addInitializer = function(initializer) {
        if (!this.id()) {
          this.addAttr({
            id: common.nextId()
          });
        }
        initializers.push(initializer);
        return this;
      };
      binder = function(f, defaultMap) {
        if (defaultMap == null) {
          defaultMap = identity;
        }
        return function(observable, map) {
          if (map == null) {
            map = defaultMap;
          }
          addInitializer.call(this, function() {
            return el[f](map(observable.get()));
          });
          addInitializer.call(this, function() {
            return observable.subscribe(function(newValue) {
              return el[f](map(newValue));
            });
          });
          return this;
        };
      };
      return {
        initBindings: function(element) {
          var initializer, _i, _len, _results;
          el = element;
          _results = [];
          for (_i = 0, _len = initializers.length; _i < _len; _i++) {
            initializer = initializers[_i];
            _results.push(initializer());
          }
          return _results;
        },
        bindValue: function(observable, map) {
          if (map == null) {
            map = identity;
          }
          if (this.subscribe) {
            this.subscribe(function(newValue) {
              return observable.set(newValue);
            });
          }
          binder('val').call(this, observable, map);
          return this;
        },
        bindText: binder('text'),
        bindHtml: binder('html', function(x) {
          return element(x);
        }),
        bindCss: binder('css'),
        bindClass: function(observable, map) {
          var prevClass;
          if (map == null) {
            map = function(x) {
              return x;
            };
          }
          if (!this.id()) {
            this.addAttr({
              id: common.nextId()
            });
          }
          prevClass = map(observable.get());
          this.addAttr({
            "class": prevClass
          });
          observable.subscribe(function(value) {
            el.removeClass(prevClass);
            prevClass = map(value);
            return el.addClass(prevClass);
          });
          return this;
        },
        bindVisible: function(observable, condition) {
          if (condition == null) {
            condition = identity;
          }
          return this.bindCss(observable, function(value) {
            return {
              display: condition(value) ? "" : "none"
            };
          });
        },
        bindDisabled: function(observable, condition) {
          if (condition == null) {
            condition = function(x) {
              return x;
            };
          }
          return this.bindAttr(observable, function(value) {
            return {
              disabled: condition(value)
            };
          });
        },
        bindAttr: binder('attr'),
        on: function(events, selector, handler) {
          var _this = this;
          if (!handler) {
            handler = selector;
            selector = "";
          }
          addInitializer.call(this, function() {
            return el.on(events, selector, _this, handler);
          });
          return this;
        },
        foreach: function(collection, render) {
          var collectionItems, index, item,
            _this = this;
          if (!this.id()) {
            this.addAttr({
              id: common.nextId()
            });
          }
          collectionItems = (function() {
            if (_.isFunction(collection)) {
              return collection();
            } else if (_.isArray(collection)) {
              return collection;
            } else {
              throw Error(collection + " is expected to be an Array or model");
            }
          })();
          index = 0;
          this.addItems.apply(this, (function() {
            var _i, _len, _results;
            _results = [];
            for (_i = 0, _len = collectionItems.length; _i < _len; _i++) {
              item = collectionItems[_i];
              _results.push(render(item, index++));
            }
            return _results;
          })());
          if (_.isFunction(collection)) {
            collection.subscribe(function(newItems, path) {
              var elements;
              elements = (function() {
                var _i, _len, _results;
                _results = [];
                for (_i = 0, _len = initialItems.length; _i < _len; _i++) {
                  item = initialItems[_i];
                  _results.push(common.element(item));
                }
                return _results;
              })();
              index = 0;
              elements = elements.concat((function() {
                var _i, _len, _results;
                _results = [];
                for (_i = 0, _len = newItems.length; _i < _len; _i++) {
                  item = newItems[_i];
                  _results.push(common.element(render(item, index++)));
                }
                return _results;
              })());
              return el.html(elements);
            });
          }
          return this;
        },
        el: function() {
          return el;
        }
      };
    };
  });

}).call(this);
