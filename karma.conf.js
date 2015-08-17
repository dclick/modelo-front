'use strict';

module.exports = function(config) {

  config.set({
    autoWatch : false,

    frameworks: ['jasmine'],

    browsers : [
      'PhantomJS'
      // 'Chrome'
    ],

    plugins : [
      'karma-phantomjs-launcher',
      'karma-ng-html2js-preprocessor',
      'karma-chrome-launcher',
      'karma-jasmine',
      'karma-coverage'
    ],

    preprocessors: {
      'src/{app,components}/**/*.html' : ['ng-html2js']
      // '.tmp/serve/{app,components/!(guideline)}/**/*.js' : ['coverage']
    },

    // generates the coverage
    reporters: [
      'progress',
      'coverage'
    ],

    // Output coverage file
    coverageReporter: {
      type : 'lcov',
      subdir: 'report-lcov',
      // output path
      dir : 'tests/coverage/'
    },

    exclude: [
      'app/i18n/pt-BR.json'
    ],


    ngHtml2JsPreprocessor: {
      stripPrefix : 'src/'
    },

    // logLevel: 'config.LOG_DEBUG'
    browserDisconnectTimeout : 10000, // default 2000
    browserDisconnectTolerance : 1, // default 0
    browserNoActivityTimeout : 60000, //default 10000
  });
};
