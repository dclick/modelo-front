'use strict';

angular.module('redspark')
    .provider('IndexTranslate', function() {
        return {
            pt_BR: function() {
                return {
                    HEADLINE: 'Always a pleasure scaffolding your apps Personalizada'//,
      							//ALLO_ALLO: 'Allo, Allo!'
                };
            },
            //ACESSO SOMENTE EM UM CRONTROLLER VERIFICAR MELHOR DEPOIS
            $get: function() {
                return this.pt_BR();
            }
        };

    });