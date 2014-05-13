# jQuery Picturetape

Tape your pictures to any DOM element. In a flexible way.

## Installation

You can clone this repository, download the ZIP on the right, or simply use Bower:

	bower install jquery-picturetape

Include the file **dist/jquery-picturetape.js** in your project and you can start using it.

## Quickstart
	
	$(selector).picturetape({
		src: 'path/to/image',
		x: 0, // A numeric value to specify the x position relative to the parents width.
		y: 0, // A numeric value to specify the y position relative to the parents height.
		offset_x: 0, // A numeric value to specify a absolute pixel offset on the x-axis.
		offset_y: 0, // A numeric value to specify a absolute pixel offset on the y-axis.
		anchor_x: 0, // A numeric value to specify the anchor of image relative to its width.
		anchor_y: 0 // A numeric value to specify the anchor of image relative to its height.
	});	
	
The **selector** is the parent the picture is attached to.

## Documentation

Please find the extensive [documentation](http://triggercode.github.io/jquery-picturetape) here http://triggercode.github.io/jquery-picturetape.

## For Developers

We prefer to write Coffeescript. That means we need to compile the Coffeescript sources into Javascript. That is done using the **gulp** build system. Gulp depends on Node.js so you might want to install it.

### Building it yourself

1. Install node
2. Clone/Fork the repository
3. Install all dependencies for the build system:

    jquery-picturetape npm install

Then you can use the following command to build the Javascript files:

	gulp

Or you can use the watch task let the files compile on filechanges:

	gulp watch
	
### Contributing

1. Fork the repository
2. Create a pull request