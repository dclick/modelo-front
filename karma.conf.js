'use strict';

module.exports = function(config) {

  var configuration = {
    autoWatch : false,

    frameworks: ['jasmine'],

    ngHtml2JsPreprocessor: {
      stripPrefix: 'src/',
      moduleName: 'redspark.templates'
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
      'src/**/!(*spec.js|*.html)': ['coverage']
    },

    junitReporter: {
      outputFile: 'coverage/test-results.xml',
      suite: ''
    },

    coverageReporter: {
      dir : 'coverage',
      reporters: [
        // reporters not supporting the `file` property
        { type: 'html', subdir: 'report-html' },
        //{ type: 'lcov', subdir: 'report-lcov' },
        // reporters supporting the `file` property, use `subdir` to directly
        // output them in the `dir` directory
        //{ type: 'cobertura', subdir: '.', file: 'cobertura.txt' },
        { type: 'lcovonly', subdir: '.', file: 'report-lcov.lcov' },
        //{ type: 'teamcity', subdir: '.', file: 'teamcity.txt' },
        //{ type: 'text', subdir: '.', file: 'text.txt' },
        //{ type: 'text-summary', subdir: '.', file: 'text-summary.txt' },
      ]
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
