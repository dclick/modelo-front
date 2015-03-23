'use strict';

angular.module('modeloFront.components.security.factories', []);

angular.module('modeloFront.components.security', ['modeloFront.components.security.factories', 'pascalprecht.translate'])
  .config(function ($stateProvider,$translateProvider,$httpProvider) {
    
    var translations = {
      'exception': {
        'aplicacao.nao.encontrada': 'Aplicação não encontrada',
        'usuario.ou.senha.invalidos': 'Usuário inválido',
        'exception.bad.credentials': 'Bad credencials',
        'usuario.desativado': 'Usuário Desativado',
        'exception.erro.generico': 'erro generico',
        'exception.service.unavailable': 'Serviço indisponível',
        'exception.usuario.nao.autenticado': 'Usuário não autorizado',
        'exception.bad.request': 'Bad Request'
      }
    };

    $httpProvider.interceptors.push('SecurityInterceptor');

    $translateProvider.translations('en', translations);
    
});

