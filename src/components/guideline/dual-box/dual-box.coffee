'use strict'

###*
 # @ngdoc directive
 # @name guideline.dual-box:Dual-Box
 # @description
 # # DualBox
###
angular.module('guideline.dual-box', ['guideline.dual-box.template'])

.directive('dualBox', [ '$filter', ($filter)->
    templateUrl: 'guideline/dual-box/dual-box.html'
    restrict: 'EA'
    replace: true
    scope:
      options: '='
      dualBox: '='
      title: '@'
    link: (scope, element, attrs)->

      $listeners = false

      scope.leftAllChecked      = false
      scope.rightAllChecked     = false

      setElementWidth = (width, height)->
        scope.element =
          width: width
          height: height
        return

      setListeners = ->
        if !$listeners
          $(window).on 'resize', ->
            scope.$apply ->
              setElementWidth $(window).width(), $(window).height()
          $listeners = true

      sendTo = (side)->
        if side is 'left'
          if scope.dualBox?.rightList
            list = _.where scope.dualBox.rightList, {checked: true}
            for item in list
              index = _.indexOf scope.dualBox.rightList, item
              item.checked = false
              scope.dualBox.leftList.push item
              scope.dualBox.rightList.splice index, 1
        if side is 'right'
          if scope.dualBox?.leftList
            list =_.where scope.dualBox.leftList, {checked: true}
            for item in list
              index = _.indexOf scope.dualBox.leftList, item
              item.checked = false
              scope.dualBox.rightList.push item
              scope.dualBox.leftList.splice index, 1

        scope.leftAllChecked = false
        scope.rightAllChecked = false
        return

      getFiltered = (side)->
        return $filter('filter')(scope.dualBox.leftList, scope.searchLeft) if side is 'left' and scope.dualBox?.leftList
        return $filter('filter')(scope.dualBox.rightList, scope.searchRight) if side is 'right' and scope.dualBox?.rightList
        []

      scope.$watch 'searchLeft', (newVal)->
        if newVal
          scope.leftAllChecked = false

      scope.$watch 'searchRight', (newVal)->
        if newVal
          scope.rightAllChecked = false

      scope.toLeft = ->
        sendTo 'left'

      scope.toRight = ->
        sendTo 'right'

      scope.selectAll = (side)->
        for item in getFiltered side
          item.checked = !scope[side + 'AllChecked']

      scope.init = ->
        do setListeners
        setElementWidth $(window).width(), $(window).height()

      do scope.init

])
