'use strict';

angular.module('modeloFront.app.main', ['modeloFront.app.main.controllers', 'pascalprecht.translate'])
  .config(function ($stateProvider,$translateProvider) {
    
    var translations = {
      HEADLINE: 'Always a pleasure scaffolding your apps.',
      SPLENDID: 'Splendid!',
      ALLO_ALLO: 'Allo, Allo! Nativoooo'
    };

    $translateProvider
      .translations('en', translations)
      .preferredLanguage('en');

    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: 'app/main/main.html',
        controller: 'MainCtrl'
      });
    
  })
;
