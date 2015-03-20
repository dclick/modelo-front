'use strict';

angular.module('modeloFront.app.main', ['modeloFront.app.main.controllers'])
  .config(function ($stateProvider) {
    
    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: 'app/main/main.html',
        controller: 'MainCtrl'
      });
    
  })
;
