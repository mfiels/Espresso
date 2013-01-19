define ->
	###
	# A static class for polling input.
	###
	class Input
		@_keyCodeStates = {}
		@_keyCharStates = {}

		@_mouseButtonCodeStates = {}
		@_mouseButtonNameStates = {}
		@mouseX = 0
		@mouseY = 0

		###
		# Test to see if a key is down.
		###
		@isKeyDown = (key) ->
			if key.constructor is Number
				return @isKeyCodeDown(key)
			else if key.constructor is String
				return @isKeyCharDown(key)
			return false

		###
		# Test to see if a key is down by keyCode.
		###
		@isKeyCodeDown = (keyCode) ->
			return @_keyCodeStates[keyCode]

		###
		# Test to see if a key is down by keyChar.
		###
		@isKeyCharDown = (keyChar) ->
			return @_keyCharStates[keyChar]

		###
		# Test to see if a mouse button is down.
		###
		@isMouseButtonDown = (button) ->
			if button.constructor is Number
				return @isMouseButtonCodeDown(button)
			else if button.constructor is String
				return @isMouseButtonNameDown(button)
			return false

		###
		# Test to see if a mouse button is down by buttonCode.
		###
		@isMouseButtonCodeDown = (buttonCode) ->
			return @_mouseButtonCodeStates[buttonCode]

		###
		# Test to see if a mouse button is down by buttonName.
		###
		@isMouseButtonNameDown = (buttonName) ->
			return @_mouseButtonNameStates[buttonName]