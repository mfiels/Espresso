define ['espresso/display/DisplayObject'], (DisplayObject) ->
	###
	# A class for rendering resources.
	###
	class Sprite extends DisplayObject

		# Public static properties
		@useCache = true			# Whether or not to cache resources by default

		# Private static properties
		@_cache = {}				# Resource cache
		@_imageFileExtensions = [	# The allowed image extensions
			'.jpeg', '.jpg', 
			'.gif', '.png', 
			'.apng', '.svg', 
			'.bmp', '.ico'
		]

		###
		# Construct a Sprite at (x, y) with a resource of source.
		###
		constructor: (x=0, y=0, source=null, useCache=Sprite.useCache) ->
			super(x, y)

			@anchorX	= 0		# Center offset
			@anchorY	= 0		# Center offset
			
			@setSource(source, useCache)

		###
		# Set the resource to be rendered.
		###
		setSource: (source, useCache=Sprite.useCache) ->
			# Remove the previous source
			@source = null

			# Internal function for making Image objects
			makeImage = (src, container) ->
				image = new Image()
				image.onload = () ->
					container.width = @width
					container.height = @height
				image.src = src
				return image

			# If source argument isn't null
			if source
				# This is an image object
				if source.constructor is Image
					@source = source
				# This is a resource name
				else if source.constructor is String
					resource = source

					# Look for the file extension
					extensionMatch = resource.match(/\.[a-zA-Z0-9]*$/)

					# If an extension was found
					if extensionMatch
						extension = extensionMatch[0].toLowerCase()

						# This is an image resource
						if Sprite._imageFileExtensions.indexOf(extension) isnt -1
							# Use the cache
							if useCache
								# If it is in the cache
								if Sprite._cache[resource]
									@source = Sprite._cache[resource]
									@width = @source.width
									@height = @source.height
								# It is not in the cache
								else
									@source = makeImage(resource, @)
									Sprite._cache[resource] = @source
							# Don't use the cache
							else
								@source = makeImage(resource, @)
						# The extension is unknown
						else
							throw "The extension #{extension} is unknown"

				# If source wasn't set throw an error
				if !@source
					throw "Couldn't set #{source} as a source"

		###
		# Draw the resource.
		###
		_draw: (ctx) ->
			if @source
				ctx.drawImage(@source, -@anchorX, -@anchorY)
