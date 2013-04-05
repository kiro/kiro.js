// Generated by CoffeeScript 1.4.0
(function() {

  window.BC.define('store', function(store) {
    var models, rates,
      _this = this;
    models = window.BC.namespace("models");
    rates = window.BC.namespace("rates");
    return store.mongoLab = function(collection, mongoDatabase, mongoCollection, request_rate) {
      var add, apiKey, baseUrl, getIds, handler, id, initialItems, remove, request, updateCollection, updateItems, url;
      if (request_rate == null) {
        request_rate = rates.NO_LIMIT;
      }
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
      id = function(item) {
        return item._id;
      };
      getIds = function(items) {
        var ids, item;
        ids = ((function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = items.length; _i < _len; _i++) {
            item = items[_i];
            _results.push(JSON.stringify(item._id));
          }
          return _results;
        })()).join(",");
        return "{_id:{$in:[" + ids + "]}}";
      };
      updateCollection = function(items) {
        return request('PUT', items);
      };
      add = function(items) {
        return request('POST', items);
      };
      remove = function(items) {
        return request('PUT', [], getIds(items));
      };
      updateItems = function(items) {
        return request('PUT', items, getIds(items));
      };
      $.extend(_this, rates);
      return handler = collection.actionHandler({
        replaceAll: rate(updateCollection, request_rate, idempotent()),
        updateView: (function() {}),
        add: rate(add, request_rate, aggregate()),
        remove: rate(remove, request_rate, aggregate()),
        update: rate(updateItems, request_rate, idempotent(id))
      });
    };
  });

}).call(this);
