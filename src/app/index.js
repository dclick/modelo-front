'use strict';

/**
 Modules
**/

angular.module('modeloFront.controllers' , []);
angular.module('modeloFront.filters'     , []);
angular.module('modeloFront.factories'   , []);
angular.module('modeloFront.services'    , []);
angular.module('modeloFront.constants'   , []);
angular.module('modeloFront.directives'  , []);
/**
 Script modules
**/
angular.module('modeloFront.scripts',[
  'modeloFront.controllers',
  'modeloFront.constants',
  'modeloFront.filters',
  'modeloFront.factories',
  'modeloFront.services',
  'modeloFront.directives'
]);

angular.module('modeloFront', [
  'ngAnimate', 
  'ngCookies', 
  'ngTouch', 
  'ngSanitize', 
  'ui.router', 
  'ui.bootstrap',
  'modeloFront.scripts'
]);

angular.module('modeloFront')
  .config(function ($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/');
  })
;
