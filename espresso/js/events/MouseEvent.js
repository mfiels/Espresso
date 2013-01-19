// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['espresso/events/Event'], function(Event) {
    /*
    	# A class for mouseUp, mouseDown, and mouseMove events.
    */

    var MouseEvent;
    return MouseEvent = (function(_super) {

      __extends(MouseEvent, _super);

      /*
      		# Create a MouseEvent from a DOM event.
      */


      MouseEvent.fromDOMEvent = function(e) {
        return new MouseEvent(e.layerX, e.layerY, e.button, e.button === 0 ? 'left' : e.button === 1 ? 'middle' : e.button === 2 ? 'right' : '', e.type === 'mousedown' ? 'mouseDown' : e.type === 'mouseup' ? 'mouseUp' : e.type === 'mousemove' ? 'mouseMove' : '');
      };

      /*
      		# Construct a MouseEvent for an (x, y) position and a specific button.
      */


      function MouseEvent(x, y, buttonCode, buttonName, type) {
        this.x = x;
        this.y = y;
        this.buttonCode = buttonCode;
        this.buttonName = buttonName;
        MouseEvent.__super__.constructor.call(this, type);
      }

      return MouseEvent;

    })(Event);
  });

}).call(this);