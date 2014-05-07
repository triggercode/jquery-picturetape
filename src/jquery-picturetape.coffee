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
      x: 0
      y: 0
      anchor: 7
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
      $(_this.el).append(_this.image)
      _this.update()

      $(window).on 'resize', _this.update.bind(_this)
      # $dom_image.css 'display', 'none'
      # sticker = new Sticker $dom_image, parent, anchor, x, y, offset_x, offset_y
      # sticker.update()

    # $(@parent).append @image
    # $(@parent).css 'position', 'relative'
    # $(window).on 'resize', =>
    #   @update()

  update: =>
    # @image.css 'display', 'none'

    base_height = $(@el).innerHeight()
    base_width = $(@el).innerWidth()

    pos_x = base_width / 100 * @settings.x
    pos_x = @anchor_x pos_x
    pos_y = base_height / 100 * @settings.y
    pos_y = @anchor_y pos_y

    if @offset_x
      pos_x += @offset_x

    if @offset_y
      pos_y += @offset_y

    @image.css
      position: "absolute"
      top: pos_y
      left: pos_x
      display: 'block'

  anchor_x: (x) =>
    if 1 <= @settings.anchor <= 3
      return x - @image.width()
    else if @settings.anchor in [0,4,8]
      return x - @image.width() * 0.5
    return x

  anchor_y: (y) =>
    if 3 <= @settings.anchor <= 5
      return y - @image.height()
    else if @settings.anchor in [2,6,8]
      return y - @image.height() * 0.5
    return y

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