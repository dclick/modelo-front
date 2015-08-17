'use strict'

###*
 # @ngdoc directive
 # @name guideline.datatables.template:DatatablesTemplate
 # @description
 # # Datatables
###
angular.module('guideline.datatables.template', [])

.run [
  '$templateCache'
  ($templateCache)->
    $templateCache.put "guideline/datatables/table.html",
      """
      <table ng-transclude>
      </table>
      """

    $templateCache.put "guideline/datatables/actions-button.html",
      """
      <div class="actions btn-group">
        <button class="btn btn-danger delete-action" title="Excluir">
          <i class="icon-trash icon-white"></i>
        </button>
        <!--<button class="btn btn-secondary edit-action" title="Editar">
          <i class="icon-pencil icon-white"></i>
        </button>
        <button class="btn btn-secondary inspect-action" title="Visualizar">
          <i class="icon-search icon-white"></i>
        </button>-->
      </div>
      """

    return

]
