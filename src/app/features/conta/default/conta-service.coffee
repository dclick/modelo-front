angular.module "sescMotoFrete"
  .service "ContaService", ($http, APP_BASE_URL) ->

    return {

      getAll: () ->
        $http
          url    : APP_BASE_URL + 'contas'
          method : 'GET'

    }