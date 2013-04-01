// Generated by CoffeeScript 1.4.0
(function() {
  var common, composite, getModel, html, models, tagname, _i, _len,
    __slice = [].slice;

  html = window.BC.namespace("html");

  common = window.BC.namespace("common");

  models = window.BC.namespace("models");

  $.extend(this, common);

  composite = ["abbr", "acronym", "address", "applet", "area", "b", "base", "basefont", "bdo", "big", "blockquote", "br", "button", "caption", "center", "cite", "code", "col", "colgroup", "dd", "del", "dfn", "dir", "div", "dl", "dt", "em", "fieldset", "font", "form", "frame", "frameset", "h1", "h2", "h3", "h4", "h5", "h6", "head", "hr", "html", "i", "iframe", "img", "input", "ins", "isindex", "kbd", "label", "legend", "li", "link", "map", "menu", "meta", "noframes", "noscript", "object", "ol", "optgroup", "option", "p", "param", "pre", "q", "s", "samp", "script", "select", "small", "span", "strike", "strong", "style", "sub", "sup", "table", "tbody", "td", "tfoot", "th", "thead", "title", "tr", "tt", "u", "ul", "var", "header", "section", "footer"];

  for (_i = 0, _len = composite.length; _i < _len; _i++) {
    tagname = composite[_i];
    html[tagname] = tag(tagname);
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
  }

  html.input = {
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
      });
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
      return $.extend(tag('input').apply(null, items).addAttr({
        type: 'checkbox',
        checked: 'checked'
      }).observable().on('click', function(e) {
        return e.data.publish($(this).is(':checked'));
      }), {
        bindValue: function(observable) {
          this.bindAttr(observable, function() {
            return {
              checked: observable._get().valueOf()
            };
          });
          return this.subscribe(function(value) {
            return observable._set(value);
          });
        }
      }).bindValue(model);
    },
    radio: function() {
      var items, model, value;
      items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      model = getModel(items);
      value = items[0].value;
      return $.extend(tag('input', {
        type: 'radio'
      }).apply(null, items).observable().on('click', function(e) {
        return model._set(value);
      })).bindAttr(model, function() {
        return {
          checked: model._get() === value
        };
      });
    },
    submit: function(name, click) {
      return tag('input')(name).addAttr({
        type: 'submit'
      }).on('click', click);
    }
  };

  html.div = tag("div");

  html.span = tag("span");

  html.textarea = function(config) {
    return tag('textarea', config)().on('keyup', function(e) {
      return e.data.publish($(this).val());
    }).observable();
  };

  html.button = function() {
    var args, click, last;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    last = _.last(args);
    click = function() {
      return false;
    };
    if (_.isFunction(last)) {
      click = function() {
        var args;
        args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        last.apply(null, args);
        return false;
      };
      args = args.slice(0, args.length - 1);
    }
    return tag('button').apply(null, args).on('click', click);
  };

  html.a = function() {
    var args, click, last;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    last = _.last(args);
    click = function() {
      return false;
    };
    if (_.isFunction(last)) {
      click = function() {
        var args;
        args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        last.apply(null, args);
        return false;
      };
      args = args.slice(0, args.length - 1);
    }
    return tag('a', {
      href: '#'
    }).apply(null, args).on('click', click);
  };

  html.body = function(composite) {
    return $('body').html(common.element(composite));
  };

  html.select = function() {
    var items;
    items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return $.extend(tag('select').apply(null, items).observable().on('change', function(e) {
      return e.data.publish($(this).val());
    }));
  };

  html.select.multiple = function() {
    var items;
    items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return bootstrap.select({
      multiple: 'multiple'
    }, items);
  };

  html.option = function(text, value) {
    return tag('option', {
      value: value
    })(text);
  };

}).call(this);
