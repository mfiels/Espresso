// Generated by CoffeeScript 1.3.3
(function() {

  define(function() {
    /*
    	# A collection of collision tests.
    */

    var Collisions;
    return Collisions = (function() {

      function Collisions() {}

      /*
      		# Given a rectangle consisting of (centerX, centerY, x, y, width, height, angle) determine if (x, y) is in it
      */


      Collisions.rectangleContainsPoint = function(rectangle, x, y) {
        var bottom, c, left, right, rotatedX, rotatedY, s, top;
        c = Math.cos(-rectangle.angle * Math.PI / 180);
        s = Math.sin(-rectangle.angle * Math.PI / 180);
        rotatedX = rectangle.centerX + c * (x - rectangle.centerX) - s * (y - rectangle.centerY);
        rotatedY = rectangle.centerY + s * (x - rectangle.centerX) + c * (y - rectangle.centerY);
        left = rectangle.x;
        right = rectangle.x + rectangle.width;
        top = rectangle.y;
        bottom = rectangle.y + rectangle.height;
        return left <= rotatedX && rotatedX <= right && top <= rotatedY && rotatedY <= bottom;
      };

      return Collisions;

    })();
  });

}).call(this);
