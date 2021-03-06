// Generated by CoffeeScript 1.6.3
(function() {
  var bootstrap, docs, models;

  docs = window.BC.namespace("docs");

  docs.bootstrap = window.BC.namespace("docs.bootstrap");

  bootstrap = window.BC.namespace("bootstrap");

  models = window.BC.namespace("models");

  $.extend(this, bootstrap, models, docs);

  docs.bootstrap.buttons = function() {
    return section(h1("Buttons"), docs.code.buttons(), example("Button styles", "Button styles for different actions", function() {
      var text;
      text = model("");
      return body(button("Default", function() {
        return text("I'm default");
      }), button.primary("Primary", function() {
        return text("Take this primary");
      }), button.info("Info", function() {
        return text("Info, info");
      }), button.warning("Warning", function() {
        return text("Warning");
      }), button.success("Success", function() {
        return text("Success");
      }), button.danger("Danger", function() {
        return text("Danger");
      }), button.inverse("Inverse", function() {
        return text("Inverse");
      }), button.link("Link", function() {
        return text("Link");
      }), span(text));
    }), example("Dropdown buttons", "Creating dropdown and segmented dropdown buttons", function() {
      return body(dropdown(button.info("Hello"), a("Hi"), a("How"), dropdown.divider(), a("Is it going?")), dropdown.segmented(button.info("Hello", function() {
        return console.log("Hello");
      }), a("Hi", function() {
        return console.log("Hi");
      }), a("How"), dropdown.divider(), a("Is it going?")));
    }), example("Button sizes", "Builder methods for different button sizes", function() {
      return body(button.primary("Large").large(), button.info("Default"), button.warning("Small").small(), button.danger("Mini").mini());
    }), example("Block level buttons", "Creating block level buttons", function() {
      return body(button.primary("Block").block().large(), button("Block").block());
    }), example("Disabled button", "Binding the disabled property of a button", function() {
      var disabled;
      disabled = model(true);
      return body(button.danger("Disable", function() {
        return disabled(true);
      }), button.success("Enable", function() {
        return disabled(false);
      }), button("Disabled").bindDisabled(disabled).bindText(disabled, function() {
        if (disabled()) {
          return "Disabled";
        } else {
          return "Enabled";
        }
      }));
    }), example("Single button group", "Group button together", function() {
      return body(button.group(button("One"), button.success("Two"), button.danger("Three")));
    }), example("Button toolbar", "Put groups of button together", function() {
      return body(button.toolbar(button.group(button("1"), button("2"), button("3")), button.group(button("4"), button("5")), button.group(button("6"))));
    }), example("Button group vertical", "Stack buttons vertically", function() {
      return body(button.group.vertical(button(icon.arrow_down()), button(icon.arrow_left()), button(icon.arrow_right()), button(icon.arrow_up())));
    }));
  };

}).call(this);
