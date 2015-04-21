'use strict';

angular.module('redspark.components.security.factories', []);

angular.module('redspark.components.security', ['redspark.components.security.factories', 'pascalprecht.translate'])
  .config(function ($stateProvider,$translateProvider,$httpProvider,SecurityTranslateProvider) {
    
    $translateProvider
      .translations('pt_BR', SecurityTranslateProvider.pt_BR());

    $httpProvider.interceptors.push('SecurityInterceptor');
    
});

