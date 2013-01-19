define ['espresso/events/EventDispatcher'], (EventDispatcher) ->
	###
	# A base class for displaying something on the canvas.
	###
	class DisplayObject extends EventDispatcher

		###
		# Construct a DisplayObject at (x, y).
		###
		constructor: (@x=0, @y=0) ->
			super()

			# Public properties
			@width 		= 0		# The width
			@height 	= 0		# The height
			@rotation 	= 0		# The rotation in degrees
			@scaleX 	= 1 	# The x scaling factor
			@scaleY 	= 1 	# The y scaling factor
			
			# Private properties
			@_children 	= []	# The children

		###
		# Add a child to this DisplayObject's display list.
		###
		addChild: (child) ->
			@_children.push(child)

		###
		# Test to see if a child is in the display list.
		###
		containsChild: (child) ->
			return @_children.indexOf(child) isnt -1

		###
		# Remove a child from this DisplayObject's display list.
		###
		removeChild: (child) ->
			index = @_children.indexOf(child)
			if index isnt -1
				@_children.splice(index, 1)
				return true
			return false

		###
		# Transform and render this DisplayObject and all children.
		###
		render: (ctx) ->
			ctx.save()
			ctx.translate(@x, @y)
			ctx.rotate(@rotation * Math.PI / 180.0)
			ctx.scale(@scaleX, @scaleY)
			@_draw(ctx)
			for child in @_children
				child.render(ctx)
			ctx.restore()

		###
		# To be overridden.
		###
		_draw: (ctx) ->
			return