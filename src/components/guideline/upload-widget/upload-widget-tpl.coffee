'use strict'

###*
 # @ngdoc directive
 # @name guideline.uploadBox.template:UploadBoxTemplate
 # @description
 # # Datatables
###
angular.module('guideline.uploadBox.template', [])

.run [
  '$templateCache'
  ($templateCache)->

    $templateCache.put "guideline/uploadbox/template.html",
      """
      <div class="upload-box">
        <div class="upload" ng-class="{ required: required == 1  && selected == false}">
          <div class="upload-dropzone">
            <div class="top-menu">
              <div class="upload-fileinput">
                <div class="upload-field">
                  <input type="file" accept="{{accept}}"/>
                </div>
                <div ng-show="progressActive">
                  <div progressbar value="progressTransfer" type="success"><b>{{progressTransfer}}%</b></div>
                </div>
              </div>
            </div>
            <div class="upload-preview" ng-if="fileUrl != undefined">
              <img ng-src="{{fileUrl}}" />
            </div>
          </div>
          <div class="upload-meta">
            <span class="label label-default"
                  ng-bind="title">
            </span>
          </div>
        </div>
      </div>
      """

    return

]
