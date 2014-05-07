gulp = require 'gulp'
coffee = require 'gulp-coffee'

gulp.task 'default', ->
  return gulp.src('src/*.coffee')
    .pipe(coffee())
    .pipe(gulp.dest('dist'))