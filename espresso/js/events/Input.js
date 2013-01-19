// Generated by CoffeeScript 1.3.3
(function() {

  define(function() {
    /*
    	# A static class for polling input.
    */

    var Input;
    return Input = (function() {

      function Input() {}

      Input._keyCodeStates = {};

      Input._keyCharStates = {};

      Input._mouseButtonCodeStates = {};

      Input._mouseButtonNameStates = {};

      Input.mouseX = 0;

      Input.mouseY = 0;

      /*
      		# Test to see if a key is down.
      */


      Input.isKeyDown = function(key) {
        if (key.constructor === Number) {
          return this.isKeyCodeDown(key);
        } else if (key.constructor === String) {
          return this.isKeyCharDown(key);
        }
        return false;
      };

      /*
      		# Test to see if a key is down by keyCode.
      */


      Input.isKeyCodeDown = function(keyCode) {
        return this._keyCodeStates[keyCode];
      };

      /*
      		# Test to see if a key is down by keyChar.
      */


      Input.isKeyCharDown = function(keyChar) {
        return this._keyCharStates[keyChar];
      };

      /*
      		# Test to see if a mouse button is down.
      */


      Input.isMouseButtonDown = function(button) {
        if (button.constructor === Number) {
          return this.isMouseButtonCodeDown(button);
        } else if (button.constructor === String) {
          return this.isMouseButtonNameDown(button);
        }
        return false;
      };

      /*
      		# Test to see if a mouse button is down by buttonCode.
      */


      Input.isMouseButtonCodeDown = function(buttonCode) {
        return this._mouseButtonCodeStates[buttonCode];
      };

      /*
      		# Test to see if a mouse button is down by buttonName.
      */


      Input.isMouseButtonNameDown = function(buttonName) {
        return this._mouseButtonNameStates[buttonName];
      };

      return Input;

    })();
  });

}).call(this);
