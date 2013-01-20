define ['espresso/display/DisplayObject', 'espresso/events/EnterFrameEvent', 'espresso/events/KeyboardEvent', 'espresso/events/MouseEvent', 'espresso/events/Input', 'espresso/events/EventDispatcher', 'espresso/utils/Augmentations'], (DisplayObject, EnterFrameEvent, KeyboardEvent, MouseEvent, Input, EventDispatcher, Augmentations) ->
	###
	# The top most display object of the application.
	###
	class Stage extends DisplayObject

		# Public static properties
		@stage = null	# The single instance of the application
		@canvas = null	# The canvas associated with the stage
		@ctx = null		# The rendering context
		@touch = false	# Whether this is a touch enabled device

		###
		# Construct a stage given an instance of the canvas.
		###
		constructor: (canvas) ->
			super(0, 0)
			@_previousTime = new Date().getTime()
			
			Stage.canvas = canvas
			Stage.ctx = canvas.getContext('2d')
			Stage.stage = @

			canvas.addEventListener('keydown', @_domKeydown, false)
			canvas.addEventListener('keyup', @_domKeyup, false)

			if `'ontouchstart' in document.documentElement`
				canvas.addEventListener('touchstart', @_domMousedown, false)
				canvas.addEventListener('touchend', @_domMouseup, false)
				canvas.addEventListener('touchmove', @_domMousemove, false)
				Stage.touch = true
			else
				canvas.addEventListener('mousedown', @_domMousedown, false)
				canvas.addEventListener('mouseup', @_domMousedown, false)
				canvas.addEventListener('mousemove', @_domMousemove, false)

			canvas.tabIndex = '1'

			@addEventListener('mouseDown', @_mouseDown)
			@addEventListener('mouseUp', @_mouseUp)

			@_update()

		_domKeydown: (e) =>
			e = KeyboardEvent.fromDOMEvent(e)
			Input._keyCodeStates[e.keyCode] = true
			Input._keyCharStates[e.keyChar] = true
			@dispatchEvent(e)

		_domKeyup: (e) =>
			e = KeyboardEvent.fromDOMEvent(e)
			Input._keyCodeStates[e.keyCode] = false
			Input._keyCharStates[e.keyChar] = false
			@dispatchEvent(e)

		_domMousedown: (e) =>
			e.preventDefault()
			e = MouseEvent.fromDOMEvent(e, Input)
			Input._mouseButtonCodeStates[e.buttonCode] = true
			Input._mouseButtonNameStates[e.buttonName] = true
			Input.mouseX = e.x
			Input.mouseY = e.y
			@dispatchEvent(e)

		_domMouseup: (e) =>
			e.preventDefault()
			e = MouseEvent.fromDOMEvent(e, Input)
			Input._mouseButtonCodeStates[e.buttonCode] = false
			Input._mouseButtonNameStates[e.buttonName] = false
			@dispatchEvent(e)

		_domMousemove: (e) =>
			e.preventDefault()
			e = MouseEvent.fromDOMEvent(e, Input)
			Input.mouseX = e.x
			Input.mouseY = e.y
			console.log('move')
			console.log(e)
			@dispatchEvent(e)

		_mouseDown: (e) =>
			console.log('down')
			console.log(e)
			mouseTargets = EventDispatcher._mouseTargets
			for mouseTarget in mouseTargets
				if mouseTarget._mouseOver
					e.target = mouseTarget
					mouseTarget.dispatchEvent(e, true)

		_mouseUp: (e) =>
			console.log('up')
			console.log(e)
			mouseTargets = EventDispatcher._mouseTargets
			for mouseTarget in mouseTargets
				if mouseTarget._mouseOver
					e.target = mouseTarget
					mouseTarget.dispatchEvent(e, true)

		###
		# Internal render loop.
		###
		_update: () =>
			# Register intent to draw a new frame
			requestAnimationFrame(@_update)

			# Dispatch any mouse events
			mouseTargets = EventDispatcher._mouseTargets
			for mouseTarget in mouseTargets
				if mouseTarget.containsPoint(Input.mouseX, Input.mouseY)
					if !mouseTarget._mouseOver
						mouseTarget._mouseOver = true
						mouseTarget.dispatchEvent(new MouseEvent(Input.mouseX, Input.mouseY, mouseTarget, 0, '', 'mouseOver'))
				else
					if mouseTarget._mouseOver
						mouseTarget._mouseOver = false
						mouseTarget.dispatchEvent(new MouseEvent(Input.mouseX, Input.mouseY, mouseTarget, 0, '', 'mouseOff'))

			# Dispatch an enterFrame event
			now = new Date().getTime()
			elapsed = now - @_previousTime
			event = new EnterFrameEvent(elapsed)
			@_previousTime = now
			@dispatchEvent(event, true)

			# Dispatch buffered events
			eventInformation = EventDispatcher.readEvents()
			for eventInfo in eventInformation
				eventInfo.dispatcher.dispatchEvent(eventInfo.event, true)

			# Render the canvas
			Stage.ctx.clearRect(0, 0, Stage.canvas.width, Stage.canvas.height)
			@render(Stage.ctx)