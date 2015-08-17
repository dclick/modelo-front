'use strict'

angular.module('guideline.application-navbar.template', [])

.run [
  '$templateCache'
  ($templateCache)->
    $templateCache.put "guideline/application-navbar/application-navbar.html",
      """
      <div id="sesc-application-navbar">
        <div class="intrasesc-nav">
          <div class="intrasesc-nav-inner">
            <img src="assets/images/intrasesc-logo.png">
          </div>
        </div>
        <div class="application-navbar navbar" data-spy="affix" data-offset-top="90">
          <div class="navbar-inner">
            <div class="container">

              <!-- Hamburguer menu -->
              <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </a>

              <!-- Nome da aplicação -->
              <a class="brand" ui-sref="home">
                <span ng-bind="applicationName"></span>
                <small>Página inicial</small>
              </a>

              <!-- Usuário -->
              <ul class="nav pull-right">
                <li class="dropdown">
                  <a class="dropdown-toggle notifications-toggle" data-toggle="dropdown">
                    <i class="icon-white icon-user"></i>
                      <span ng-bind="user.name || ''" ></span>
                    <b class="caret"></b>
                  </a>
                  <ul class="dropdown-menu">
                    <li gestor-acesso item-label="Permissões de acesso" usuario="user"></li>
                    <li>
                      <!-- <a data-action="close-application">Sair</a> -->
                      <a ng-click="closeApplication()">Sair</a>
                    </li>
                  </ul>
                </li>
              </ul>

              <!-- Notificação -->
              <ul class="nav pull-right">
                <li notification-center get-service="GetNotificationService" read-service="ReadNotificationService" interval="10000"></li>
              </ul>

              <!-- Menu -->
              <div class="nav-collapse collapse">
                <ul class="nav">
                  <li ng-repeat="menuItem in menuItems" ng-class="{
                    active   : state.$current.parent.self.name === menuItem.parentState || state.$current.self.name === menuItem.parentState,
                    dropdown : menuItem.length !== undefined
                  }">

                    <a ng-if="menuItem.length > 0" class="dropdown-toggle" data-toggle="dropdown" permissoes="{{menuItem[0].authorities}}">
                      {{menuItem[0].name}} <b class="caret"></b>
                    </a>

                    <ul ng-if="menuItem.length > 0" class="dropdown-menu" permissoes="{{menuItem[0].authorities}}">
                      <li ng-repeat="subMenu in menuItem[0].items" permissoes="{{subMenu.authorities}}">
                        <a ui-sref="{{subMenu.state}}">
                          <span ng-bind="subMenu.name"></span>
                        </a>
                      </li>
                    </ul>

                    <a ng-if="!menuItem.length" ui-sref="{{menuItem.state}}" permissoes="{{menuItem.authorities}}">
                      <span ng-bind="menuItem.name"></span>
                    </a>

                  </li>
                </ul>
              </div>

            </div>
          </div>
        </div>
      </div>
      """

    return

]

