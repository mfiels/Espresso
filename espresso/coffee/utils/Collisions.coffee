define ->
	###
	# A collection of collision tests.
	###
	class Collisions

		###
		# Given a rectangle consisting of (centerX, centerY, x, y, width, height, angle) determine if (x, y) is in it
		###
		@rectangleContainsPoint: (rectangle, x, y) ->
			c = Math.cos(-rectangle.angle * Math.PI / 180)
			s = Math.sin(-rectangle.angle * Math.PI / 180)

			rotatedX = rectangle.centerX + c * (x - rectangle.centerX) - s * (y - rectangle.centerY)
			rotatedY = rectangle.centerY + s * (x - rectangle.centerX) + c * (y - rectangle.centerY)

			left = rectangle.x
			right = rectangle.x + rectangle.width
			top = rectangle.y
			bottom = rectangle.y + rectangle.height

			return left <= rotatedX and rotatedX <= right and top <= rotatedY and rotatedY <= bottom