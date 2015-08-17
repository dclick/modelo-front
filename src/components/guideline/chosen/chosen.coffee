'use strict'

###*
 # @ngdoc directive
 # @name sgdlApp.directive:Datatables
 # @description
 # # Datatables
###
angular.module('guideline.chosen', ['guideline.chosen.template'])

.directive('chosenItem', [()->
    restrict: 'A'
    require: '^guidelineChosen'
    terminal: true
    link: (scope, element, attrs, controller)->
      populateObjectModel = ->
        if not _.isEmpty controller.scope.ngModel.$modelValue
          if scope.campo[controller.scope.options.indexValue] is controller.scope.ngModel.$modelValue[controller.scope.options.indexValue]
            controller.scope.selectedValue = scope.campo[controller.scope.options.indexValue]

      populateArrayModel = ->
        if controller.scope.ngModel.$modelValue
          if controller.scope.ngModel.$modelValue.length > 0
            obj = []
            for value in controller.scope.ngModel.$modelValue
              if scope.campo[controller.scope.options.indexValue] is value[controller.scope.options.indexValue]
                obj.push scope.campo[controller.scope.options.indexValue]
            controller.scope.selectedValue = obj


      element.val(scope.campo[controller.scope.options.indexValue])

      if angular.isArray controller.scope.options.indexName
        indexName = []
        for i in controller.scope.options.indexName
          indexName.push scope.campo[i]

        indexName = indexName.join(' - ')
        element.html(indexName)
      else
        element.html(scope.campo[controller.scope.options.indexName])

      if controller.scope.isMultiple
        do populateArrayModel
      else
        do populateObjectModel

#     check if is the last row at the chosen item and execute render
      if scope.$last

        do controller.scope.render
        if controller.scope.selectedValue
          do controller.scope.updateList
        return

      return
  ])


.directive('guidelineChosen', ['$timeout', ($timeout)->
    templateUrl: 'guideline/chosen/chosen.html'
    controller: ($scope)->
      this.scope = $scope
      return
    restrict: 'EA'
    require: "ngModel"
    scope:
      guidelineChosen: '='
      options: '='

    link: (scope, element, attrs, ngModel) ->

      if attrs.multiple
        scope.isMultiple = true
        scope.modelValue = undefined
      else
        scope.isMultiple = false

      scope.ngModel = ngModel

      #     initial element vars
      $chosen = undefined
      $listeners = undefined
      $modelValue = undefined

      scope.$watch 'guidelineChosen', (newVal)->
        if newVal and $chosen
          $timeout () ->
            $($chosen).trigger "liszt:updated"

      setConfig = ()->
        defaultConfig = {
          no_results_text: 'Nenhum resultado encontrado'
        }
        _.defaults defaultConfig, scope.options?.config
        defaultConfig

      setArrayModelValue = (values)->
        obj = {}
        modelValue = []
        console.log getSelected()
        if values
          for selected in values
            if !isNaN selected.valueOf()
              obj[scope.options.indexValue] = parseInt selected.valueOf()
            else
              obj[scope.options.indexValue] = selected.valueOf()
            modelValue.push _.findWhere scope.guidelineChosen, obj
#            ngModel.$setViewValue modelValue
        else
#          ngModel.$setViewValue []
        return


      setObjectModelValue = (value)->
        obj = {}
        if value
          modelValue = {}
          if !isNaN value.selected.valueOf()
            obj[scope.options.indexValue] = parseInt value.selected.valueOf()
          else
            obj[scope.options.indexValue] = value.selected.valueOf()

          modelValue = _.findWhere scope.guidelineChosen, obj
          setObjectValue modelValue


      setObjectValue = (modelValue)->
        ngModel.$setViewValue modelValue

      setListeners = ->
        updateModel = (ev, value)->
          if attrs.multiple
          else
            setObjectModelValue value
          return

        if !$listeners
          $($chosen).chosen().change updateModel

          $listeners = true

      init = ->
        config = do setConfig

        if !$chosen
          $chosen = $(element).chosen config

        do setListeners

      cleanup = ->
        $chosen = undefined
        scope.selectedValue = null
        scope.modelValue = null
        scope.ngModel.$modelValue = undefined
        scope.ngModel.$setViewValue {}
        $($chosen).val(null).trigger "liszt:updated"
        return


      scope.render = -> do init

      scope.updateList = ->
        if attrs.multiple
          obj = []
          for value in scope.ngModel.$modelValue
            obj.push value[scope.options.indexValue]
        else
          $($chosen).val(scope.selectedValue).trigger "liszt:updated"
        return

      # Watch the disabled attribute (could be set by ngDisabled)
      attrs.$observe 'disabled', -> $($chosen).trigger 'liszt:updated' if $chosen

      scope.$on '$destroy', -> do cleanup




      return
  ])
