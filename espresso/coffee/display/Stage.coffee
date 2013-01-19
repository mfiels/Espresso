define ['espresso/display/DisplayObject', 'espresso/events/EnterFrameEvent', 'espresso/events/KeyboardEvent', 'espresso/events/MouseEvent', 'espresso/events/Input'], (DisplayObject, EnterFrameEvent, KeyboardEvent, MouseEvent, Input) ->
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
			@_previousTime = new Date().getTime()
			@_bufferedEvents = []
			
			Stage.canvas = canvas
			Stage.ctx = canvas.getContext('2d')
			Stage.stage = @

			canvas.onkeydown = @_keydown
			canvas.onkeyup = @_keyup

			canvas.onmousedown = @_mousedown
			canvas.onmouseup = @_mouseup
			canvas.onmousemove = @_mousemove

			canvas.tabIndex = '1'

			@_update()

		_keydown: (e) =>
			e = KeyboardEvent.fromDOMEvent(e)
			Input._keyCodeStates[e.keyCode] = true
			Input._keyCharStates[e.keyChar] = true
			@_bufferedEvents.push(e)

		_keyup: (e) =>
			e = KeyboardEvent.fromDOMEvent(e)
			Input._keyCodeStates[e.keyCode] = false
			Input._keyCharStates[e.keyChar] = false
			@_bufferedEvents.push(e)

		_mousedown: (e) =>
			e = MouseEvent.fromDOMEvent(e)
			Input._mouseButtonCodeStates[e.buttonCode] = true
			Input._mouseButtonNameStates[e.buttonName] = true
			@_bufferedEvents.push(e)

		_mouseup: (e) =>
			e = MouseEvent.fromDOMEvent(e)
			Input._mouseButtonCodeStates[e.buttonCode] = false
			Input._mouseButtonNameStates[e.buttonName] = false
			@_bufferedEvents.push(e)

		_mousemove: (e) =>
			e = MouseEvent.fromDOMEvent(e)
			Input.mouseX = e.x
			Input.mouseY = e.y
			@_bufferedEvents.push(e)

		###
		# Internal render loop.
		###
		_update: () =>
			# Register intent to draw a new frame
			requestAnimationFrame(@_update)

			# Dispatch buffered events
			for event in @_bufferedEvents
				@dispatchEvent(event)
			@_bufferedEvents = []

			# Dispatch an enterFrame event
			now = new Date().getTime()
			elapsed = now - @_previousTime
			event = new EnterFrameEvent(elapsed)
			@_previousTime = now
			@dispatchEvent(event)

			# Render the canvas
			Stage.ctx.clearRect(0, 0, Stage.canvas.width, Stage.canvas.height)
			@render(Stage.ctx)