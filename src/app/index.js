'use strict';

angular.module('redspark.components',[
  'redspark.components.navbar'
]);

angular.module('redspark.app',[
  'redspark.app.main'
]);

angular.module('redspark.features',[
  
]);

angular.module('redspark', [
  'ngAnimate', 
  'ngCookies', 
  'ngTouch', 
  'ngSanitize', 
  'ui.router', 
  'ui.bootstrap',
  'redspark.app',
  'pascalprecht.translate',
  'redspark.components',
  'redspark.features'
]);

angular.module('redspark')
  .config(function ($stateProvider, $urlRouterProvider,$translateProvider,IndexTranslateProvider) {

    $translateProvider
      .translations('pt_BR', IndexTranslateProvider.pt_BR())
      .preferredLanguage('pt_BR');

    $urlRouterProvider.otherwise('/');
  })
;
