// Generated by CoffeeScript 1.4.0
(function() {
  var common, controls, mixins,
    __slice = [].slice;

  controls = window.BC.namespace("controls");

  mixins = window.BC.namespace("mixins");

  common = window.BC.namespace("common");

  $.extend(this, common);

  controls.input = {
    text: function() {
      return $.extend(tag('input')().attr({
        type: 'text'
      }).observable().on('keyup', function(e) {
        return e.data.publish($(this).val());
      }), {
        placeholder: function(value) {
          return this.attr('placeholder', value);
        }
      });
    },
    checkbox: function() {
      return $.extend(tag('input')().attr({
        type: 'checkbox'
      }).observable().on('click', function(e) {
        return e.data.publish($(this).is(':checked'));
      }), {
        bindValue: function(observable) {
          this.bindProp(observable, function() {
            return {
              checked: observable()
            };
          });
          return this.subscribe(function(value) {
            return observable(value);
          });
        }
      });
    },
    radio: function(name, value) {
      return $.extend(tag('input')().attr({
        type: 'radio',
        name: name,
        value: value
      }).observable().on('click', function(e) {
        return e.data.publish(value);
      }), {
        bindValue: function(observable) {
          this.bindProp(observable, function() {
            return {
              checked: observable() === value
            };
          });
          return this.subscribe(function(value) {
            return observable(value);
          });
        }
      });
    }
  };

  controls.select = function() {
    var items;
    items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return tag('select').apply(null, items).observable().on('change', function(e) {
      return e.data.publish($(this).val());
    });
  };

  controls.select.multiple = function() {
    var items;
    items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return controls.select.apply(controls, items).attr({
      multiple: 'multiple'
    });
  };

  controls.option = function(text, value) {
    return tag('option')(text).attr({
      value: value
    });
  };

  /*
  button
  checkbox
  color
  date
  datetime
  datetime-local
  email
  file
  hidden
  image
  month
  number
  password
  radio
  range
  reset
  search
  submit
  tel
  text
  time
  url
  week
  */


}).call(this);
