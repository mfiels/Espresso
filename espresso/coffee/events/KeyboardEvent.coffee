define ['espresso/events/Event'], (Event) ->
	###
	# A class for keyDown and keyUp events.
	###
	class KeyboardEvent extends Event

		###
		# Create a KeyboardEvent from a DOM event.
		###
		@fromDOMEvent = (e) ->
			return new KeyboardEvent(
				e.keyCode, 
				String.fromCharCode(e.keyCode), 
				if e.type is 'keydown' then 'keyDown' else if e.type is 'keyup' then 'keyUp' else ''
			)

		###
		# Construct a KeyboardEvent.
		###
		constructor: (@keyCode, @keyChar, type) ->
			super(type)