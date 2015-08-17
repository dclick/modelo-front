'use strict'

angular.module('guideline.gestorAcesso.template', [])

.run [
	'$templateCache'
	($templateCache)->
		$templateCache.put "guideline/gestor-acesso/gestor-acesso.html",
		  """
			<a class="link-permissions">{{itemLabel}}</a>
		  """

		$templateCache.put "guideline/gestor-acesso/gestor-acesso-modal.html",
		  """
			<div id="gestor-acesso-modal" style="z-index: 10001 !important;" class="modal modal-permission hide">
				<div class="modal-header">
				  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				  <h3>Permissões de acesso</h3>
				</div>
				<div class="modal-body" style="max-height: 505px">
				  <iframe width="100%" height="500px" style="border: 0; margin: 0px;"></iframe>
				</div>
			</div>
		  """ 

		return

]
