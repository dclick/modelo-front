angular.module "modeloBase"
  .service "SolicitacaoService", ($http, APP_BASE_URL, solicitacaoTransformRequest, solicitacaoTransformResponse) ->

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
          url               : APP_BASE_URL + 'solicitacoes'
          method            : 'GET'
          params            : pagination(page, size, search)
          transformResponse : solicitacaoTransformResponse

      getAllWithEX: (page, size, search, itemContratoId) ->
        params              = pagination(page, size, search)
        params.expedicao    = 'COM_EXPEDICAO'
        params.itemcontrato = itemContratoId
        $http
          url               : APP_BASE_URL + 'solicitacoes'
          method            : 'GET'
          params            : params
          transformResponse : solicitacaoTransformResponse

      getByStatus: (page, size, search, status) ->
        params        = pagination(page, size, search)
        params.status = status
        $http
          url               : APP_BASE_URL + 'solicitacoes'
          method            : 'GET'
          params            : params
          transformResponse : solicitacaoTransformResponse

      getCobrancas: (page, size, search) ->
        params        = pagination(page, size, search)
        $http
          url               : APP_BASE_URL + 'solicitacoes/cobranca'
          method            : 'GET'
          params            : params
          transformResponse : solicitacaoTransformResponse

      get: (id) ->
        $http
          url               : APP_BASE_URL + "solicitacoes/#{id}"
          method            : 'GET'
          transformResponse : solicitacaoTransformResponse

      getValorCobrancaPessoal: (id) ->
        $http
          url               : APP_BASE_URL + "solicitacoes/#{id}/valor-pessoal"
          method            : 'GET'

      create: (data) ->
        $http
          url              : APP_BASE_URL + 'solicitacoes'
          method           : 'POST'
          data             : data
          transformRequest : solicitacaoTransformRequest

      delete: (id) ->
        $http
          url    : APP_BASE_URL + "solicitacoes/#{id}"
          method : 'DELETE'

      approve: (ids) ->
        data =
          ids    : ids
          status : 'APROVADO'

        $http
          url    : APP_BASE_URL + "solicitacoes/status"
          method : 'PUT'
          data   : data

      disapprove: (ids) ->
        data =
          ids    : ids
          status : 'REPROVADO'

        $http
          url    : APP_BASE_URL + "solicitacoes/status"
          method : 'PUT'
          data   : data 

      cobrarSESC: (ids) ->
        data =
          ids: ids
          cobrar: 'APROVADO'

        $http
          url               : APP_BASE_URL + 'solicitacoes/cobranca'
          method            : 'PUT'
          data              : data

      cobrarFuncionario: (ids, mensagem, valorCobrado) ->
        data =
          ids: ids
          cobrar: 'REPROVADO'
          mensagem: mensagem
          valorCobrado: valorCobrado

        $http
          url               : APP_BASE_URL + 'solicitacoes/cobranca'
          method            : 'PUT'
          data              : data
    }