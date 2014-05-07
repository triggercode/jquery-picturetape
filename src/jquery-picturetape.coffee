# Reference jQuery
$ = jQuery

###
Anchors are like a clock, they start at top center with 0 and increment
clockwise.
0 - top center
1 - top right
2 - middle right
3 - bottom right
4 - bottom center
5 - bottom left
6 - middle left
7 - top left
8 - center
###
class Picturetape
  constructor: (@el, @options) ->
    unless @options.src? then throw new Error 'Error: Please specify the src option'

    # Default settings
    @settings =
      id: ''
      x: 0
      y: 0
      anchor_x: 0
      anchor_y: 0
      offset_x: 0
      offset_y: 0

    # Merge default settings with options.
    @settings = $.extend @settings, options

    # set parent to relative if needed
    if $(@el).css('position') == 'static'
      $(el).css 'position', 'relative'

    # load the image, update the position
    _this = @
    @image = $('<img/>').attr('src', @settings.src).load ->
      # append the image to the dom
      $(_this.el).append(_this.image)
      # set the ID if needed
      _this.image.attr 'id', _this.settings.id unless _this.settings.id == ''
      # update the position
      _this.update()
      # on resize, also update the position
      $(window).on 'resize', _this.update.bind(_this)

  update: =>
    # calculate the parent height and width
    base_height = $(@el).innerHeight()
    base_width = $(@el).innerWidth()

    # calc the x position
    pos_x = base_width / 100 * @settings.x
    pos_x = pos_x - @image.width() / 100 * @settings.anchor_x
    pos_x += @settings.offset_x
    # calc the y position
    pos_y = base_height / 100 * @settings.y
    pos_y = pos_y - @image.height() / 100 * @settings.anchor_y
    pos_y += @settings.offset_y

    @image.css
      position: "absolute"
      top: pos_y
      left: pos_x

# Adds plugin object to jQuery
$.fn.extend
  # Change pluginName to your plugin's name.
  picturetape: (options) ->
    # Simple logger.
    log = (msg) ->
      console?.log msg if settings.debug

    # _Insert magic here._
    return @each ()->
      new Picturetape @, options