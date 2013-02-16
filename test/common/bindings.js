// Generated by CoffeeScript 1.4.0
(function() {
  var bootstrap, common, models, util;

  common = window.BC.namespace("common");

  models = window.BC.namespace("models");

  util = window.BC.namespace("test.util");

  bootstrap = window.BC.namespace("bootstrap");

  $.extend(this, common, models, util, bootstrap);

  describe("Bindings test", function() {
    it("Empty test", function() {});
    it("Tests value binding", function() {
      var text, value;
      value = model("test");
      text = input.text().bindValue(value);
      show(text, span().bindText(value));
      expect(value()).toBe("test");
      text.el().val("check check");
      text.el().change();
      return expect(value()).toBe("check check");
    });
    it("Tests css binding", function() {
      var orange, size;
      size = model(10);
      orange = div({
        "class": 'orange'
      }, "Click me!").on('click', function() {
        return size(size() + 10);
      }).bindCss(size, function() {
        return {
          width: size(),
          height: size()
        };
      });
      show(orange);
      expect(orange.el().css('height')).toBe("10px");
      orange.el().click();
      expect(orange.el().css('height')).toBe("20px");
      orange.el().click();
      return expect(orange.el().css('height')).toBe("30px");
    });
    it("Tests class binding", function() {
      var count, div1, div2, isOrange;
      isOrange = model(false);
      div1 = div({
        "class": 'box'
      }).bindClass(isOrange, 'orange');
      count = model(5);
      div2 = div({
        "class": 'box'
      }).bindClass(count, 'orange', function(value) {
        return value === 5;
      });
      show(div1, div2);
      expect(div1.el().hasClass('orange')).toBe(false);
      isOrange(true);
      expect(div1.el().hasClass('orange')).toBe(true);
      expect(div2.el().hasClass('orange')).toBe(true);
      count(4);
      return expect(div2.el().hasClass('orange')).toBe(false);
    });
    it("Tests text binding", function() {
      var text, value;
      value = model("Check");
      text = span().bindText(value);
      show(text);
      expect(text.el().text()).toBe("Check");
      value("Mente");
      return expect(text.el().text()).toBe("Mente");
    });
    it("Tests html binding", function() {
      var val, value;
      value = model("<h1>Check</h1>");
      val = span().bindHtml(value);
      show(val);
      expect(val.el().html()).toBe("<h1>Check</h1>");
      value("<h2>Mente</h2>");
      return expect(val.el().html()).toBe("<h2>Mente</h2>");
    });
    it("Tests disabled binding", function() {
      var btn1, btn2, count, isDisabled;
      isDisabled = model(false);
      btn1 = button("Button1").bindDisabled(isDisabled);
      count = model(5);
      btn2 = button("Button2").bindDisabled(count, function() {
        return count() === 5;
      });
      show(btn1, btn2);
      expect(btn1.el().attr('disabled')).toBeFalsy();
      isDisabled(true);
      expect(btn1.el().attr('disabled')).toBe('disabled');
      expect(btn2.el().attr('disabled')).toBe('disabled');
      count(10);
      return expect(btn2.el().attr('disabled')).toBeFalsy();
    });
    it("Tests visible binding", function() {
      var box, isVisible;
      isVisible = model(true);
      box = div({
        "class": 'box'
      }).bindVisible(isVisible);
      show(box);
      expect(box.el().css('display')).toBe("block");
      isVisible(false);
      expect(box.el().css('display')).toBe("none");
      isVisible(true);
      return expect(box.el().css('display')).toBe("block");
    });
    return it("Tests foreach binding", function() {
      var list, values;
      values = collection(1, 2, 3);
      list = div("Test").foreach(values, function(value) {
        return value;
      });
      show(list);
      expect(list.el().text()).toBe("Test123");
      values([4, 5, 6]);
      return expect(list.el().text()).toBe("Test456");
    });
  });

}).call(this);
