// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['espresso/events/Event'], function(Event) {
    /*
    	# An event subclass for the enterFrame event.
    */

    var EnterFrameEvent;
    return EnterFrameEvent = (function(_super) {

      __extends(EnterFrameEvent, _super);

      /*
      		# Create a new EnterFrameEvent with an elapsed amount of time.
      */


      function EnterFrameEvent(elapsed) {
        this.elapsed = elapsed;
        EnterFrameEvent.__super__.constructor.call(this, 'enterFrame');
      }

      return EnterFrameEvent;

    })(Event);
  });

}).call(this);