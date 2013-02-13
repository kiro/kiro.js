// Generated by CoffeeScript 1.4.0
(function() {
  var common, controls, mixins;

  controls = window.BC.namespace("controls");

  mixins = window.BC.namespace("mixins");

  common = window.BC.namespace("common");

  $.extend(this, common);

  controls.input = {
    text: function() {
      var value;
      value = tag('input')().attr({
        type: 'text'
      }).observable();
      return value.on('keyup', function(e) {
        return value.publish($(e.target).val());
      });
    }
  };

}).call(this);
