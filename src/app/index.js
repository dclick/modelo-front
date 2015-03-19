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
  'modeloFront.components',
  'modeloFront.features'
]);

angular.module('modeloFront')
  .config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/');
  })
;
