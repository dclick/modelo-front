'use strict'

angular.module('guideline.breadcrumbs', ['guideline.breadcrumbs.template'])

.directive('guidelineBreadcrumbs', ['$timeout', '$state', ($timeout, $state)->
    templateUrl : 'guideline/breadcrumbs/breadcrumbs.html'
    controller  : ($scope)->
      this.scope = $scope
      return
    replace     : yes
    restrict    : 'EA'
    scope       : {}

    link: (scope, element, attrs) ->
      ##################################
      ## Attributes
      ##################################
      scope.states = []

      ##################################
      ## Methods
      ##################################
      scope.copyState = (state, active) ->
        stateCopy =
          abstract : state.abstract
          name     : state.data.breadcrumb?.displayName
          state    : if state.data.breadcrumb?.linkTo then state.data.breadcrumb.linkTo else state.name
          active   : (() ->
            if state.data.breadcrumb?.linkTo is $state.$current.self.name
              return yes
            else if !state.data.breadcrumb?.linkTo
              return yes
            else
              return no
          )()

      scope.addBefore = (breadcrumb) ->
        stateCopy =
          abstract : yes
          name     : breadcrumb.before
          state    : breadcrumb.linkTo
          active   : yes

      scope.createStateSequence = ->
        stateParent = $state.$current.parent

        while stateParent
          scope.states.push scope.copyState stateParent.self if stateParent.parent
          scope.states.push scope.addBefore stateParent.self.data.breadcrumb if stateParent.parent and stateParent.self.data.breadcrumb?.before?
          stateParent = stateParent['parent']

        scope.states = scope.states.reverse()
        scope.states.push scope.copyState $state.$current.self, yes

        return scope.states

      ##################################
      ## Init
      ##################################
      $timeout ->
        scope.createStateSequence()
        return

      return
  ])
