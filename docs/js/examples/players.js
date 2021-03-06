// Generated by CoffeeScript 1.6.3
(function() {
  var REQUEST_RATE, bootstrap, docs, models, store;

  docs = window.BC.namespace("docs");

  docs.examples = window.BC.namespace("docs.examples");

  bootstrap = window.BC.namespace("bootstrap");

  models = window.BC.namespace("models");

  store = window.BC.namespace("store");

  $.extend(this, bootstrap, models, docs);

  REQUEST_RATE = 1;

  docs.examples.players = function() {
    return section(h1("Players"), docs.code.players(), example("Players app", "The players state is persisted in mongolab and is updated in all tabs through push notifications.", function() {
      var id, player, players, selected;
      id = 1;
      player = function(name, score) {
        return object({
          _id: id++,
          name: name,
          score: score
        });
      };
      players = collection([player("C++", 5), player("Java", 10), player("Javascript", 15), player("Go", 25), player("Python", 20)]);
      store.mongoLab(players, 'examples', 'players', REQUEST_RATE);
      store.pusher(players, 'players', function(item) {
        return item._id;
      });
      players.sort(function(player1, player2) {
        if (player1.score < player2.score) {
          return 1;
        } else {
          if (player1.score > player2.score) {
            return -1;
          } else {
            return 0;
          }
        }
      });
      selected = model();
      return body(div({
        id: 'outer'
      }, div({
        "class": 'leader board'
      }).foreach(players, function(player) {
        return div({
          "class": 'player'
        }, span({
          "class": 'name'
        }, bind(player.name)), span({
          "class": 'score'
        }, bind(player.score))).bindClass(selected, function() {
          if (selected() === player) {
            return 'selected';
          }
        }).on('click', function() {
          return selected(player);
        });
      })), div({
        "class": 'details'
      }, div({
        "class": 'name'
      }, map(selected, function() {
        if (selected()) {
          return selected().name;
        }
      })), button({
        "class": 'inc'
      }, "Give 5 points", function() {
        return selected().score += 5;
      }), '&nbsp;', button({
        "class": 'inc'
      }, "Take 5 points", function() {
        return selected().score -= 5;
      })).bindVisible(selected), div({
        "class": 'none'
      }, 'Click a player to select').bindVisible(negate(selected)));
    }));
  };

}).call(this);
