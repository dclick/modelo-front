'use strict'

angular.module "modeloBase"
  .directive "minNumber", ($timeout) ->
    restrict : 'A'
    require: "ngModel",
    scope    :
      minNumber: '@'
    link : (scope, elem, attr, ctrl) ->

      ##################################
      ## Methods
      ##################################
      elem.bind 'blur', () ->
        $timeout () ->
          newValFloat = parseFloat(elem.val())
          if  newValFloat < scope.minNumber
            ctrl.$setValidity('minNumber', false);
            # elem.val(scope.minNumber)
          else
            ctrl.$setValidity('minNumber', true);
          # scope.$apply();


      ##################################
      ## Init
      ##################################

