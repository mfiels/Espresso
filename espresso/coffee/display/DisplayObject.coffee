define ['espresso/events/EventDispatcher', 'espresso/events/Event'], (EventDispatcher, Event) ->
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
			@parent		= null	# The DisplayObject which this is added to

			# Private properties
			@_children 	= []	# The children
			@_zIndex	= 1 	# The z index; higher overlays lower

		###
		# Add a child to this DisplayObject's display list.
		###
		addChild: (child) ->
			if child.parent
				child.parent.removeChild(child)
			child.parent = @
			@_insertChild(child)

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
				@parent = null
				return true
			return false

		###
		# Set the zIndex.
		###
		setZIndex: (z) ->
			@_zIndex = z
			index = @parent._children.indexOf(@)
			@parent._children.splice(index, 1)
			@parent._insertChild(@)

		###
		# Get the zIndex.
		###
		getZIndex: () ->
			return @_zIndex

		###
		# Given a child insert it in the display list in the right spot.
		###
		_insertChild: (child) ->
			inserted = false
			for c, i in @_children
				if child._zIndex < c._zIndex
					@_children.splice(i, 0, child)
					inserted = true
					break
			if !inserted
				@_children.push(child)

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