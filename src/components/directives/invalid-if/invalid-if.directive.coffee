'use strict'

angular.module "modeloBase"

  .directive "invalidIf", ($timeout) ->
    restrict : 'A'
    require  : 'ngModel'

    link : (scope, elem, attr, ngModel) ->

      ##################################
      ## Attributes
      ##################################
      scope.comparator = null

      ##################################
      ## Methods
      ##################################
      scope.compareValue = (val) ->
        if Array.isArray(val)
          return val.length is scope.comparator.length

      scope.setValidity = (val) ->
        if scope.compareValue(val)
          ngModel.$setValidity 'invalidIf', no
        else
          ngModel.$setValidity 'invalidIf', yes

      scope.convertAttr = () ->
        scope.comparator = eval(attr.invalidIf)

      ##################################
      ## Watchers
      ##################################
      scope.$watch 'ngModel.$modelValue', (newVal, oldVal) ->
        $timeout () ->
          scope.setValidity(newVal)

      ##################################
      ## Init
      ##################################
      $timeout () ->
        scope.convertAttr()

