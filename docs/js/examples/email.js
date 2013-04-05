// Generated by CoffeeScript 1.4.0
(function() {
  var body, bootstrap, docs, models,
    __slice = [].slice;

  docs = window.BC.namespace("docs");

  docs.examples = window.BC.namespace("docs.examples");

  bootstrap = window.BC.namespace("bootstrap");

  models = window.BC.namespace("models");

  $.extend(this, bootstrap, models, docs);

  body = function() {
    var items;
    items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return div(items);
  };

  docs.examples.email = function() {
    return section(h1("Email"), docs.code.email(), example("Email client", "", function() {
      var byFolder, byId, currentUser, data, email, emailList, leftPanel, nextId, rightContent, rightPanel, selectedEmail, selectedFolder, sendEmail;
      byFolder = function(folder) {
        return function(email) {
          return email.folders.contains(folder);
        };
      };
      byId = function(id) {
        return function(item) {
          return item.id === id;
        };
      };
      currentUser = "kiril.minkov@gmail.com";
      data = object(docs.examples.emailData());
      selectedFolder = model("inbox");
      data.mail.filter(byFolder('inbox'));
      selectedEmail = model();
      nextId = (function() {
        var value;
        value = 100000;
        return function() {
          return value++;
        };
      })();
      email = function(init) {
        return object($.extend({
          "id": "mail_" + nextId(),
          "contact_id": data.contacts.at(0).id,
          "folders": ['sent'],
          "time": new Date().getTime(),
          "subject": "",
          "message": ""
        }, init));
      };
      emailList = function() {
        return table().foreach(data.mail, function(email) {
          var contact;
          contact = data.contacts.find(byId(email.contact_id));
          return tr(td().span3(email.important ? type.label().important('important') : void 0), td().span4(strong(contact.firstName + " " + contact.lastName)), td().span5(strong(email.subject))).on('click', function() {
            return selectedEmail(email);
          }).bindClass(selectedEmail, function() {
            if (selectedEmail() === email) {
              return 'info';
            }
          });
        });
      };
      rightContent = model(emailList());
      sendEmail = function(email) {
        var toSelector;
        toSelector = select(bind(email.contact_id)).foreach(data.contacts, function(contact) {
          return option(contact.email, contact.id);
        });
        return form.horizontal({
          From: span(currentUser),
          To: toSelector,
          Subject: input.text(bind(email.subject)),
          Email: textarea(bind(email.message)),
          actions: [
            button("Send", function() {
              data.mail.add(email);
              return rightContent(emailList());
            }), button("Cancel", function() {
              return rightContent(emailList());
            })
          ]
        });
      };
      leftPanel = function() {
        return div().span2(button("New", function() {
          return rightContent(sendEmail(email()));
        }), br(), pills.stacked().foreach(data.folders, function(folder) {
          return pill(folder, function() {
            selectedEmail("");
            selectedFolder(folder);
            return data.mail.filter(byFolder(folder));
          }).bindClass(selectedFolder, function() {
            if (selectedFolder() === folder) {
              return 'active';
            }
          });
        }));
      };
      rightPanel = function() {
        var folder;
        return div().span10(button.group(button(icon.trash, "Delete", function() {
          return selectedEmail(null).folders(['trash']);
        }).bindDisabled(negate(selectedEmail)).bindDisabled(selectedEmail, function() {
          if (selectedEmail()) {
            return selectedEmail().folders.contains('trash');
          }
        }), dropdown(button("Move").bindDisabled(negate(selectedEmail)), (function() {
          var _i, _len, _ref, _results;
          _ref = data.folders;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            folder = _ref[_i];
            _results.push(a(folder, function() {
              return selectedEmail(null).folders([folder]);
            }));
          }
          return _results;
        })()), button(icon.forward, "Forward", function() {
          return rightContent(sendEmail(email({
            subject: "FW: " + selectedEmail(null).subject
          })));
        }).bindDisabled(negate(selectedEmail)), button(icon.pencil, "Reply", function() {
          return rightContent(sendEmail(email({
            contact_id: selectedEmail().contact_id,
            subject: "RE: " + selectedEmail(null).subject
          })));
        }).bindDisabled(negate(selectedEmail))), div(rightContent));
      };
      return body(div.container.fluid(div.row.fluid(leftPanel(), rightPanel())));
    }));
  };

}).call(this);
