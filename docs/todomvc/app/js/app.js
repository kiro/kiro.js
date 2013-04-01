// Generated by CoffeeScript 1.4.0
(function() {
  var ENTER_KEY, allDone, checkAll, done, filter, html, models, nextId, notDone, pluralize, renderTodo, selectedFilter, textInput, todoModel, todoText, todos;

  html = window.BC.namespace("html");

  models = window.BC.namespace("models");

  $.extend(this, html, models);

  ENTER_KEY = 13;

  nextId = (function() {
    var value;
    value = 0;
    return function() {
      return value++;
    };
  })();

  todoModel = function(title) {
    return object({
      id: nextId(),
      title: title,
      completed: false
    });
  };

  todos = collection();

  todoText = model("");

  checkAll = model(false);

  selectedFilter = model("");

  pluralize = function(count) {
    if (count === 1) {
      return "1 item";
    } else {
      return count + " items";
    }
  };

  done = function(todo) {
    return todo.completed.valueOf();
  };

  notDone = function(todo) {
    return !todo.completed.valueOf();
  };

  allDone = function() {
    var todo;
    return _.all((function() {
      var _i, _len, _ref, _results;
      _ref = todos();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        todo = _ref[_i];
        _results.push(todo.completed.valueOf());
      }
      return _results;
    })());
  };

  textInput = function(config, model, handler) {
    return input.text(config, model).on('keydown', function(e) {
      if (e.keyCode === 13) {
        return handler();
      }
    });
  };

  filter = function(name, filter) {
    return a(name, function() {
      todos.filter(filter);
      return selectedFilter(name);
    }).bindClass(selectedFilter, 'selected', function() {
      return selectedFilter() === name;
    });
  };

  renderTodo = function(todo) {
    var editing;
    editing = model(false);
    return li(div({
      "class": "view"
    }, input.checkbox({
      "class": "toggle"
    }, todo.completed).on('click', function() {
      return checkAll(allDone());
    }), label(todo.title), button({
      "class": "destroy"
    }, function() {
      return todos.remove(todo);
    })).bindVisible(negate(editing)).on('dblclick', function() {
      return editing(true);
    }), textInput({
      "class": "edit"
    }, todo.title, function() {
      return editing(false);
    }).bindVisible(editing).on('blur', function() {
      return editing(false);
    })).bindClass(todo.completed, 'completed', function() {
      return todo.completed.valueOf();
    }).bindClass(editing, 'editing');
  };

  body(section({
    id: "todoapp"
  }, header({
    id: "header"
  }, h1("todos"), textInput({
    id: "new-todo",
    placeholder: "What needs to be done?",
    autofocus: true
  }, todoText, function() {
    if (todoText().trim()) {
      return todos.add(todoModel(todoText("")));
    }
  })), section({
    id: "main"
  }, input.checkbox({
    id: "toggle-all"
  }, checkAll).on('click', function() {
    var todo, _i, _len, _ref, _results;
    _ref = todos();
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      todo = _ref[_i];
      _results.push(todo.completed = checkAll());
    }
    return _results;
  }), label({
    "for": "toggle-all"
  }, "Mark all as complete"), ul({
    id: "todo-list"
  }).foreach(todos, renderTodo)).bindVisible(todos, function() {
    return todos.count() > 0;
  }), footer({
    id: "footer"
  }, span({
    id: "todo-count"
  }, map(todos, function() {
    return pluralize(todos.count(notDone)) + " left";
  })), ul({
    id: "filters"
  }, li(filter("All", function() {
    return true;
  })).addClass('selected'), li(filter("Active", notDone)), li(filter("Completed", done))), button({
    id: "clear-completed"
  }, map(todos, function() {
    return "Clear completed (" + todos.count(done) + ")";
  }), function() {
    return todos.remove(done);
  })).bindVisible(todos, function() {
    return todos.total() > 0;
  }), footer({
    id: "info"
  }, p("Double-click to edit a todo"), p('Created by <a href="http://todomvc.com">you</a>'), p('Part of <a href="http://todomvc.com">TodoMVC</a>'))));

}).call(this);
