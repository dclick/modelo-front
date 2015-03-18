'use strict';

module.exports = function(config) {

  var configuration = {
    autoWatch : false,

    frameworks: ['jasmine'],

    ngHtml2JsPreprocessor: {
      stripPrefix: 'src/',
      moduleName: 'gulpAngular'
    },

    browsers : ['PhantomJS'],

    reporters: ['progress', 'coverage','junit'],

    plugins : [
        'karma-phantomjs-launcher',
        'karma-jasmine',
        'karma-ng-html2js-preprocessor',
        'karma-coverage',
        'karma-junit-reporter',
        'karma-chrome-launcher'
    ],

    preprocessors: {
      'src/**/*.html': ['ng-html2js'],
      'src/**/!(*spec.js)': ['coverage']
    },

    junitReporter: {
      outputFile: 'coverage/test-results.xml',
      suite: ''
    },

    coverageReporter: {
      type : 'lcov',
      dir : 'coverage/',
      file: 'report-lcov.lcov'
    }

  };

  // This block is needed to execute Chrome on Travis
  // If you ever plan to use Chrome and Travis, you can keep it
  // If not, you can safely remove it
  // https://github.com/karma-runner/karma/issues/1144#issuecomment-53633076
  if(configuration.browsers[0] === 'Chrome' && process.env.TRAVIS) {
    configuration.customLaunchers = {
      'chrome-travis-ci': {
        base: 'Chrome',
        flags: ['--no-sandbox']
      }
    };
    configuration.browsers = ['chrome-travis-ci'];
  }

  config.set(configuration);
};
