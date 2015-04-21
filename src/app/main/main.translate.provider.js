'use strict';

angular.module('redspark.app.main')
    .provider('MainTranslate', function() {
        return {
            pt_BR: function() {
                return {
                    HEADLINE: 'Always a pleasure scaffolding your apps.',
							      SPLENDID: 'Splendid!',
							      ALLO_ALLO: 'Allo, Allo! Nativoooo'
                };
            },

            //ACESSO SOMENTE EM UM CRONTROLLER VERIFICAR MELHOR DEPOIS
            $get: function() {
                return this.pt_BR();
            }
        };

    });