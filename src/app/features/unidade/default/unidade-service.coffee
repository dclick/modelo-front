angular.module "sescMotoFrete"
  .service "UnidadeService", ($http, APP_BASE_URL) ->

    return {

      getAll: () ->
        $http
          url    : APP_BASE_URL + 'unidades'
          method : 'GET'

      get: (id) ->
        $http
          url    : APP_BASE_URL + "unidades/#{id}"
          method : 'GET'

    }