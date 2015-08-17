'use strict'

angular.module('guideline.breadcrumbs.template', [])

.run [
  '$templateCache'
  ($templateCache)->
    $templateCache.put "guideline/breadcrumbs/breadcrumbs.html",
      """
      <ul class="breadcrumb">
        <li ng-repeat="state in states" ng-class="{active : state.active}">
          <a ng-if="!state.active" ng-bind="state.name" ui-sref="{{state.state}}"></a>
          <span ng-if="state.active" ng-bind="state.name"></span>
          <span ng-hide="state.active && !state.abstract" class="divider">»</span>
        </li>
      </ul>
      """

    return

]

