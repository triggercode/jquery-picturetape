# Reference jQuery
$ = jQuery

class Picturetape
  constructor: (@el, @options) ->
    unless @options.src? then throw new Error 'Error: Please specify the src option'
    # Default settings
    @settings =
      classes: []
      id: ''
      x: 0
      y: 0
      anchor_x: 0
      anchor_y: 0
      offset_x: 0
      offset_y: 0
    # Merge default settings with options.
    @settings = $.extend @settings, options
    # ensure numerical values
    foreach set in ['x', 'y', 'anchor_x', 'anchor_y', 'offset_x', 'offset_y']
      @settings[set] = Number(@settings[set])


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
      # add the classes
      _this.image.addClass _this.settings.classes.join(" ")
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
    # update the css of the image
    @image.css
      position: "absolute"
      top: pos_y
      left: pos_x

# Adds plugin object to jQuery
$.fn.extend
  # Change pluginName to your plugin's name.
  picturetape: (options) ->
    return @each ()->
      new Picturetape @, options