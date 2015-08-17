angular.module "sescMotoFrete"
  .controller "LoginService", ($http, APP_BASE_URL) ->

    return {

      get: () ->
        $http
          url    : APP_BASE_URL + 'login'
          method : 'GET'

      create: (id) ->
        $http
          url    : APP_BASE_URL + 'login'
          method : 'POST'

    }