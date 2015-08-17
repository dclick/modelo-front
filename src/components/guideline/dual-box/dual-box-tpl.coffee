'use strict'

###*
 # @ngdoc directive
 # @name guideline.dual-box.template:DualBoxTemplate
 # @description
 # # DualBox
###
angular.module('guideline.dual-box.template', [])

.run [
  '$templateCache'
  ($templateCache)->
    $templateCache.put "guideline/dual-box/dual-box.html",
    """
      <div class="dual-box-container">
        <div class="row">
          <div class="span5 left-list">
            <div class="box">
              <div class="heading">
                <div class="search">
                  Buscar: <input type="text" ng-model="searchLeft" placeholder="Digite para filtrar" class="input-block-level"/>
                </div>
                <div class="select-all">
                  <ul>
                    <li>
                      <label>
                        <input type="checkbox" ng-model="leftAllChecked" ng-checked="leftAllChecked" ng-click="selectAll('left')"/> Selecionar todos
                      </label>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="body">
                <div class="list-wrapper" ng-style="{height: options.height}">
                  <ul>
                    <li ng-repeat="row in dualBox.leftList | filter: searchLeft track by $index">
                      <label>
                        <input type="checkbox" ng-checked="row.checked"  ng-model="row.checked" />
                        <span ng-show="row[options.documentIdentifier]">{{row[options.documentIdentifier]}}  -</span> {{row[options.indexName]}}
                      </label>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          <div class="span2">
            <div class="button-actions">
              <div class="row">
                <div class="span2">
                  <button class="btn btn-default to-left" ng-click="toLeft()">
                    <i class="icon" ng-class="{'icon-chevron-left' : element.width > 760, 'icon-chevron-up' : element.width < 760}"></i>
                  </button>
                </div>
                <div class="span2">
                  <button class="btn btn-default to-right" ng-click="toRight()">
                    <i class="icon"  ng-class="{'icon-chevron-right' : element.width > 760, 'icon-chevron-down' : element.width < 760}"></i>
                  </button>
                </div>
              </div>
              <div class="row">
              </div>
            </div>
          </div>
          <div class="span5 right-list">
            <div class="box">
              <div class="heading">
                <div class="title">
                  <h2>
                    <span class="icon icon-chevron-left back-button"></span>
                    {{title}}
                  </h2>
                </div>
                <div class="search">
                  Buscar: <input type="text" ng-model="searchRight" placeholder="Digite para filtrar" class="input-block-level"/>
                </div>
                <div class="select-all">
                  <ul>
                    <li>
                      <label>
                        <input type="checkbox" ng-model="rightAllChecked" ng-checked="rightAllChecked" ng-click="selectAll('right')"/>
                        Selecionar todos
                      </label>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="body">
                <div class="list-wrapper" ng-style="{height: options.height}">
                  <ul>
                    <li ng-repeat="row in dualBox.rightList | filter: searchRight track by $index">
                      <label>
                        <input type="checkbox" ng-checked="row.checked" ng-model="row.checked" />
                        <span ng-show="row[options.documentIdentifier]">{{row[options.documentIdentifier]}}  -</span> {{row[options.indexName]}}
                      </label>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    """

    return

]
