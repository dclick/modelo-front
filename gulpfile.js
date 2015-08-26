'use strict';

var gulp = require('gulp');

gulp.paths = {
  src: 'src',
  dist: '../backend_folder/src/main/resources/static',
  tmp: '.tmp',
  e2e: 'e2e',
  tests: 'tests',
  config: 'sesc-config/modelo'
};

require('require-dir')('./gulp');

gulp.task('default', ['clean'], function () {
    gulp.start('build');
});
