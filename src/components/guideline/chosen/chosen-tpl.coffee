'use strict'

###*
 # @ngdoc directive
 # @name guideline.datatables.template:DatatablesTemplate
 # @description
 # # Datatables
###
angular.module('guideline.chosen.template', [])

.run [
  '$templateCache'
  ($templateCache)->
    $templateCache.put "guideline/chosen/chosen.html",
      """
      <select>
        <option ng-repeat="campo in guidelineChosen" chosen-item></option>
      </select>
      """

    return

]