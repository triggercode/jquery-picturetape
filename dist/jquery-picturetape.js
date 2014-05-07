(function() {
  var $, Picturetape,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  $ = jQuery;

  Picturetape = (function() {
    function Picturetape(el, options) {
      var set, _i, _len, _ref, _this;
      this.el = el;
      this.options = options;
      this.update = __bind(this.update, this);
      if (this.options.src == null) {
        throw new Error('Error: Please specify the src option');
      }
      this.settings = {
        classes: [],
        id: '',
        x: 0,
        y: 0,
        anchor_x: 0,
        anchor_y: 0,
        offset_x: 0,
        offset_y: 0
      };
      this.settings = $.extend(this.settings, options);
      _ref = ['x', 'y', 'anchor_x', 'anchor_y', 'offset_x', 'offset_y'];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        set = _ref[_i];
        this.settings[set] = Number(this.settings[set]);
      }
      if ($(this.el).css('position') === 'static') {
        $(el).css('position', 'relative');
      }
      _this = this;
      this.image = $('<img/>').attr('src', this.settings.src).load(function() {
        $(_this.el).append(_this.image);
        if (_this.settings.id !== '') {
          _this.image.attr('id', _this.settings.id);
        }
        _this.image.addClass(_this.settings.classes.join(" "));
        _this.update();
        return $(window).on('resize', _this.update.bind(_this));
      });
    }

    Picturetape.prototype.update = function() {
      var base_height, base_width, pos_x, pos_y;
      base_height = $(this.el).innerHeight();
      base_width = $(this.el).innerWidth();
      pos_x = base_width / 100 * this.settings.x;
      pos_x = pos_x - this.image.width() / 100 * this.settings.anchor_x;
      pos_x += this.settings.offset_x;
      pos_y = base_height / 100 * this.settings.y;
      pos_y = pos_y - this.image.height() / 100 * this.settings.anchor_y;
      pos_y += this.settings.offset_y;
      return this.image.css({
        position: "absolute",
        top: pos_y,
        left: pos_x
      });
    };

    return Picturetape;

  })();

  $.fn.extend({
    picturetape: function(options) {
      return this.each(function() {
        return new Picturetape(this, options);
      });
    }
  });

}).call(this);
