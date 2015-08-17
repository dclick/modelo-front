angular.module "sescMotoFrete"
  .run ($rootScope, $state, $stateParams) ->
    $rootScope.$state       = $state
    $rootScope.$stateParams = $stateParams

    $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams) ->
      console.log '$stateChangeError - fired when an error occurs during transition.'
      console.log arguments

    $rootScope.$on '$stateNotFound', (event, unfoundState, fromState, fromParams) ->
      console.log '$stateNotFound #{unfoundState.to} fired when a state cannot be found by its name.'
      console.log unfoundState, fromState, fromParams