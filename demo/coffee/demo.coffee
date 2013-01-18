# Tell RequireJS where Espresso is relative to the demo/js directory
require.config
	paths:
		'espresso': '../../espresso/js'

# Require the dependencies and run demo here
require ['espresso/display/DisplayObject'], (DisplayObject) ->
	canvas = document.getElementById 'canvas'
	ctx = canvas.getContext '2d'
	
	displayObject = new DisplayObject()