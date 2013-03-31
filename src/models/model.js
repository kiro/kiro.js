// Generated by CoffeeScript 1.4.0
(function() {

  window.BC.define('models', function(models) {
    var common;
    common = window.BC.namespace("common");
    models.model = function(arg) {
      var model, o, value;
      value = arg;
      o = common.observable();
      model = function(newValue) {
        var oldValue;
        if (_.isUndefined(newValue)) {
          return value;
        } else {
          oldValue = value;
          value = newValue;
          o.publish(value);
          return oldValue;
        }
      };
      model.subscribe = function(listener) {
        return o.subscribe(listener);
      };
      model._set = function(newValue) {
        value = newValue;
        return o.publish(value);
      };
      model._get = function() {
        return value;
      };
      return model;
    };
    models.array = function(arr) {
      var hook, index, method, mutators, o, value, _i, _j, _len, _len1;
      if (!_.isArray(arr)) {
        throw new Error(arr + " is expected to be an array.");
      }
      o = common.observable();
      mutators = ['pop', 'push', 'reverse', 'shift', 'sort', 'splice', 'unshift'];
      hook = function(arr, method) {
        var f;
        f = arr[method];
        return arr[method] = function() {
          var result;
          result = f.apply(arr, arguments);
          o.publish(arr);
          return result;
        };
      };
      for (_i = 0, _len = mutators.length; _i < _len; _i++) {
        method = mutators[_i];
        hook(arr, method);
      }
      index = 0;
      for (_j = 0, _len1 = arr.length; _j < _len1; _j++) {
        value = arr[_j];
        if (common.isModel(value)) {
          value.subscribe(function(newValue, path) {
            return o.publish(arr, path);
          });
        } else if (_.isObject(value)) {
          value = models.object(value);
          arr[index] = value;
          value.subscribe(function(newValue, path) {
            return o.publish(arr, path);
          });
        }
        index++;
      }
      arr.subscribe = function(callback) {
        return o.subscribe(callback);
      };
      arr._get = function() {
        return arr;
      };
      arr._set = function(newArr) {
        throw Error("set is not supported for arrays");
      };
      return arr;
    };
    models.object = function(obj) {
      var key, listener, makeObservable, o, observables, prop, result, value;
      if (!_.isObject(obj)) {
        throw Error(obj + " is expected to be an object");
      }
      result = {};
      observables = {};
      makeObservable = function(obj, key, value) {
        if (_.isString(value)) {
          value = new String(value);
        } else if (_.isNumber(value)) {
          value = new Number(value);
        } else if (_.isBoolean(value)) {
          value = new Boolean(value);
        } else if (_.isUndefined(value)) {
          throw Error("value of " + key + " shouldn't be undefined");
        }
        value.subscribe = function(callback) {
          return observables[key].subscribe(callback);
        };
        value._set = function(newValue) {
          return obj[key] = newValue;
        };
        value._get = function() {
          return obj[key];
        };
        return value;
      };
      o = common.observable();
      for (key in obj) {
        value = obj[key];
        observables[key] = common.observable();
        if (_.isArray(value)) {
          value = models.array(value);
        } else if (_.isObject(value)) {
          value = models.object(value);
        } else {
          value = makeObservable(result, key, value);
        }
        listener = function(key) {
          return function(newValue, valuePath) {
            return o.publish(result, key + (valuePath ? "." + valuePath : ""));
          };
        };
        value.subscribe(listener(key));
        prop = function(key, value) {
          return {
            get: function() {
              return value;
            },
            set: function(newValue) {
              var oldValue;
              oldValue = value;
              value = makeObservable(result, key, newValue);
              observables[key].publish(newValue);
              return oldValue;
            },
            enumerable: true
          };
        };
        Object.defineProperty(result, key, prop(key, value));
      }
      result.subscribe = function(callback) {
        return o.subscribe(callback);
      };
      result._get = function() {
        return result;
      };
      result._set = function() {
        throw Error("set is not supported");
      };
      return result;
    };
    models.map = function(observable, map) {
      var value;
      if (map == null) {
        map = function(x) {
          return x;
        };
      }
      value = map(observable._get());
      return {
        _get: function() {
          return value;
        },
        _set: function(newValue) {
          throw Error("_set is not supported for mapped values");
        },
        subscribe: function(callback) {
          return observable.subscribe(function(baseValue) {
            value = map(baseValue);
            return callback(value);
          });
        }
      };
    };
    return models.negate = function(observable) {
      return models.map(observable, function(x) {
        return !x;
      });
    };
  });

}).call(this);
