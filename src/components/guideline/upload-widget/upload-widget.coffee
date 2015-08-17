'use strict'

###*
 # @ngdoc directive
 # @name sgdlApp.directive:UploadBox
 # @description
 # # UploadBox
###
angular.module('guideline.uploadBox', ['guideline.uploadBox.template'])

.filter("MimeType", [()->
    (input) ->
      switch input
        when "image/png"
          input = ".png"
        when "image/jpeg" or "image/jpg"
          input = ".jpg"
        when "image/pdf"
          input = ".pdf"
      input
])

.directive('uploadBox', [()->
    restrict: "EA"
    templateUrl: "guideline/uploadbox/template.html"
    replace: true
    scope:
      title: "="
      type: "@type"
      required: "@required"
      uploadCallback: "="
      uploadedFile: "=uploadedFile"
      progressTransfer: "="
      fileUrl: "="
      accept: "@"

    controller: [
      "$q"
      ($q) ->
        @readFile = (file) ->
          defer = $q.defer()
          reader = new FileReader()
          reader.onload = (event) ->
            defer.resolve event.target.result
            return

          reader.readAsDataURL file
          defer.promise
        return
    ]
    link: (scope, element, attrs, controller) ->

      $dropzone = $(".upload-dropzone", element)
#     $preview = $(".upload-preview", element)
      $inputFile = $("input[type=\"file\"]", element)

      scope.$watch 'progressTransfer', (newVal)->
        if newVal > 0 and newVal < 100
          scope.progressActive = true

        if newVal is 100
          scope.progressActive = false



      $dropzone.bind "dragover", (event) ->
        event.stopPropagation()
        event.preventDefault()
        false

      ###$dropzone.bind "drop", (event) ->
        event.preventDefault()
        event.stopPropagation()
        controller.readFile(event.originalEvent.dataTransfer.files[0]).then (result) ->
          scope.selected = true
          scope.uploadCallback event.originalEvent.dataTransfer.files[0], scope.type  if scope.uploadCallback
#         $preview.css "background-image", "url(" + result + ")"
          return###

      $inputFile.bind "change", (event) ->
        controller.readFile(event.target.files[0]).then (result) ->
          scope.selected = true
          scope.uploadCallback event.target.files[0], scope.type  if scope.uploadCallback
#         $preview.css "background-image", "url(" + result + ")"
          return

        return

      return
])
