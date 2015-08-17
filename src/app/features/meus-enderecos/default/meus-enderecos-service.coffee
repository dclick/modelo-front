angular.module "modeloBase"
  .service "MeusEnderecosService", ($q, $http, APP_BASE_URL) ->

    pagination = (page, size, search) ->
      params = {}

      if angular.isDefined(page)
        params.page = page

      if angular.isDefined(size)
        params.size = size

      if angular.isDefined(search)
        params.search = search if search.trim() != ""

      return params

    return {

      getAll: (page, size, search) ->
        $http
          url               : APP_BASE_URL + 'endereco-favoritos'
          method            : 'GET'
          params            : pagination(page, size, search)

      get: (id) ->
        $http
          url    : APP_BASE_URL + "endereco-favoritos/#{id}"
          method : 'GET'

      create: (data) ->
        $http
          url              : APP_BASE_URL + 'endereco-favoritos'
          method           : 'POST'
          data             : data

      delete: (id) ->
        $http
          url    : APP_BASE_URL + "endereco-favoritos/#{id}"
          method : 'DELETE'
    }