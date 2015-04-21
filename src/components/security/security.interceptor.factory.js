'use strict';
angular.module('redspark.components.security.factories').factory('SecurityInterceptor', function($q, $rootScope, ControleMensagem, $injector, $translate, $log, SecurityInterceptorMessages) {
    return {
      responseError: function(rejection) {

        switch (rejection.status) {
          case 400:
            SecurityInterceptorMessages.apply400(rejection);
            break;
          case 401:
            SecurityInterceptorMessages.apply401(rejection);
            $q.reject(rejection);
            break;
          case 403:
          case 404:
            SecurityInterceptorMessages.apply403(rejection);
            break;
          case 412:
            SecurityInterceptorMessages.apply412(rejection);
            break;
          case 500:
            SecurityInterceptorMessages.apply500(rejection);
            break;
          case 502:
          case 503:
            SecurityInterceptorMessages.apply502(rejection);
            break;
        }
        return $q.reject(rejection);
      }
    };
});