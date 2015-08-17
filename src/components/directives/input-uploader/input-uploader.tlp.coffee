'use strict'

angular.module "modeloBase"

  .run [
    '$templateCache'
    ($templateCache)->
      $templateCache.put 'input-uploader/input-uploader.html',
        """
        <div class="input-group">
          <input type="text" class="form-control" readonly>
          <span class="input-group-btn">
              <span class="btn btn-file">
                  Procurar&hellip; <input type="file" name="uploader" accept="{{fileAccepted}}">
              </span>
          </span>
        </div>
        """
  ]