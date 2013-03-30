// Generated by CoffeeScript 1.4.0
(function() {
  var __slice = [].slice;

  window.BC.define('bootstrap', function(bootstrap) {
    var common, form, getModel, img, mixins, models, toAddOn;
    mixins = window.BC.namespace("bootstrap.mixins");
    common = window.BC.namespace("common");
    models = window.BC.namespace("models");
    $.extend(this, common);
    getModel = function(items) {
      var model;
      model = _.last(items);
      if (_.isUndefined(model) || !common.isModel(model)) {
        model = models.model("");
      } else {
        items.pop();
      }
      return model;
    };
    bootstrap.input = {
      text: function() {
        var items, model;
        items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        model = getModel(items);
        return $.extend(tag('input', {
          type: 'text'
        }).apply(null, items).observable().on('keyup change', function(e) {
          return e.data.publish($(this).val());
        }).bindValue(model), {
          placeholder: function(value) {
            return this.addAttr({
              'placeholder': value
            });
          }
        }, mixins.sizeable("input"), mixins.spannable());
      },
      password: function(model) {
        return this.text({
          type: 'password'
        }, model);
      },
      search: function(model) {
        return this.text({
          "class": "search-query",
          type: 'text'
        }, model);
      },
      checkbox: function() {
        var items, model;
        items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        model = getModel(items);
        return $.extend(tag('input')().addAttr({
          type: 'checkbox'
        }).observable().on('click', function(e) {
          return e.data.publish($(this).is(':checked'));
        }), {
          bindValue: function(observable) {
            this.bindAttr(observable, function() {
              return {
                checked: observable._get()
              };
            });
            return this.subscribe(function(value) {
              return observable._set(value);
            });
          },
          isCheckbox: true
        }).bindValue(model);
      },
      radio: function(name, value, model) {
        if (_.isUndefined(model)) {
          model = models.model("");
        }
        return $.extend(tag('input', {
          type: 'radio',
          name: name,
          value: value
        })().observable().on('click', function(e) {
          return e.data.publish(value);
        }), {
          bindValue: function(observable) {
            this.bindAttr(observable, function() {
              return {
                checked: observable._get() === value
              };
            });
            return this.subscribe(function(value) {
              return observable._set(value);
            });
          },
          isRadio: true
        }).bindValue(model);
      },
      submit: function(name, click) {
        return tag('input')(name).addAttr({
          type: 'submit'
        }).on('click', click);
      }
    };
    bootstrap.select = function() {
      var items, model;
      items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      model = getModel(items);
      return $.extend(tag('select').apply(null, items).observable().on('change', function(e) {
        return e.data.publish($(this).val());
      }).bindValue(model), mixins.spannable());
    };
    bootstrap.select.multiple = function(model) {
      return bootstrap.select(model, {
        multiple: 'multiple'
      });
    };
    bootstrap.option = function(text, value) {
      return tag('option', {
        value: value
      })(text);
    };
    bootstrap.textarea = function() {
      var items, model;
      items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      model = getModel(items);
      return tag('textarea').apply(null, items).observable().on('keyup', function(e) {
        return e.data.publish($(this).val());
      }).bindValue(model);
    };
    form = tag('form');
    bootstrap.form = function() {
      var actions, content, items, key, value;
      items = arguments[0], actions = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      content = [];
      for (key in items) {
        value = items[key];
        if (key === 'legend') {
          content.push(legend(value));
        } else if (value.isCheckbox) {
          content.push(label({
            "class": 'checkbox'
          }, value, key));
        } else if (key === "") {
          content.push(value);
        } else {
          content.push(label(key));
          content.push(value);
        }
      }
      return form(fieldset.apply(null, [content].concat(__slice.call(actions))));
    };
    bootstrap.form.actions = function() {
      var actions;
      actions = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return div({
        "class": "form-actions"
      }, actions);
    };
    bootstrap.form.search = function() {
      var items;
      items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return form({
        "class": "form-search"
      }, items);
    };
    bootstrap.form.inline = function() {
      var items;
      items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return form({
        "class": "form-inline"
      }, items);
    };
    bootstrap.form.horizontal = function() {
      var actions, content, control, group, items, key, value;
      items = arguments[0], actions = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      group = function() {
        var items;
        items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        return div({
          "class": 'control-group'
        }, items);
      };
      control = function() {
        var items;
        items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        return div({
          "class": 'controls'
        }, items);
      };
      content = [];
      for (key in items) {
        value = items[key];
        if (key === 'legend') {
          content.push(legend(value));
        } else if (value.isCheckbox) {
          content.push(group(control(label({
            "class": 'checkbox'
          }, value, key))));
        } else if (key === "") {
          content.push(group(control(value)));
        } else {
          content.push(group(label({
            "class": "control-label"
          }, key), control(value)));
        }
      }
      return form({
        "class": 'form-horizontal'
      }, content, actions);
    };
    bootstrap.form.actions = function() {
      var items;
      items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return div({
        "class": "form-actions"
      }, items);
    };
    bootstrap.help = {
      block: function(text) {
        return bootstrap.span({
          "class": 'help-block'
        }, text);
      },
      inline: function(text) {
        return bootstrap.span({
          "class": 'help-inline'
        }, text);
      }
    };
    bootstrap.legend = tag('legend');
    bootstrap.fieldset = tag('fieldset');
    bootstrap.label = tag('label');
    bootstrap.label.inline = tag('label', {
      "class": 'inline'
    });
    toAddOn = function(item) {
      if (_.isString(item)) {
        return bootstrap.span({
          "class": 'add-on'
        }, item);
      } else {
        return item;
      }
    };
    bootstrap.append = function() {
      var input, item, items;
      input = arguments[0], items = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      items = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = items.length; _i < _len; _i++) {
          item = items[_i];
          _results.push(toAddOn(item));
        }
        return _results;
      })();
      return div({
        "class": "input-append"
      }, input, items);
    };
    bootstrap.prepend = function() {
      var item, items;
      items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      items = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = items.length; _i < _len; _i++) {
          item = items[_i];
          _results.push(toAddOn(item));
        }
        return _results;
      })();
      return div({
        "class": "input-prepend"
      }, items);
    };
    img = function(initialConfig) {
      if (initialConfig == null) {
        initialConfig = {};
      }
      return function(config) {
        return tag('img', initialConfig)(config);
      };
    };
    bootstrap.img = img();
    bootstrap.img.rounded = img({
      "class": 'img-rounded'
    });
    bootstrap.img.circle = img({
      "class": 'img-circle'
    });
    return bootstrap.img.polaroid = img({
      "class": 'img-polaroid'
    });
  });

}).call(this);
