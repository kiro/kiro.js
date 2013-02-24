// Generated by CoffeeScript 1.4.0
(function() {
  var bootstrap, common, form, img, mixins, toAddOn,
    __slice = [].slice;

  bootstrap = window.BC.namespace("bootstrap");

  mixins = window.BC.namespace("bootstrap.mixins");

  common = window.BC.namespace("common");

  $.extend(this, common);

  bootstrap.input = {
    text: function(config, type) {
      if (type == null) {
        type = 'text';
      }
      return $.extend(tag('input', {
        type: type
      })(config).observable().on('keyup change', function(e) {
        return e.data.publish($(this).val());
      }), {
        placeholder: function(value) {
          return this.addAttr({
            'placeholder': value
          });
        }
      }, mixins.sizeable("input"), mixins.spannable());
    },
    password: function(config) {
      return this.text(config, 'password');
    },
    search: function(config) {
      return this.text({
        "class": "search-query"
      }, 'text');
    },
    checkbox: function() {
      return $.extend(tag('input')().addAttr({
        type: 'checkbox'
      }).observable().on('click', function(e) {
        return e.data.publish($(this).is(':checked'));
      }), {
        bindValue: function(observable) {
          this.bindAttr(observable, function() {
            return {
              checked: observable()
            };
          });
          return this.subscribe(function(value) {
            return observable(value);
          });
        },
        isCheckbox: true
      });
    },
    radio: function(name, value) {
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
              checked: observable() === value
            };
          });
          return this.subscribe(function(value) {
            return observable(value);
          });
        },
        isRadio: true
      });
    },
    submit: function(name, click) {
      return tag('input')(name).addAttr({
        type: 'submit'
      }).on('click', click);
    }
  };

  bootstrap.select = function() {
    var items;
    items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return $.extend(tag('select').apply(null, items).observable().on('change', function(e) {
      return e.data.publish($(this).val());
    }), mixins.spannable());
  };

  bootstrap.select.multiple = function() {
    var items;
    items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return bootstrap.select({
      multiple: 'multiple'
    }, items);
  };

  bootstrap.option = function(text, value) {
    return tag('option', {
      value: value
    })(text);
  };

  bootstrap.textarea = function(init) {
    return tag('textarea', init)().observable().on('keyup', function(e) {
      return e.data.publish($(this).val());
    });
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
    return form(fieldset(content, actions.length ? div({
      "class": "form-actions"
    }, actions) : void 0));
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
    }, content, actions.length ? div({
      "class": "form-actions"
    }, actions) : void 0);
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

}).call(this);
