angular.module "sescMotoFrete"
  .service "PermissaoService", ($rootScope) ->

    return {

      validaPermissoes: (permissoes) ->
        valido            = 0
        permissoesUsuario = $rootScope.user.authorities
        permissoes        = permissoes.match(/[^,\s]+/g) if permissoes # Regex: Tudo menos espaço e vírgula
        deveTer           = permissoes.map((i) -> return i if i and i.charAt(0) isnt '!').filter(Boolean)
        naoDeveTer        = permissoes.map((i) -> return i.substr(1) if i and i.charAt(0) is '!').filter(Boolean)

        for permissao in permissoesUsuario
          if deveTer.indexOf(permissao) > -1
            valido = valido || true
          else
            valido = valido || false

        for permissao in permissoesUsuario
          if naoDeveTer.indexOf(permissao) > -1 then valido = false

        return valido

    }

