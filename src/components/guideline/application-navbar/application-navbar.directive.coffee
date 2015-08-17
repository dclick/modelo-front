'use strict'


angular.module "guideline.application-navbar", ['guideline.application-navbar.template']
  .directive "applicationNavbar", ($rootScope, $window, $state, $timeout, NotificationCenterService) ->
    restrict : 'A'
    replace  : yes
    scope    :
      applicationName : '@'

    templateUrl : 'guideline/application-navbar/application-navbar.html'

    link : (scope, elem, attr) ->
      scope.user = $rootScope.user

      ##################################
      ## Attributes
      ##################################
      scope.state     = $state
      scope.menuItems = [
        {parentState: 'solicitacao', state: 'solicitacao.listar', name: 'Solicitação', authorities: 'ROLE_MENU.SOLICITACAO'}
      ]

      scope.GetNotificationService = NotificationCenterService.getUserNotifications
      scope.ReadNotificationService = NotificationCenterService.readNotifications

      ##################################
      ## Methods
      ##################################
      scope.closeApplication = ->
        $window.close() if confirm('Deseja sair da aplicação?')