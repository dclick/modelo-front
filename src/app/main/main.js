'use strict';

angular.module('modeloFront')
  .config(function ($stateProvider) {
    
    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: 'app/main/main.html',
        controller: 'MainCtrl'
      });

    
  })
;
