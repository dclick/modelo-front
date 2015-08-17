angular.module "sescMotoFrete"
  .service "MeService", ($http, APP_BASE_URL) ->

    return {

      get: () ->
        $http
          url    : APP_BASE_URL + 'me'
          method : 'GET'

      botoes: () ->
        $http
          url    : APP_BASE_URL + 'me/botoes'
          method : 'GET'

    }