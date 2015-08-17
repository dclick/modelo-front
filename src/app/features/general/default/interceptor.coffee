angular.module "sescMotoFrete"
  .config ($httpProvider, $provide) ->

    # =============================================
    # Interceptor
    # =============================================
    $provide.factory 'AppInterceptor', ($q, $injector, $rootScope, $timeout, $translate, $window, $noty, $filter, APP_USER_NOT_AUTH_REDIRECT) ->

      ####################
      # Attributes
      ####################
      requestCount      = 0
      messageDivider    = '::'
      unhandledRequests = [
        'notificacoes'
      ]

      ####################
      # Methods
      ####################

      verifyRequest = (url) ->
        for request in unhandledRequests
          if url.indexOf(request) isnt -1
            return false
          else
            return true

      addLoader = () ->
        $rootScope.$broadcast 'requestLoader:show'
        $rootScope.loading = yes

      removeLoader = () ->
        unless --requestCount
          $rootScope.$broadcast 'requestLoader:hide'
          $rootScope.loading = no

      return {

        'request': (config) ->
          if verifyRequest(config.url)
            addLoader()
            requestCount++
          return config

        'requestError': (rejection) ->
          removeLoader() if verifyRequest(rejection.config.url)
          return $q.reject rejection

        'response': (response)->
          removeLoader() if verifyRequest(response.config.url)
          return response or $q.when response

        'responseError': (rejection) ->
          removeLoader() if verifyRequest(rejection.config.url)
          switch rejection.status
            when 0
              if !rejection.config.timeout
                $noty.error $translate.instant "exception.#{rejection.data.message}"
            when 401
              $injector.invoke ['$state', '$rootScope', ($state, $rootScope) ->
                if $state.current.data.restrict
                  $rootScope.user = null
                  if APP_USER_NOT_AUTH_REDIRECT.match(/http:\/\//g)
                    $window.location.href = APP_USER_NOT_AUTH_REDIRECT
                  else
                    $state.go APP_USER_NOT_AUTH_REDIRECT
              ]
            else
              if rejection.data.message
                message = if rejection.data.message.indexOf(messageDivider) isnt -1
                  splittedMessage = rejection.data.message.split(messageDivider)
                  "#{$translate.instant(splittedMessage[0])}#{$filter('idFilter')(splittedMessage[1])}"
                  # Sempre espera que após o divider venha um ID
                else
                  $translate.instant(rejection.data.message)
                $noty.error message
              else
                $noty.error 'Ocorreu um erro. Contate o administrador do sistema.'

          return  $q.reject rejection

        }

    ####################
    # Register Interceptor
    ####################
    $httpProvider.interceptors.push 'AppInterceptor'