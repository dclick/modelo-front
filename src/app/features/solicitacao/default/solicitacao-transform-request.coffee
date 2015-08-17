angular.module "sescMotoFrete"
  .service "solicitacaoTransformRequest", () ->
    (request) ->
      request                 = angular.copy(request)
      request.dataAgendamento = moment(request.dataAgendamento, 'DD/MM/YYYY').format('YYYY/MM/DD') if request.dataAgendamento
      request                 = JSON.stringify request
      return request