'use strict'

###*
 # @ngdoc directive
 # @name guideline.datepicker:Datepicker
 # @description
 # # DatePicker
###
angular.module('guideline.datepicker', [])

.directive "datepickerGuideline", [ "$timeout", ($timeout)->
  datepickerOptions =
    defaultDate: "+1w"
    changeMonth: true
    changeYear: true
    minDate: "D+M+Y"

  {
    restrict: 'A'
    require: "ngModel"
    link: (scope, elem, attrs, ngModel) ->

      elem.on 'keypress', (e) ->
        e.preventDefault()

      elem.on 'contextmenu', (e) ->
        e.preventDefault()

      elem.on 'paste', (e) ->
        e.preventDefault()

      $(elem).datepicker $.extend datepickerOptions, {
        onSelect: (selectedDate)->
          $timeout ->
            ngModel.$setViewValue selectedDate
      }

      scope.$on '$destroy', () ->
        $(elem).datepicker('hide')

  }
]
