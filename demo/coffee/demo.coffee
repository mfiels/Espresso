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
			@paused = false
			@anchorX = @anchorY = 236/2

		clicked: () ->
			@paused = !@paused

		update: (e) ->
			if @paused
				return

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

			#@setZIndex(Math.random())

			@rotation += 0.1


# Require the dependencies and run demo here
require ['espresso/display/DisplayObject', 'Block', 'espresso/display/Stage', 'espresso/events/Input'], (DisplayObject, Block, Stage, Input) ->
	# Get the canvas
	canvas = document.getElementById('canvas')

	# Set the canvas size
	canvas.width = document.width || window.screen.width
	canvas.height = document.height || window.screen.height
	window.onresize = (e) ->
		canvas.width = document.width || window.screen.width
		canvas.height = document.height || window.screen.height

	# Create the stage
	stage = new Stage(canvas)

	# Make some random blocks
	window.blocks = blocks = []
	for i in [0..5]
		block = new Block(Math.random() * (canvas.width - 236), Math.random() * (canvas.height - 236))
		block.addEventListener('mouseUp', (e) ->
			e.target.clicked()
		)
		blocks.push(block)
		stage.addChild(block)

	# Make a user controlled block
	# window.player = player = new Block(0, 0)
	# stage.addChild(player)

	# stage.addEventListener('mouseUp', (e) ->
	# 	for block in blocks
	# 		if block.containsPoint(e.x, e.y)
	# 			block.clicked()
	# )

	# Update the blocks on each new frame
	stage.addEventListener('enterFrame', (e) ->
		for block in blocks
			block.update(e)
		
		# if Input.isKeyDown('W') then player.y -= 5 * e.elapsed / 17
		# if Input.isKeyDown('S') then player.y += 5 * e.elapsed / 17
		# if Input.isKeyDown('D') then player.x += 5 * e.elapsed / 17
		# if Input.isKeyDown('A') then player.x -= 5 * e.elapsed / 17

		# player.rotation = Math.atan2(Input.mouseY - player.y, Input.mouseX - player.x) * 180.0 / Math.PI
	)