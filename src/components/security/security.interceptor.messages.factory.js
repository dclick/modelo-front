'use strict';
angular.module('modeloFront.components.security.factories').factory('SecurityInterceptorMessages', function($q, $rootScope, ControleMensagem, $injector, $translate, $log) {
    
    var getException;
    getException = function(data) {
      //ControleMensagem.erro(getException(rejection.data.reason || rejection.data.mensagem));
      if(!angular.isObject(data)){  
        return $translate.instant('exception.erro.generico');
      }

      var erro = data.reason || data.mensagem;
      var token = 'exception.' + erro;
      var mensagem = $translate.instant(token);
      
      if (mensagem === token) { 
        $log.warn('Mensagem não associada: #{token}');
        mensagem =  $translate.instant('exception.erro.generico');
      }

      return mensagem;
    };
   
    return {
      apply401: function(){
        $rootScope.configData = { 'autenticado': false, 'login': null };
        var state = $injector.get('$state');
        state.go('login');
        ControleMensagem.erro($translate.instant('exception.usuario.nao.autenticado'));
      },

      apply400: function(){
        ControleMensagem.erro($translate.instant('exception.bad.request'));
      },
      apply403: function(rejection) {
        switch(rejection.data) {
          case 'aplicacao.nao.encontrada':
            ControleMensagem.erro($translate.instant('exception.aplicacao.nao.encontrada'));
            break;
          case 'usuario.ou.senha.invalidos':
          case 'Bad credentials':
            ControleMensagem.erro($translate.instant('exception.bad.credentials'));
            break;
          case 'usuario.desativado':
            ControleMensagem.erro($translate.instant('exception.usuario.desativado'));
            break;
          default:
            ControleMensagem.erro(getException(rejection.data));
            break;
        }
      },
      apply404: function(rejection) {
        this.apply403(rejection);
      },
      apply412: function(rejection){
        ControleMensagem.erro(getException(rejection.data));
      },
      apply500: function(){
        ControleMensagem.erro($translate.instant('exception.erro.generico'));
      },
      apply502: function(){
        ControleMensagem.erro($translate.instant('exception.service.unavailable'));
      },
      apply503: function(){
        this.apply503();
      }
    };
});