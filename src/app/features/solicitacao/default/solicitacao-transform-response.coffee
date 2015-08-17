angular.module "modeloBase"
  .service "solicitacaoTransformResponse", () ->
    (response) ->
      response = JSON.parse response
      if response.content
        for item in response.content
          item.dataAgendamento = moment(item.dataAgendamento, 'YYYY/MM/DD').format('DD/MM/YYYY') if item.dataAgendamento
      else
        response.dataAgendamento = moment(response.dataAgendamento, 'YYYY/MM/DD').format('DD/MM/YYYY') if response.dataAgendamento

      return response