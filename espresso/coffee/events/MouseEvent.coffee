define ['espresso/events/Event', 'espresso/display/Stage', 'espresso/events/Input'], (Event, Stage, Input) ->
	###
	# A class for mouseUp, mouseDown, and mouseMove events.
	###
	class MouseEvent extends Event

		@_domEventMap = {
			'mousedown': 'mouseDown',
			'mouseup': 'mouseUp',
			'mousemove': 'mouseMove',
			'touchstart': 'mouseDown',
			'touchend': 'mouseUp',
			'touchmove': 'mouseMove'
		}

		###
		# Create a MouseEvent from a DOM event.
		###
		@fromDOMEvent = (e, Input) ->
			if e.targetTouches
				if e.targetTouches.length isnt 0
					x = e.targetTouches[0].clientX
					y = e.targetTouches[0].clientY
				else
					x = Input.mouseX
					y = Input.mouseY
			else
				x = e.layerX
				y = e.layerY
			return new MouseEvent(
				x,
				y,
				e.target,
				e.button,
				if e.button is 0 then 'left' else if e.button is 1 then 'middle' else if e.button is 2 then 'right' else ''
				if @_domEventMap[e.type] then @_domEventMap[e.type] else ''
			)
			

		###
		# Construct a MouseEvent for an (x, y) position and a specific button.
		###
		constructor: (@x, @y, @target, @buttonCode, @buttonName, type) ->
			super(type)