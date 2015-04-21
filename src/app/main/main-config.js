'use strict';

angular.module('redspark.app.main', ['redspark.app.main.controllers', 'pascalprecht.translate'])
  .config(function ($stateProvider,$translateProvider,MainTranslateProvider) {
    
    $translateProvider
      .translations('pt_BR', MainTranslateProvider.pt_BR());

    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: 'app/main/main.html',
        controller: 'MainCtrl'
      });
    
  })
;
