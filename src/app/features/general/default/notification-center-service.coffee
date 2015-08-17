angular.module "sescMotoFrete"
  .service "NotificationCenterService", ($q, $http, APP_BASE_URL, NotificacaoConstructor) ->
    return {
      getById: (id)->
        $http.get APP_BASE_URL + "notificacao/#{id}"

      getUserNotifications: ()->
        $http.get APP_BASE_URL + "notificacoes/naolidas", {isNotification: true}

      readNotifications: (params)->
        $http
          url                : APP_BASE_URL + "notificacoes/notificarleitura"
          method             : "POST"
          data               : params
          traditional        : true
          transformRequest : NotificacaoConstructor.sendRead
          headers            :
            "Content-Type": "application/json"

      sendNotification: (data) ->
        $http
          url    : APP_BASE_URL + 'notificacoes/solicitacao'
          method : 'POST'
          data   : data
    }
