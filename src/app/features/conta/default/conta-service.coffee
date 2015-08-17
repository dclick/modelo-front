angular.module "modeloBase"
  .service "ContaService", ($http, APP_BASE_URL) ->

    return {

      getAll: () ->
        $http
          url    : APP_BASE_URL + 'contas'
          method : 'GET'

    }