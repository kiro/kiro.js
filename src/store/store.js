// Generated by CoffeeScript 1.4.0
(function() {
  var __slice = [].slice;

  window.BC.define('store', function(store) {
    var models;
    models = window.BC.namespace("models");
    store.mongoLab = function(collection, mongoDatabase, mongoCollection) {
      var apiKey, baseUrl, getIds, handler, initialItems, request, url;
      apiKey = "xR9PQZeYGV7K40N8rXp_RpdJMjQXAgiD";
      baseUrl = "https://api.mongolab.com/api/1/databases/" + mongoDatabase + "/collections/" + mongoCollection + "?apiKey=" + apiKey;
      url = function(query) {
        if (query) {
          query = '&q=' + query;
        }
        return baseUrl + query;
      };
      request = function(method, items, query) {
        if (query == null) {
          query = "";
        }
        return $.ajax({
          url: url(query),
          data: JSON.stringify(items),
          type: method,
          contentType: "application/json"
        });
      };
      initialItems = collection();
      collection([]);
      $.get(baseUrl, function(result) {
        var item;
        if (result.length === 0) {
          request('POST', initialItems);
          collection(initialItems);
        } else {
          collection((function() {
            var _i, _len, _results;
            _results = [];
            for (_i = 0, _len = result.length; _i < _len; _i++) {
              item = result[_i];
              _results.push(models.object(item));
            }
            return _results;
          })());
        }
        return collection.subscribe(handler);
      });
      getIds = function(items) {
        var ids, item;
        ids = ((function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = items.length; _i < _len; _i++) {
            item = items[_i];
            _results.push(item._id);
          }
          return _results;
        })()).join(",");
        return "{_id:{$in:[" + ids + "]}}";
      };
      return handler = collection.actionHandler({
        change: function(items) {
          return request('PUT', items);
        },
        filter: function() {},
        add: function(item) {
          return request('POST', item);
        },
        remove: function(items) {
          return request('PUT', [], getIds(items));
        },
        update: function(item) {
          return request('PUT', item, getIds([item]));
        }
      });
    };
    return store.rateLimit = function(f) {
      latestArgs;
      return function() {
        var args, latestArgs;
        args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        return latestArgs = args;
      };
    };
  });

}).call(this);
