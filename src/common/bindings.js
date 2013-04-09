// Generated by CoffeeScript 1.4.0
(function() {

  window.BC.define('common', function(common) {
    return common.bindings = function(initialItems) {
      var addInitializer, binder, domUpdated, el, identity, initializers, updateHandlers, _el;
      _el = null;
      initializers = [];
      updateHandlers = [];
      identity = function(x) {
        return x;
      };
      el = function(value) {
        if (!_.isUndefined(value)) {
          return _el = value;
        } else {
          return _el;
        }
      };
      domUpdated = function() {
        var handler, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = updateHandlers.length; _i < _len; _i++) {
          handler = updateHandlers[_i];
          _results.push(handler(_el));
        }
        return _results;
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
            el()[f](map(observable.get()));
            return domUpdated();
          });
          addInitializer.call(this, function() {
            return observable.subscribe(function(newValue) {
              el()[f](map(newValue));
              return domUpdated();
            });
          });
          return this;
        };
      };
      return {
        initBindings: function(element) {
          var initializer, _i, _len, _results;
          el(element);
          _results = [];
          for (_i = 0, _len = initializers.length; _i < _len; _i++) {
            initializer = initializers[_i];
            _results.push(initializer());
          }
          return _results;
        },
        setValue: function() {},
        bindValue: function(observable) {
          var valueHandler;
          valueHandler = function(newValue) {
            el().val(newValue);
            return domUpdated();
          };
          this.setValue = function(newValue) {
            observable.unsubscribe(valueHandler);
            observable.set(newValue);
            return observable.subscribe(valueHandler);
          };
          addInitializer.call(this, function() {
            el().val(observable.get());
            return domUpdated();
          });
          addInitializer.call(this, function() {
            return observable.subscribe(valueHandler);
          });
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
            el().removeClass(prevClass);
            prevClass = map(value);
            el().addClass(prevClass);
            return domUpdated();
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
        bindAttr: binder('prop'),
        on: function(events, selector, handler) {
          var _this = this;
          if (!handler) {
            handler = selector;
            selector = "";
          }
          addInitializer.call(this, function() {
            return el().on(events, selector, _this, handler);
          });
          return this;
        },
        onUpdate: function(handler) {
          updateHandlers.push(handler);
          return this;
        },
        onInit: function(handler) {
          return addInitializer.call(this, function() {
            return handler(el());
          });
        },
        foreach: function(collection, render) {
          var add, collectionItems, getElOrTbody, index, item, remove, removeItems, renderAll, tag, updateItem;
          getElOrTbody = function() {
            var tbody;
            tbody = el().children('tbody');
            if (tbody.length !== 0) {
              return tbody;
            } else {
              return el();
            }
          };
          tag = this;
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
          add = function(value, index) {
            if (index === -1) {
              return;
            }
            if (getElOrTbody().children().length === 0 || index === 0) {
              getElOrTbody().prepend(common.element(render(value, index, tag)));
            } else {
              getElOrTbody().children().eq(index - 1).after(common.element(render(value, index, tag)));
            }
            return domUpdated();
          };
          remove = function(index) {
            getElOrTbody().children().eq(index).remove();
            return domUpdated();
          };
          renderAll = function(items) {
            var elements;
            index = 0;
            elements = (function() {
              var _i, _len, _results;
              _results = [];
              for (_i = 0, _len = initialItems.length; _i < _len; _i++) {
                item = initialItems[_i];
                _results.push(common.element(item));
              }
              return _results;
            })();
            elements = elements.concat((function() {
              var _i, _len, _results;
              _results = [];
              for (_i = 0, _len = items.length; _i < _len; _i++) {
                item = items[_i];
                _results.push(common.element(render(item, index++)));
              }
              return _results;
            })());
            el().html(elements);
            return domUpdated();
          };
          removeItems = function(items, indexes) {
            var _i, _len, _results;
            indexes = indexes.sort().reverse();
            _results = [];
            for (_i = 0, _len = indexes.length; _i < _len; _i++) {
              index = indexes[_i];
              _results.push(remove(index));
            }
            return _results;
          };
          updateItem = function(value, index, oldIndex) {
            if (index < oldIndex) {
              add(value, index);
              return remove(oldIndex + (index === -1 ? 0 : 1));
            } else if (index > oldIndex) {
              remove(oldIndex);
              return add(value, index);
            }
          };
          if (_.isFunction(collection.subscribe)) {
            collection.subscribe({
              replaceAll: renderAll,
              updateView: renderAll,
              add: add,
              remove: removeItems,
              update: updateItem
            });
          }
          return this;
        },
        el: el
      };
    };
  });

}).call(this);
