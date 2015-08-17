angular.module "modeloBase"
  .factory 'NotificacaoConstructor', () ->
    obj = {}

    return {
      create: (params)->
        obj.nome           = params.nome or null
        if params.notificacoes?.length > 0
          obj.notificacoes = params.notificacoes
        JSON.stringify obj

      update: (params)->
        obj.nome           = params.nome or null
        if params.notificacoes?.length > 0
          obj.notificacoes = params.notificacoes
        JSON.stringify obj

      setNotificacao: (params, list)->
        if params.id
          obj.id          = params.id
        obj.dias          = params.dias
        obj.isBefore      = if params.isBefore is "true" then true else false
        obj.perfis        = @clearPerfis list
        obj.mensagem     = params.mensagem
        obj

      sendRead: (params)->
        obj.ids = params
        JSON.stringify obj

      clearPerfis: (list)->
        for item in list
          delete item.checked
        list
    }