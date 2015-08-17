'use strict'


angular.module "sescMotoFrete"

  .directive "permissoes", ($rootScope, PermissaoService) ->
    restrict : 'A'
    scope    :
      permissoes : '@'

    link : (scope, elem, attr) ->

      ##################################
      ## Methods
      ##################################
      scope.validaPermissoes = ->
        scope.valido = PermissaoService.validaPermissoes(scope.permissoes)

        scope.mudaEstadoElemento()

      scope.mudaEstadoElemento = ->
        if scope.valido
          elem.removeClass('ng-hide');
        else
          elem.addClass('ng-hide');

      ##################################
      ## Init
      ##################################
      elem.addClass('ng-hide');
      scope.validaPermissoes(scope.permissoes)

