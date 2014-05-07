(function() {
  var $, Picturetape,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  $ = jQuery;


  /*
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
   */

  Picturetape = (function() {
    function Picturetape(el, options) {
      var _this;
      this.el = el;
      this.options = options;
      this.anchor_y = __bind(this.anchor_y, this);
      this.anchor_x = __bind(this.anchor_x, this);
      this.update = __bind(this.update, this);
      if (this.options.src == null) {
        throw new Error('Error: Please specify the src option');
      }
      this.settings = {
        x: 0,
        y: 0,
        anchor: 7,
        offset_x: 0,
        offset_y: 0
      };
      this.settings = $.extend(this.settings, options);
      if ($(this.el).css('position') === 'static') {
        $(el).css('position', 'relative');
      }
      _this = this;
      this.image = $('<img/>').attr('src', this.settings.src).load(function() {
        $(_this.el).append(_this.image);
        _this.update();
        return $(window).on('resize', _this.update.bind(_this));
      });
    }

    Picturetape.prototype.update = function() {
      var base_height, base_width, pos_x, pos_y;
      base_height = $(this.el).innerHeight();
      base_width = $(this.el).innerWidth();
      pos_x = base_width / 100 * this.settings.x;
      pos_x = this.anchor_x(pos_x);
      pos_y = base_height / 100 * this.settings.y;
      pos_y = this.anchor_y(pos_y);
      if (this.offset_x) {
        pos_x += this.offset_x;
      }
      if (this.offset_y) {
        pos_y += this.offset_y;
      }
      return this.image.css({
        position: "absolute",
        top: pos_y,
        left: pos_x,
        display: 'block'
      });
    };

    Picturetape.prototype.anchor_x = function(x) {
      var _ref, _ref1;
      if ((1 <= (_ref = this.settings.anchor) && _ref <= 3)) {
        return x - this.image.width();
      } else if ((_ref1 = this.settings.anchor) === 0 || _ref1 === 4 || _ref1 === 8) {
        return x - this.image.width() * 0.5;
      }
      return x;
    };

    Picturetape.prototype.anchor_y = function(y) {
      var _ref, _ref1;
      if ((3 <= (_ref = this.settings.anchor) && _ref <= 5)) {
        return y - this.image.height();
      } else if ((_ref1 = this.settings.anchor) === 2 || _ref1 === 6 || _ref1 === 8) {
        return y - this.image.height() * 0.5;
      }
      return y;
    };

    return Picturetape;

  })();

  $.fn.extend({
    picturetape: function(options) {
      var log;
      log = function(msg) {
        if (settings.debug) {
          return typeof console !== "undefined" && console !== null ? console.log(msg) : void 0;
        }
      };
      return this.each(function() {
        return new Picturetape(this, options);
      });
    }
  });

}).call(this);
