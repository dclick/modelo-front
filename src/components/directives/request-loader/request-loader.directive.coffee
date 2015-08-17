'use strict'


angular.module "modeloBase"

  .directive "requestLoader", ($rootScope) ->
    restrict    : 'A'
    scope       : {}
    replace     : yes
    templateUrl : 'request-loader/request-loader.html'

    link : (scope, elem, attr) ->

      ##################################
      ## Watchers
      ##################################
      scope.$on 'requestLoader:show', () ->
        elem.show();

      scope.$on 'requestLoader:hide', () ->
        elem.hide();

      ##################################
      ## Init
      ##################################
      elem.hide();