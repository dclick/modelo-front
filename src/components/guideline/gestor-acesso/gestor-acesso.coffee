angular.module("guideline.gestorAcesso", [ "guideline.gestorAcesso.template" ]).directive "gestorAcesso", [ "$cookies", "$templateCache", ($cookies, $templateCache) ->
  restrict: "A"
  templateUrl: "guideline/gestor-acesso/gestor-acesso.html"
  scope:
    itemLabel: "@"
    usuario: "="

  link: (scope, element) ->
    urlParam = ->
      
      # This function is anonymous, is executed immediately and 
      # the return value is assigned to urlParam!
      query_string = {}
      query = window.location.search.substring(1)
      vars = query.split("&")
      i = 0

      while i < vars.length
        pair = vars[i].split("=")
        
        # If first entry with this name
        if typeof query_string[pair[0]] is "undefined"
          query_string[pair[0]] = decodeURIComponent(pair[1])
        
        # If second entry with this name
        else if typeof query_string[pair[0]] is "string"
          arr = [ query_string[pair[0]], decodeURIComponent(pair[1]) ]
          query_string[pair[0]] = arr
        
        # If third or later entry with this name
        else
          query_string[pair[0]].push decodeURIComponent(pair[1])
        i++
      query_string
    
    $(window).on "hashchange", ->
      $("#gestor-acesso-modal").modal "hide"

    hasPermission = undefined
    
    hasPermission = _.contains scope.usuario.authorities, "ROLE_COMPONENTE.PERMISSAO"
    if hasPermission
      element.one "click", (e) ->
        url = undefined
        e.preventDefault()
        if config.APP_BASE_URL_GESTOR_ACESSO
          url = config.APP_BASE_URL_GESTOR_ACESSO
        else
          url = window.location.protocol + "//" + (window.location.host.replace("javadev7", "javadev")) + "/permissao"
        url += "/component.jsp?hash=" + urlParam().hash + "&opc_codigo=" + urlParam().opc_codigo + "&permissao=ROLE_COMPONENTE.PERMISSAO"
        angular.element("#gestor-acesso-modal").find("iframe").attr("src", url).end()

      element.on "click", ->
        $("#gestor-acesso-modal").modal "show"

      angular.element("body").append $templateCache.get("guideline/gestor-acesso/gestor-acesso-modal.html")
    else
      element.hide()
 ]