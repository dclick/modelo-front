'use strict'

angular.module('guideline.gestorAcesso', ['guideline.gestorAcesso.template'])

.directive('gestorAcesso', ['$cookies', '$templateCache', ($cookies, $templateCache)->
    restrict    : 'A'
    templateUrl : 'guideline/gestor-acesso/gestor-acesso.html'
    scope       :
      itemLabel : "@"
      usuario   : "="
    link: (scope, element, attrs)->
      hasPermission   = _.contains scope.usuario.authorities, "ROLE_COMPONENTE.PERMISSAO"

      if hasPermission
        element.one 'click', (e)->
          do e.preventDefault

          if config.APP_BASE_URL_GESTOR_ACESSO
              url = config.APP_BASE_URL_GESTOR_ACESSO
          else
              url = "#{window.location.protocol}//#{window.location.host.replace("javadev7", "javadev")}/permissao"

          url += "/component.jsp?hash=#{$cookies.hash}&opc_codigo=#{$cookies.opc_codigo}&permissao=ROLE_COMPONENTE.PERMISSAO"

          angular.element('#gestor-acesso-modal')
            .find('iframe')
              .attr('src', url)
              .end()
          
        element.on 'click', (e)->
          $('#gestor-acesso-modal').modal 'show'

        angular.element('body').append $templateCache.get "guideline/gestor-acesso/gestor-acesso-modal.html"
      else
        do element.hide

  ])

       
