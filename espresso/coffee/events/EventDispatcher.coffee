define ->
	###
	# Listens for and dispatches events.
	###
	class EventDispatcher

		###
		# Construct a new EventDispatcher.
		###
		constructor: () ->
			@_listeners = {}

		###
		# Add an event listener of the specified type.
		###
		addEventListener: (type, listener) ->
			if !@_listeners[type]
				@_listeners[type] = []
			@_listeners[type].push(listener)

		###
		# Remove an event listener of the specified type.
		###
		removeEventListener: (type, listener) ->
			if @_listeners[type]
				index = @_listeners[type].indexOf(listener)
				if index isnt -1
					@_listeners.splice(index, 1)
					return true
			return false

		###
		# Notify listeners that an event occured.
		###
		dispatchEvent: (event) ->
			if event.type
				if @_listeners[event.type]
					for listener in @_listeners[event.type]
						listener(event)
						if event.cancel
							break
			return