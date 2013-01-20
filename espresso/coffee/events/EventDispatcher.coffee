define ->
	###
	# Listens for and dispatches events.
	###
	class EventDispatcher

		@_bufferedEvents = []
		@_mouseTargets = []
		@_mouseTargetCount = {}

		@_mouseEvents = [
			'mouseOver', 'mouseOff', 
			'mouseUp', 'mouseDown'
		]

		###
		# Read all of the buffered events and clear the buffer.
		###
		@readEvents = () ->
			events = @_bufferedEvents
			@_bufferedEvents = []
			return events

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

			if @.constructor.name isnt 'Stage' and EventDispatcher._mouseEvents.indexOf(type) isnt -1
				if EventDispatcher._mouseTargetCount[@] is undefined
					EventDispatcher._mouseTargetCount[@] = 0
				EventDispatcher._mouseTargetCount[@]++
				if EventDispatcher._mouseTargets.indexOf(@) is -1
					EventDispatcher._mouseTargets.push(@)

			@_listeners[type].push(listener)

		###
		# Remove an event listener of the specified type.
		###
		removeEventListener: (type, listener) ->
			if @_listeners[type]
				index = @_listeners[type].indexOf(listener)
				if index isnt -1
					@_listeners.splice(index, 1)

					if @.constructor.name isnt 'Stage' and EventDispatcher._mouseEvents.indexOf(type) isnt -1
						EventDispatcher._mouseTargetCount[@]--
						if EventDispatcher._mouseTargetCount[@] == 0
							targetIndex = EventDispatcher._mouseTargets.indexOf(@)
							EventDispatcher._mouseTargets.splice(targetIndex, 1)

					return true
			return false

		###
		# Notify listeners that an event occured.
		###
		dispatchEvent: (event, now=false) ->
			if now
				if event.type
					if @_listeners[event.type]
						for listener in @_listeners[event.type]
							listener(event)
							if event.cancel
								break
			else
				eventInfo = {
					dispatcher: @,
					event: event
				}
				EventDispatcher._bufferedEvents.push(eventInfo)
			return