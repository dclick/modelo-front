angular.module "modeloBase"
  .service "CceService", ($http, APP_BASE_URL) ->

    return {

      get: (unidadeId) ->
        $http
          url    : APP_BASE_URL + 'cces'
          method : 'GET'
          params : { unidadeId: unidadeId }

    }