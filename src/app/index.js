'use strict';

angular.module('modeloFront.components',[
  'modeloFront.components.navbar'
]);

angular.module('modeloFront.app',[
  'modeloFront.app.main'
]);

angular.module('modeloFront.features',[
  
]);

angular.module('modeloFront', [
  'ngAnimate', 
  'ngCookies', 
  'ngTouch', 
  'ngSanitize', 
  'ui.router', 
  'ui.bootstrap',
  'modeloFront.app',
  'pascalprecht.translate',
  'modeloFront.components',
  'modeloFront.features'
]);

angular.module('modeloFront')
  .config(function ($stateProvider, $urlRouterProvider,$translateProvider) {

    var translations = {
      HEADLINE: 'Always a pleasure scaffolding your apps Personalizada'//,
      //ALLO_ALLO: 'Allo, Allo!'
    };

    $translateProvider
      .translations('en', translations)
      .preferredLanguage('en');

    $urlRouterProvider.otherwise('/');
  })
;
