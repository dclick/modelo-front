'use strict'

###*
 # @ngdoc directive
 # @name guideline.notification-center.template:NotificationCenterTemplate
 # @description
 # # NotificationCenter
###
angular.module('guideline.notification-center.template', [])

.run [
  '$templateCache'
  ($templateCache)->
    # <a ui-sref="{{notificationState || ""}}" class="all-notifications">Central de notificações</a>
    $templateCache.put "guideline/notification-center/notification-center.html",
    """
      <li class="notification-center dropdown" dropdown on-toggle="toggled(open)">
          <a href class="notification-toggle dropdown-toggle" dropdown-toggle>
            <i class="icon-white icon-inbox"></i>
            <span class="notification-counter" ng-bind="notificationCount" ng-if="notificationCount"></span>
            <b class="caret"></b>
          </a>

          <div class="notifications-menu dropdown-menu">
            <div class="header">

              <span class="header-title">Notificações</span>
            </div>
            <div class="notifications">
              <a class="notification"
              ng-class="{'notification-unread': notification.unread == true}" ng-repeat="notification in notifications track by $index">
                <div class="notification-block">
                  <small class="notification-date" ng-bind="notification.data"></small>
                  <h6 class="notification-title" ng-bind="notification.title"></h6>
                  <p class="notification-text" ng-bind="notification.text"></p>
                </div>
              </a>
              <div class="notification-block-empty" ng-if="notifications.length == 0">
                Nenhuma notificação.
              </div>
            </div>
          </div>
        </li>
    """

    return

]
# <a ui-sref="{{notification.linkUrl || ""}}" class="notification"