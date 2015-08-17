'use strict'

angular.module "sescMotoFrete"

  .directive "inputUploader", () ->
    restrict    : 'A'
    scope       :
      fileAccepted   : '@'
      uploadCallback : "="
    templateUrl : 'input-uploader/input-uploader.html'

    link : (scope, elem, attr) ->

      ##################################
      ## Attributes
      ##################################


      ##################################
      ## Watchers
      ##################################

      ##################################
      ## Methods
      ##################################


      ##################################
      ## Init
      ##################################
      elem.on 'change', '.btn-file :file', (e) ->
        input           = $(this)

        if input.get(0).files[0].type is scope.fileAccepted
          filesForUpload        = (if input.get(0).files then input.get(0).files.length else 1)
          label                 = input.val().replace(/\\/g, "/").replace(/.*\//, "")
          inputFileUploadName   = $(this).parents(".input-group").find(":text")
          inputFileUploadName.val label
          scope.uploadCallback input.get(0).files[0] if scope.uploadCallback
