'use strict';

var gulp = require('gulp');

var paths = gulp.paths;

var $ = require('gulp-load-plugins')();

var wiredep = require('wiredep').stream;

gulp.task('inject', ['styles', 'scripts'], function () {

  var injectStyles = gulp.src([
    paths.tmp + '/serve/{app,components}/**/*.css',
    '!' + paths.tmp + '/serve/app/vendor.css'
  ], { read: false });

  var injectGuidelineStyles = gulp.src([
    paths.src + '/guideline/**/*.css',
  ], { read: false });

  var injectScripts = gulp.src([
    '{' + paths.src + ',' + paths.tmp + '/serve}/{app,components}/**/*.js',
    '!' + paths.src + '/{app,components}/**/*.spec.js',
    '!' + paths.src + '/{app,components}/**/*.spec.js',
    '!' + paths.src + '/{app,components}/**/*.mock.js',
    // '!' + paths.src + '/config/*.js',
    '!' + paths.src + '/guideline/**/*.js'
  ]).pipe($.angularFilesort());

  var injectOptions = {
    ignorePath: [paths.src, paths.tmp + '/serve'],
    addRootSlash: false
  };

  var injectGuidelineScripts = gulp.src(
    paths.src + '/guideline/**/*.js'
  ).pipe($.angularFilesort());

  var injectGuidelineOptions = {
    starttag: '<!-- inject:guideline:{{ext}} -->',
    ignorePath: [paths.src, paths.tmp + '/serve'],
    addRootSlash: false
  };

  // var injectConfigScripts = gulp.src([
  //   paths.src + '/config/*.js',
  // ]).pipe($.angularFilesort());

  // var injectConfigOptions = {
  //   starttag: '<!-- inject:config:{{ext}} -->',
  //   ignorePath: [paths.src, paths.tmp + '/serve'],
  //   addRootSlash: false
  // };

  var wiredepOptions = {
    directory: 'bower_components',
    exclude: [/bootstrap-sass-official/, /bootstrap\.css/, /bootstrap\.css/, /foundation\.css/]
  };

  return gulp.src(paths.src + '/*.html')
    .pipe($.inject(injectStyles, injectOptions))
    .pipe($.inject(injectGuidelineStyles, injectGuidelineOptions))
    // .pipe($.inject(injectConfigScripts, injectConfigOptions))
    .pipe($.inject(injectScripts, injectOptions))
    .pipe($.inject(injectGuidelineScripts, injectGuidelineOptions))
    .pipe(wiredep(wiredepOptions))
    .pipe(gulp.dest(paths.tmp + '/serve'));

});
