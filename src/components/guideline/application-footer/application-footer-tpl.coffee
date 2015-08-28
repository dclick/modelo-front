'use strict'
angular.module "guideline.application-footer", ['guideline.application-footer.template']
  .directive "applicationFooter", ($rootScope, $window, $state, $timeout) ->
    restrict : 'A'
    replace  : yes
    scope    :
      applicationName : '@'

    templateUrl : 'guideline/application-footer/application-footer.html'

    link : (scope, elem, attr) ->
      scope.user = $rootScope.user

      ##################################
      ## Attributes
      ##################################


      ##################################
      ## Methods
      ##################################
