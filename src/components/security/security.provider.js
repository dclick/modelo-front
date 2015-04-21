'use strict';

angular.module('redspark.components.security')
    .provider('SecurityTranslate', function() {
        return {
            pt_BR: function() {
                return {
                    exception: {
                        'aplicacao.nao.encontrada': 'Aplicação não encontrada',
                        'usuario.ou.senha.invalidos': 'Usuário inválido',
                        'bad.credentials': 'Bad credencials',
                        'usuario.desativado': 'Usuário Desativado',
                        'erro.generico': 'erro generico',
                        'service.unavailable': 'Serviço indisponível',
                        'usuario.nao.autenticado': 'Usuário não autorizado',
                        'bad.request': 'Bad Request',
                    }
                };
            },

            //ACESSO SOMENTE EM UM CRONTROLLER VERIFICAR MELHOR DEPOIS
            $get: function() {
                return this.pt_BR();
            }
        };

    });