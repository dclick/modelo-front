'use strict'

angular.module "sescMotoFrete"

  .run [
    '$templateCache'
    ($templateCache)->
      $templateCache.put 'request-loader/request-loader.html',
        """
        <div class="request-loader"><span us-spinner="{lines:9, radius:6, width:3, length: 6, trail: 40}"></span></div>
        """
  ]

