'use strict'

###*
 # @ngdoc directive
 # @name guideline.notification-center:NotificationCenter
 # @description
 # # NotificationCenter
###
angular.module('guideline.notification-center', ['guideline.notification-center.template'])

.factory "NotificationCenterConstructor", ["$filter", ($filter)->

  setNotificacaoTitle = (tipo)->
    if tipo is 'OCORRENCIA'
      return 'Ocorrência'
    if tipo is 'ALERTA'
      return 'Alerta'

  {
    setNotificacao: (params)->
      obj = {}
      obj.id                = params.id or null
      obj.data              = moment(params.data).calendar() or null
      obj.dataTimestamp     = params.data or null
      obj.usuarioId         = params.usuarioId or null
      obj.documentoId       = params.documentoId or null
      obj.title             = setNotificacaoTitle params.tipo or null
      obj.text              = params.texto or null
      obj.tipo              = params.tipo or null
      obj.unread            = true
      obj

    createNotificacoes: (list)->
      newList = []
      for item in list
        newList.push @setNotificacao item
      newList
  }

]

.controller "NotificationCenterController", ['$scope', '$timeout', '$interval', 'NotificationCenterConstructor',
  ($scope, $timeout, $interval, NotificationCenterConstructor)->


    getNotificationIds = ->
      _.pluck $scope.notifications, 'id'

    getUnreadNotificationIds = ->
      _.pluck(_.where($scope.notifications, {unread: true}), 'id')

    $scope.markAllAsRead = ->
      for notification in _.where($scope.notifications, {unread: true})
        notification.unread = false


    $scope.fetchData = ->
      if angular.isDefined $scope.getService
        $scope.getService().then (result)->
          if result.data.length > 0
            $scope.updateUnreadNotifications NotificationCenterConstructor.createNotificacoes result.data
            if $scope.toggleNotification is true
              do $scope.sendReadNotifications
          return

      return

    $scope.updateUnreadNotifications = (notifications)->
      for notification in notifications
        $scope.notifications.unshift notification if !_.findWhere $scope.notifications, {id: notification.id}
      $scope.notificationCount = getUnreadNotificationIds().length
      $scope.$emit "notificationUpdate", $scope.notificationCount

    $scope.sendReadNotifications = ()->

      successFn = ()->
        do $scope.markAllAsRead
        $scope.updateUnreadNotifications $scope.notifications
        return

      if (angular.isDefined $scope.readService) and ($scope.toggleNotification is true)
        $scope.readService(getUnreadNotificationIds()).then successFn if getUnreadNotificationIds().length > 0
        if $scope.canceled is true
          do $scope.startUpdate

    $scope.stopUpdateNotification = ->
      $scope.canceled = $interval.cancel $scope.updateInterval if angular.isDefined $scope.updateInterval
      $timeout ->
        do $scope.sendReadNotifications
      , parseInt ($scope.readInterval) || 1500
      return

    $scope.startUpdate = ->
      $scope.canceled = false
      $scope.updateInterval = $interval $scope.fetchData, parseInt ($scope.interval) || 10000
      return


    $scope.notifications = []

    return
]

.directive "notificationCenter", [ '$timeout','$interval',($timeout, $interval)->
  {
    restrict: 'EA'
    templateUrl: 'guideline/notification-center/notification-center.html'
    replace: true
    transclude: true
    controller: 'NotificationCenterController'
    scope:
      getService: '='
      readService: '='
      interval: '@'
      readInterval: '@'
    link: (scope, element, attrs, controller)->
      do scope.startUpdate

      scope.$parent.$on '$destroy', () ->
        $interval.cancel scope.updateInterval

      scope.toggled = (status)->
        scope.toggleNotification = status
        if status is true
          do scope.stopUpdateNotification
      return

  }
]
