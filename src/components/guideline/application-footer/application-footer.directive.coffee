'use strict'

angular.module('guideline.application-footer.template', [])

.run [
  '$templateCache'
  ($templateCache)->
    $templateCache.put "guideline/application-footer/application-footer.html",
      """
      <footer class="footer">
        <div class="container">
            <p>© Guideline 2.2.0</p>
        </div>
      </footer>
      """

    return

]

