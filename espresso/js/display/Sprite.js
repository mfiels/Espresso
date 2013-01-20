// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['espresso/display/DisplayObject', 'espresso/utils/Collisions', 'espresso/events/Event'], function(DisplayObject, Collisions, Event) {
    /*
    	# A class for rendering resources.
    */

    var Sprite;
    return Sprite = (function(_super) {

      __extends(Sprite, _super);

      Sprite.useCache = true;

      Sprite._cache = {};

      Sprite._imageFileExtensions = ['.jpeg', '.jpg', '.gif', '.png', '.apng', '.svg', '.bmp', '.ico'];

      /*
      		# Construct a Sprite at (x, y) with a resource of source.
      */


      function Sprite(x, y, source, useCache) {
        if (x == null) {
          x = 0;
        }
        if (y == null) {
          y = 0;
        }
        if (source == null) {
          source = null;
        }
        if (useCache == null) {
          useCache = Sprite.useCache;
        }
        Sprite.__super__.constructor.call(this, x, y);
        this.anchorX = 0;
        this.anchorY = 0;
        this.setSource(source, useCache);
      }

      /*
      		# Set the resource to be rendered.
      */


      Sprite.prototype.setSource = function(source, useCache) {
        var extension, extensionMatch, makeImage, resource,
          _this = this;
        if (useCache == null) {
          useCache = Sprite.useCache;
        }
        this.source = null;
        makeImage = function(src, container) {
          var image;
          image = new Image();
          image.listeners = [];
          image.isLoaded = false;
          image.onload = function() {
            var listener, listeners, _i, _len, _ref;
            container.width = this.width;
            container.height = this.height;
            _ref = this.listeners;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              listener = _ref[_i];
              listener(this);
            }
            listeners = [];
            return this.isLoaded = true;
          };
          image.src = src;
          return image;
        };
        if (source) {
          if (source.constructor === Image) {
            this.source = source;
          } else if (source.constructor === String) {
            resource = source;
            extensionMatch = resource.match(/\.[a-zA-Z0-9]*$/);
            if (extensionMatch) {
              extension = extensionMatch[0].toLowerCase();
              if (Sprite._imageFileExtensions.indexOf(extension) !== -1) {
                if (useCache) {
                  if (Sprite._cache[resource]) {
                    this.source = Sprite._cache[resource];
                    if (!this.source.isLoaded) {
                      this.source.listeners.push(function() {
                        _this.width = _this.source.width;
                        return _this.height = _this.source.height;
                      });
                    }
                    this.width = this.source.width;
                    this.height = this.source.height;
                  } else {
                    this.source = makeImage(resource, this);
                    Sprite._cache[resource] = this.source;
                  }
                } else {
                  this.source = makeImage(resource, this);
                }
              } else {
                throw "The extension " + extension + " is unknown";
              }
            }
          }
          if (!this.source) {
            throw "Couldn't set " + source + " as a source";
          }
        }
      };

      /*
      		# Draw the resource.
      */


      Sprite.prototype._draw = function(ctx) {
        if (this.source) {
          return ctx.drawImage(this.source, -this.anchorX, -this.anchorY);
        }
      };

      /*
      		# Test to see if (x, y) is in the Sprite.
      */


      Sprite.prototype.containsPoint = function(x, y) {
        var rectangle;
        rectangle = {
          centerX: this.x,
          centerY: this.y,
          x: this.x - this.anchorX,
          y: this.y - this.anchorY,
          width: this.width,
          height: this.height,
          angle: this.rotation
        };
        return Collisions.rectangleContainsPoint(rectangle, x, y);
      };

      return Sprite;

    })(DisplayObject);
  });

}).call(this);
