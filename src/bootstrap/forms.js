// Generated by CoffeeScript 1.4.0
(function() {
  var __slice = [].slice;

  window.BC.define('bootstrap', function(bootstrap) {
    var common, form, getModel, img, input, mixins, models, toAddOn;
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
    input = function() {
      var changeEvents, getValue, init, items;
      init = arguments[0], changeEvents = arguments[1], getValue = arguments[2], items = 4 <= arguments.length ? __slice.call(arguments, 3) : [];
      return tag('input', init).apply(null, items).on(changeEvents, function(e) {
        return e.data.setValue(getValue(this));
      });
    };
    bootstrap.input = {
      text: function() {
        var items, model;
        items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        model = getModel(items);
        return $.extend(input.apply(null, [{
          type: 'text'
        }, 'keyup change', (function(el) {
          return $(el).val();
        })].concat(__slice.call(items))), {
          placeholder: function(value) {
            return this.addAttr({
              'placeholder': value
            });
          }
        }, mixins.sizeable("input"), mixins.spannable()).bindValue(model);
      },
      password: function() {
        var items, model;
        items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        model = getModel(items);
        return this.text.apply(this, items).addAttr({
          type: 'password'
        }).bindValue(model);
      },
      search: function() {
        var items, model;
        items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        model = getModel(items);
        return this.text.apply(this, items).addClass("search-query").bindValue(model);
      },
      checkbox: function() {
        var items, model;
        items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        model = getModel(items);
        return $.extend(input.apply(null, [{
          type: 'checkbox'
        }, 'click', (function(el) {
          return $(el).is(':checked');
        })].concat(__slice.call(items))), {
          isCheckbox: true,
          label: function(value) {
            return label({
              "class": 'checkbox'
            }, this, value);
          },
          inlineLabel: function(value) {
            return label.inline({
              "class": 'checkbox'
            }, this, value);
          }
        }).bindValue(model).bindAttr(model, function() {
          return {
            checked: model.get()
          };
        });
      },
      radio: function() {
        var items, model, value;
        items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        model = getModel(items);
        value = items[0].value;
        return $.extend(input.apply(null, [{
          type: 'radio'
        }, 'click', (function() {
          return value;
        })].concat(__slice.call(items))), {
          label: function(value) {
            return label({
              "class": 'radio'
            }, this, value);
          },
          inlineLabel: function(value) {
            return label.inline({
              "class": 'radio'
            }, this, value);
          },
          isRadio: true
        }).bindValue(model).bindAttr(model, function() {
          return {
            checked: model.get() === value
          };
        });
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
      return $.extend(tag('select').apply(null, items).on('change', function(e) {
        return e.data.setValue($(this).val());
      }).bindValue(model), mixins.spannable());
    };
    bootstrap.select.multiple = function(model) {
      return bootstrap.select(model, {
        multiple: 'multiple'
      });
    };
    bootstrap.option = tag('option');
    bootstrap.textarea = function() {
      var items, model;
      items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      model = getModel(items);
      return tag('textarea').apply(null, items).on('keyup change', function(e) {
        return e.data.setValue($(this).val());
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
        } else if (key === 'actions') {
          actions = div({
            "class": "form-actions"
          }, value);
        } else if (value.isCheckbox) {
          content.push(value.label(key));
        } else if (key === "") {
          content.push(value);
        } else {
          content.push(label(key));
          content.push(value);
        }
      }
      return form(fieldset(content, actions));
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
    bootstrap.form.horizontal = function(items) {
      var actions, content, control, group, key, value;
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
        } else if (key === 'actions') {
          actions = div({
            "class": "form-actions"
          }, value);
        } else if (value.isCheckbox) {
          content.push(group(control(value.label(key))));
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
    bootstrap.img.polaroid = img({
      "class": 'img-polaroid'
    });
    bootstrap.header = tag('header');
    bootstrap.section = tag('section');
    bootstrap.footer = tag('footer');
    return bootstrap.br = tag('br');
  });

}).call(this);
