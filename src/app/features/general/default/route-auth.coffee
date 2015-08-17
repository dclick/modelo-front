angular.module "modeloBase"
.factory "routeAuth", ($rootScope, $state, $window, PermissaoService, APP_USER_NOT_AUTH_REDIRECT) ->

  return {

    updateUserInfo: ->
      $rootScope.user = window.user

    verifyRouteAccess: (path, event) ->
      if path.data.restrict
        unless $rootScope.user
          event.preventDefault()
          if APP_USER_NOT_AUTH_REDIRECT.match(/http:\/\//g)
            $window.location.href = APP_USER_NOT_AUTH_REDIRECT
          else
            $state.go APP_USER_NOT_AUTH_REDIRECT
      else
        if $rootScope.user
          event.preventDefault()
          $state.go('tipoContrato.listar')

      if path.data.authorities
        hasPermission = PermissaoService.validaPermissoes(path.data.authorities)

        unless hasPermission
          event.preventDefault()
  }
