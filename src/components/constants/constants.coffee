'use strict'

# =============================================
# Constants
# =============================================
angular.module 'modeloBase'

  # Base URL for services
  .constant 'APP_BASE_URL', window.config.APP_BASE_URL
  .constant 'APP_USER_NOT_AUTH_REDIRECT', window.config.APP_USER_NOT_AUTH_REDIRECT
  .constant 'APP_OTHERWISE_URL', window.config.APP_OTHERWISE_URL
  .constant 'STATUS', {
    SS_GERADA : 'Solicitação gerada'
    OS_GERADA : 'Ordem de serviço gerada'
    EX_GERADA : 'Expedição gerada'
    CONCLUIDO : 'Entrega concluída'
    RETORNADO : 'Entrega retornada'
    REPROVADO : 'Solicitação reprovada'
    EXCLUIDA  : 'Solicitação excluída'
    LIBERADA  : 'Liberada para faturamento'
  }