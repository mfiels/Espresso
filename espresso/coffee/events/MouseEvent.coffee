define ['espresso/events/Event'], (Event) ->
	###
	# A class for mouseUp, mouseDown, and mouseMove events.
	###
	class MouseEvent extends Event

		###
		# Create a MouseEvent from a DOM event.
		###
		@fromDOMEvent = (e) ->
			return new MouseEvent(
				e.layerX,
				e.layerY,
				e.button,
				if e.button is 0 then 'left' else if e.button is 1 then 'middle' else if e.button is 2 then 'right' else ''
				if e.type is 'mousedown' then 'mouseDown' else if e.type is 'mouseup' then 'mouseUp' else if e.type is 'mousemove' then 'mouseMove' else ''
			)

		###
		# Construct a MouseEvent for an (x, y) position and a specific button.
		###
		constructor: (@x, @y, @buttonCode, @buttonName, type) ->
			super(type)