// Generated by CoffeeScript 1.3.3
(function() {

  define(function() {
    /*
    	# A simple event object.
    */

    var Event;
    return Event = (function() {
      /*
      		# Create an event of a specific type and optionally attach data to it.
      */

      function Event(type, data) {
        this.type = type;
        this.data = data != null ? data : null;
      }

      return Event;

    })();
  });

}).call(this);
