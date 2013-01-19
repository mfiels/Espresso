define ['espresso/events/Event'], (Event) ->
	###
	# An event subclass for the enterFrame event.
	###
	class EnterFrameEvent extends Event

		###
		# Create a new EnterFrameEvent with an elapsed amount of time.
		###
		constructor: (@elapsed) ->
			super('enterFrame')