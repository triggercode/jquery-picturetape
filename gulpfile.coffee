gulp = require 'gulp'
coffee = require 'gulp-coffee'
plumber = require 'gulp-plumber'

gulp.task 'default', ->
  return gulp.src('src/*.coffee')
    .pipe(plumber())
    .pipe(coffee())
    .pipe(gulp.dest('dist'))

gulp.task 'watch', ->
  gulp.watch 'src/*.coffee', ['default']