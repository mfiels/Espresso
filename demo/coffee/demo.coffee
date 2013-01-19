# Cross browser request animation frame
`// http://paulirish.com/2011/requestanimationframe-for-smart-animating/
// http://my.opera.com/emoller/blog/2011/12/20/requestanimationframe-for-smart-er-animating
 
// requestAnimationFrame polyfill by Erik Möller
// fixes from Paul Irish and Tino Zijdel
 
(function() {
    var lastTime = 0;
    var vendors = ['ms', 'moz', 'webkit', 'o'];
    for(var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
        window.requestAnimationFrame = window[vendors[x]+'RequestAnimationFrame'];
        window.cancelAnimationFrame = window[vendors[x]+'CancelAnimationFrame']
                                   || window[vendors[x]+'CancelRequestAnimationFrame'];
    }
 
    if (!window.requestAnimationFrame)
        window.requestAnimationFrame = function(callback, element) {
            var currTime = new Date().getTime();
            var timeToCall = Math.max(0, 16 - (currTime - lastTime));
            var id = window.setTimeout(function() { callback(currTime + timeToCall); },
              timeToCall);
            lastTime = currTime + timeToCall;
            return id;
        };
 
    if (!window.cancelAnimationFrame)
        window.cancelAnimationFrame = function(id) {
            clearTimeout(id);
        };
}());`

# Tell RequireJS where Espresso is relative to the demo/js directory
require.config({
	paths: {
		'espresso': '../../espresso/js'
	}
})

# A simple test Block class
define 'Block', ['espresso/display/Sprite', 'espresso/display/Stage'], (Sprite, Stage) ->
	class Block extends Sprite
		constructor: (x, y) ->
			super(x, y)
			@setSource('img/block.png')
			@vx = (Math.random() * 3 + 1) * (if Math.random() > 0.5 then -1 else 1)
			@vy = (Math.random() * 3 + 1) * (if Math.random() > 0.5 then -1 else 1)
			@vr = (Math.random() + 0.25) * (if Math.random() > 0.5 then -1 else 1)
			
			@anchorX = @anchorY = 236/2

		update: (e) ->
			@x += @vx * e.elapsed / 17
			@y += @vy * e.elapsed / 17

			@rotation += @vr

			if @x > Stage.canvas.width - @width
				@x = Stage.canvas.width - @width
				@vx *= -1
			else if @x < 0
				@x = 0
				@vx *= -1
			if @y > Stage.canvas.height - @height
				@y = Stage.canvas.height - @height
				@vy *= -1
			else if @y < 0
				@y = 0
				@vy *= -1

			@rotation += 0.1


# Require the dependencies and run demo here
require ['espresso/display/DisplayObject', 'Block', 'espresso/display/Stage', 'espresso/events/Input'], (DisplayObject, Block, Stage, Input) ->
	# Get the canvas
	canvas = document.getElementById('canvas')

	# Set the canvas size
	canvas.width = document.width
	canvas.height = document.height

	# Create the stage
	stage = new Stage(canvas)

	# Make some random blocks
	blocks = []
	for i in [0...25]
		block = new Block(Math.random() * (canvas.width - 236), Math.random() * (canvas.height - 236))
		blocks.push(block)
		stage.addChild(block)

	# Make a user controlled block
	player = new Block(0, 0)
	stage.addChild(player)

	# Update the blocks on each new frame
	stage.addEventListener('enterFrame', (e) ->
		for block in blocks
			block.update(e)
		
		if Input.isKeyDown('W') then player.y -= 5 * e.elapsed / 17
		if Input.isKeyDown('S') then player.y += 5 * e.elapsed / 17
		if Input.isKeyDown('D') then player.x += 5 * e.elapsed / 17
		if Input.isKeyDown('A') then player.x -= 5 * e.elapsed / 17

		player.rotation = Math.atan2(Input.mouseY - player.y, Input.mouseX - player.x) * 180.0 / Math.PI
	)