// Generated by CoffeeScript 1.4.0
(function() {
  var common;

  common = window.BC.namespace("common");

  common.attributes = function(attr) {
    if (attr == null) {
      attr = {};
    }
    return {
      isAttributes: function(obj) {
        return obj && !_.isArray(obj) && _.isObject(obj) && !obj['html'] && !obj['init'];
      },
      merge: function(attr2) {
        var key, value, _results;
        if (!this.isAttributes(attr2)) {
          return;
        }
        _results = [];
        for (key in attr2) {
          value = attr2[key];
          if (attr[key]) {
            if (_.isBoolean(value)) {
              if (value) {
                _results.push(attr[key] = attr2[key]);
              } else {
                _results.push(void 0);
              }
            } else if (_.isString(value)) {
              _results.push(attr[key] = attr[key] + " " + attr2[key]);
            } else if (_.isNumber(value)) {
              _results.push(attr[key] = attr2[key]);
            } else {
              throw Error("Unexpected value " + value);
            }
          } else {
            _results.push(attr[key] = attr2[key]);
          }
        }
        return _results;
      },
      render: function() {
        var key, result, value;
        result = "";
        if (attr['id']) {
          result += "id='" + attr['id'] + "'";
        }
        for (key in attr) {
          value = attr[key];
          if (key === 'id') {
            continue;
          }
          if (_.isBoolean(value)) {
            if (value) {
              value = key;
            } else {
              continue;
            }
          }
          if (result) {
            result += " ";
          }
          result += "" + key + "='" + value + "'";
        }
        return result;
      },
      get: function(name) {
        return attr[name];
      }
    };
  };

}).call(this);
