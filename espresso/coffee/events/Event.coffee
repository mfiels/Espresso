define ->
	###
	# A simple event object.
	###
	class Event

		###
		# Create an event of a specific type and optionally attach data to it.
		###
		constructor: (@type, @data=null) ->