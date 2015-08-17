angular.module "sescMotoFrete"
  .service "UsuarioService", ($http, APP_BASE_URL) ->

    return {

      getByUnidade: (unidadeId) ->
        $http
          url    : APP_BASE_URL + 'usuarios'
          method : 'GET'
          params : { unidade: unidadeId }

    }