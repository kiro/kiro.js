// Generated by CoffeeScript 1.4.0
(function() {
  var body, bootstrap, docs, models, store,
    __slice = [].slice;

  docs = window.BC.namespace("docs");

  docs.examples = window.BC.namespace("docs.examples");

  bootstrap = window.BC.namespace("bootstrap");

  models = window.BC.namespace("models");

  store = window.BC.namespace("store");

  $.extend(this, bootstrap, models, docs, store);

  body = function() {
    var items;
    items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return div({
      "class": 'padded'
    }, items);
  };

  docs.examples.chat = function() {
    return section(h1("Chat"), docs.code.chat(), example("Chat app", "You can open the chat example in different tabs.", function() {
      var currentUser, leftPanel, message, messageText, messages, rightPanel, users;
      message = function(user, content) {
        return object({
          user: user,
          content: content
        });
      };
      messages = collection([
        message({
          name: 'Chat example'
        }, "Welcome!")
      ]);
      pusher(messages, 'messages');
      currentUser = object({
        _id: Math.floor(Math.random() * 1000000),
        name: "User" + Math.floor(Math.random() * 1000),
        lastSeen: Date.now()
      });
      window.setInterval((function() {
        return currentUser.lastSeen = Date.now();
      }), 5 * 1000);
      users = collection([currentUser]);
      pusher(users, 'users', function(item) {
        return function(otherItem) {
          return item._id === otherItem._id;
        };
      });
      users.filter(function(user) {
        return (Date.now() - user.lastSeen) < 10 * 1000;
      });
      messageText = model();
      leftPanel = function() {
        return div().span3(input.text(bind(currentUser.name)).span12(), ul.unstyled().foreach(users, function(user) {
          return li(bind(user.name));
        }));
      };
      rightPanel = function() {
        return div().span9(div({
          "class": 'messages'
        }).foreach(messages, function(message) {
          return p(strong(message.user.name + ": "), message.content);
        }).onUpdate(function(el) {
          return el.scrollTop(el[0].scrollHeight);
        }), form.inline(append(input.text({
          placeholder: 'Enter message...'
        }, messageText).span9(), button.primary('Send', function() {
          return messages.add(message(currentUser, messageText("")));
        })).span12()));
      };
      return body(div.container.fluid(div.row.fluid(leftPanel(), rightPanel())));
    }));
  };

}).call(this);
