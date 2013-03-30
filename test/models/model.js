// Generated by CoffeeScript 1.4.0
(function() {
  var common, models, util;

  common = window.BC.namespace("common");

  models = window.BC.namespace("models");

  util = window.BC.namespace("test.util");

  $.extend(this, common, models, util);

  describe("Model tests", function() {
    it("Tests model", function() {
      var expectedValue, flag, subscriptionCalls;
      flag = model(true);
      expect(flag()).toBe(true);
      subscriptionCalls = 0;
      expectedValue = false;
      flag.subscribe(function(value) {
        subscriptionCalls++;
        return expect(value).toBe(expectedValue);
      });
      flag(false);
      expect(subscriptionCalls).toBe(1);
      expectedValue = 1;
      flag(1);
      expect(subscriptionCalls).toBe(2);
      expectedValue = "test";
      flag("test");
      expect(subscriptionCalls).toBe(3);
      expectedValue = "new";
      expect(flag("new")).toEqual("test");
      expectedValue = "";
      expect(flag("")).toEqual("new");
      return expect(flag()).toEqual("");
    });
    it("Tests object observable", function() {
      var firstCalls, lastCalls, obj, objCalls;
      obj = models.object({
        firstName: "Kiril",
        lastName: "Minkov"
      });
      objCalls = 0;
      obj.subscribe(function() {
        return objCalls++;
      });
      firstCalls = 0;
      obj.firstName.subscribe(function() {
        return firstCalls++;
      });
      lastCalls = 0;
      obj.lastName.subscribe(function() {
        return lastCalls++;
      });
      obj.firstName = "Test";
      expect(firstCalls).toBe(1);
      expect(objCalls).toBe(1);
      expect(lastCalls).toBe(0);
      obj.lastName = "Mente";
      expect(firstCalls).toBe(1);
      expect(lastCalls).toBe(1);
      expect(objCalls).toBe(2);
      obj.lastName = "Mente";
      expect(firstCalls).toBe(1);
      expect(lastCalls).toBe(2);
      return expect(objCalls).toBe(3);
    });
    it("Tests array observable", function() {
      var arr, calls;
      arr = models.array([1, 2, 3, 4]);
      calls = 0;
      arr.subscribe(function() {
        return calls++;
      });
      arr.push(1);
      expect(calls).toBe(1);
      arr.pop();
      expect(calls).toBe(2);
      arr.sort();
      return expect(calls).toBe(3);
    });
    return it("Tests nested object observable", function() {
      var languageCalls, languageNameCalls, obj, objCalls;
      obj = models.object({
        firstName: "Kiril",
        lastName: "Minkov",
        cities: ["Plovdiv", "Sofia", "San Francisco", "London"],
        language: {
          name: "Bulgarian",
          confidence: "Profficient"
        }
      });
      objCalls = 0;
      obj.subscribe(function() {
        return objCalls++;
      });
      expect(objCalls).toBe(0);
      obj.firstName = "Mente";
      expect(objCalls).toBe(1);
      languageCalls = 0;
      obj.language.subscribe(function() {
        return languageCalls++;
      });
      languageNameCalls = 0;
      obj.language.name.subscribe(function() {
        return languageNameCalls++;
      });
      obj.language.name = "Test";
      expect(objCalls).toBe(2);
      expect(languageCalls).toBe(1);
      return expect(languageNameCalls).toBe(1);
    });
  });

}).call(this);
