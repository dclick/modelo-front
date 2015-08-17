angular.module "sescMotoFrete"
  .service "EnderecoService", ($http, APP_BASE_URL) ->

    return {

      getByZip: (cep) ->
        $http
          url    : APP_BASE_URL + 'enderecos/ceps'
          method : 'GET'
          params : { cep: cep }

      getStates: () ->
        $http
          url    : APP_BASE_URL + 'enderecos/estados'
          method : 'GET'

      getCitiesByState: (uf) ->
        $http
          url    : APP_BASE_URL + 'enderecos/cidades'
          method : 'GET'
          params : { uf: uf }

    }