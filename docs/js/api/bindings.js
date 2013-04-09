// Generated by CoffeeScript 1.4.0
(function() {
  var bootstrap, docs, models;

  docs = window.BC.namespace("docs");

  docs.api = window.BC.namespace("docs.api");

  bootstrap = window.BC.namespace("bootstrap");

  models = window.BC.namespace("models");

  $.extend(this, bootstrap, models, docs);

  docs.api.bindings = function() {
    return section(h1("Bindings"), docs.code.bindings(), p("Each html element has bindings, which allow to bind the value of a certain\nproperty to a model. The bindings update automatically when the model changes."), example("Value bindings", "Input elements can accept one model and bind their value to it.", function() {
      var cities, married, password, search, selectedCity, sex, text, textareaValue;
      text = model("initial");
      sex = model("female");
      married = object({
        value: false
      });
      selectedCity = model('San Francisco');
      cities = ['London', 'Sofia', 'San Francisco', 'Palo Alto'];
      password = model("");
      search = model("");
      textareaValue = model("");
      return body(form.horizontal({
        'Radio': div(input.radio({
          name: "sex",
          value: "male"
        }, sex).inlineLabel("Male"), input.radio({
          name: "sex",
          value: "female"
        }, sex).inlineLabel("Female"), input.radio({
          name: "sex",
          value: "other"
        }, sex).inlineLabel("Other"), h5(sex)),
        'Checkbox': div(input.checkbox(bind(married.value)).label("Married"), h5(bind(married.value))),
        'Select': div(select(selectedCity).foreach(cities, function(city) {
          return option({
            value: city
          }, city);
        }), h5(selectedCity)),
        'Password': div(input.text({
          type: 'password'
        }, password), h5(password)),
        'Search': div({
          "class": 'padded'
        }, input.search(search), h5(search)),
        'Textarea': div(textarea(textareaValue), h5(textareaValue))
      }));
    }), example("Html bindings", "Html element can accept one model and bind their html content to it.", function() {
      var content, i, items, text;
      text = model("");
      content = model();
      items = [
        button.warning("Button"), "<h2>Test</h2>", form.inline(input.text(text), button.info("Clear", function() {
          return text("");
        }))
      ];
      i = 0;
      content(items[0]);
      return body(button("Next", function() {
        return content(items[++i % items.length]);
      }), h6("html"), div(content));
    }), example(".bindCss", "<code>.bindCss(model, map)</code> binds css properties of an element to a model.\nIt expects the map function to return an object whose fields are names of\ncss properties.", function() {
      var f, _i, _results;
      f = model(function(x) {
        return x;
      });
      return body(button.group(button("x", function() {
        return f(function(x) {
          return x;
        });
      }), button("x^2", function() {
        return f(function(x) {
          return (x - 50) * (x - 50) / 30;
        });
      }), button("log", function() {
        return f(function(x) {
          return Math.log(x) * 20;
        });
      }), button("sin", function() {
        return f(function(x) {
          return Math.sin((x - 50) / 10) * 50 + 50;
        });
      })), div({
        "class": 'area'
      }).foreach((function() {
        _results = [];
        for (_i = 1; _i <= 100; _i++){ _results.push(_i); }
        return _results;
      }).apply(this), function(x) {
        return div({
          "class": 'point'
        }).bindCss(f, function(fn) {
          return {
            left: x + 'px',
            bottom: fn(x) + 'px'
          };
        });
      }));
    }), example(".bindClass", "<code>.bindClass(model, map)</code> binds a class to a model. The map function is expected to return a class name.", function() {
      var count;
      count = model(0);
      return body(span(count), button("+1", function() {
        return count(count() + 1);
      }).bindClass(count, function() {
        if (count() > 3 && count() < 8) {
          return 'btn-danger';
        }
      }));
    }), example(".bindDisabled", "<code>.bindDisabled(model, map)</code> Binds whether an element is disabled. The map function is expected to return a boolean.", function() {
      var isThree, number;
      number = model(0);
      isThree = function() {
        return number() === 3;
      };
      return body(p("You've clicked ", span(number), " times"), button("Click me", function() {
        return number(number() + 1);
      }).bindDisabled(number, isThree), p("That's too many clicks!", button('Reset Clicks', function() {
        return number(0);
      })).bindVisible(number, isThree));
    }), example(".bindVisible", "<code>.bindVisible(model, map)</code> Binds whether an element is visible. The map function is expected to return a boolean.", function() {
      var visible;
      visible = model(false);
      return body(button.success("Hide", function() {
        return visible(!visible());
      }).bindText(visible, function() {
        if (visible()) {
          return "Hide";
        } else {
          return "Show";
        }
      }), button.primary("Button").bindVisible(visible));
    }), example(".foreach", "Binds the content of an element to a collection. The content is updated efficiently when the\ncollection is changed.\n<code>.foreach(collection, render)</code>\n<ul>Parameters\n<li>collection - collection or array</li>\n<li>render(item, index) - takes an element and optional index and renders the item</li>\n</ul>", function() {
      var numbers;
      numbers = collection([5, 3, 2, 7]);
      return body(div().foreach(numbers, function(number, index) {
        return div(type.label(number + " @ " + index));
      }));
    }), example(".on", " Binds event handlers to an element. It has the same parameters as the jquery on method and it uses it internally.\n<code>.on(event, filter [optional], callback)</code>\n\n<ul>Paramaters\n<li> event - event name, for example \"click\" </li>\n<li> filter - optional element filter <code> ul(li(\"a\"), li(\"b\")).on('click', 'li', -> console.log('test'))</code> </li>\n<li> handler(eventObject) - event handler that takes the jquery event object. </li>\n</ul>", function() {
      var clicks;
      clicks = model(0);
      return body(div("Click me").on('click', function() {
        return clicks(clicks() + 1);
      }), "clicks : ", span(clicks));
    }), example(".onUpdate", " Executes a callback when the DOM element is updated if a binding changes.", function() {
      var messages, text;
      text = model("");
      messages = collection(["123", "123", "123", "123"]);
      return body(div({
        "class": 'messages short'
      }).foreach(messages, function(message) {
        return p(message);
      }).onUpdate(function(el) {
        return el.scrollTop(el[0].scrollHeight);
      }), form.inline(input.text(text), button("Add", function() {
        return messages.add(text(""));
      })));
    }), example(".onInit", " Executes a callback when a dom elemnet is created. Useful for calling jquery plugins.", function() {
      var cities, city;
      city = model("");
      cities = ["Sofia", "London", "San Francisco", "Palo Alto"];
      return body(input.text(city).onInit(function(el) {
        return el.typeahead({
          source: cities
        });
      }));
    }));
  };

}).call(this);
