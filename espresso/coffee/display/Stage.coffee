define ['espresso/display/DisplayObject', 'espresso/events/Event'], (DisplayObject, Event) ->
	###
	# The top most display object of the application.
	###
	class Stage extends DisplayObject

		# Public static properties
		@stage = null	# The single instance of the application
		@canvas = null	# The canvas associated with the stage
		@ctx = null		# The rendering context

		###
		# Construct a stage given an instance of the canvas.
		###
		constructor: (canvas) ->
			super(0, 0)
			Stage.canvas = canvas
			Stage.ctx = canvas.getContext('2d')
			Stage.stage = @
			@_update()

		###
		# Internal render loop.
		###
		_update: () =>
			# Register intent to draw a new frame
			requestAnimationFrame(@_update)

			# Dispatch an enterFrame event
			event = new Event('enterFrame');
			@dispatchEvent(event)

			# Render the canvas
			Stage.ctx.clearRect(0, 0, Stage.canvas.width, Stage.canvas.height)
			@render(Stage.ctx)