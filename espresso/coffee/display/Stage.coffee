define ['espresso/display/DisplayObject', 'espresso/events/EnterFrameEvent', 'espresso/events/KeyboardEvent', 'espresso/events/MouseEvent', 'espresso/events/Input', 'espresso/events/EventDispatcher'], (DisplayObject, EnterFrameEvent, KeyboardEvent, MouseEvent, Input, EventDispatcher) ->
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
			@dispatchEvent(e)

		_keyup: (e) =>
			e = KeyboardEvent.fromDOMEvent(e)
			Input._keyCodeStates[e.keyCode] = false
			Input._keyCharStates[e.keyChar] = false
			@dispatchEvent(e)

		_mousedown: (e) =>
			e = MouseEvent.fromDOMEvent(e)
			Input._mouseButtonCodeStates[e.buttonCode] = true
			Input._mouseButtonNameStates[e.buttonName] = true
			@dispatchEvent(e)

		_mouseup: (e) =>
			e = MouseEvent.fromDOMEvent(e)
			Input._mouseButtonCodeStates[e.buttonCode] = false
			Input._mouseButtonNameStates[e.buttonName] = false
			@dispatchEvent(e)

		_mousemove: (e) =>
			e = MouseEvent.fromDOMEvent(e)
			Input.mouseX = e.x
			Input.mouseY = e.y
			@dispatchEvent(e)

		###
		# Internal render loop.
		###
		_update: () =>
			# Register intent to draw a new frame
			requestAnimationFrame(@_update)

			# Dispatch buffered events
			eventInformation = EventDispatcher.readEvents()
			for eventInfo in eventInformation
				eventInfo.dispatcher.dispatchEvent(eventInfo.event, true)

			# Dispatch an enterFrame event
			now = new Date().getTime()
			elapsed = now - @_previousTime
			event = new EnterFrameEvent(elapsed)
			@_previousTime = now
			@dispatchEvent(event, true)

			# Render the canvas
			Stage.ctx.clearRect(0, 0, Stage.canvas.width, Stage.canvas.height)
			@render(Stage.ctx)