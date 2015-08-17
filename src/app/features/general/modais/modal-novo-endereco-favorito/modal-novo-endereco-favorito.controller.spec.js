'use strict';

describe('controller: NovoFavoritoModalCtrl', function(){
  var scope, rootScope, modalInstance, controllerInjections, EnderecoMock;

  beforeEach(module('sescMotoFrete', function ($translateProvider, $provide, $urlRouterProvider) {
    $translateProvider.translations('pt-BR', {});
    $provide.value('routeAuth', {
      updateUserInfo: function() {
        return true;
      },
      verifyRouteAccess: function() {
        return true;
      }
    });
    $urlRouterProvider.otherwise('/solicitacao/criar');
  }));

  beforeEach(module('sescMotoFrete.mocks'));
  beforeEach(module('app/features/login/default/login.html'));
  beforeEach(module('app/features/solicitacao/default/solicitacao.html'));
  beforeEach(module('app/features/solicitacao/criar/solicitacao-criar.html'));
  beforeEach(module('app/features/general/modais/modal-novo-endereco-favorito/modal-novo-endereco-favorito.html'));

  beforeEach(inject(function($rootScope, $injector) {
    rootScope = $rootScope;
    scope = $rootScope.$new();

    EnderecoMock  = $injector.get('EnderecoMock');

    // Mock do modal
    modalInstance = {
      close   : jasmine.createSpy('modalInstance.close'),
      dismiss : jasmine.createSpy('modalInstance.dismiss'),
      result  : {
        then : jasmine.createSpy('modalInstance.result.then')
      }
    };
  }));

  beforeEach(inject(function() {
    controllerInjections = {
      $scope                    : scope,
      $modalInstance            : modalInstance,
      novoFavorito              : EnderecoMock
    };
  }));


  it('Deve ter as propriedades do $scope.novoFavorito iniciadas', inject(function($controller) {
    $controller('NovoFavoritoModalCtrl', controllerInjections);

    scope.$digest();

    expect(scope.novoFavorito).toEqual(EnderecoMock);
  }));

  it('Deve chamar o $modalInstance.close() ao executar o método $scope.fecharModal()', inject(function($controller) {
    $controller('NovoFavoritoModalCtrl', controllerInjections);
    scope.$digest();

    scope.fecharModal();

    expect(modalInstance.close).toHaveBeenCalled();
  }));

  it('Deve chamar o $scope.fecharModal() ao receber o evento de $destroy', inject(function($controller) {
    var spy;

    $controller('NovoFavoritoModalCtrl', controllerInjections);

    spy = spyOn(scope, 'fecharModal').and.callThrough();
    scope.$digest();

    scope.$broadcast('$destroy');

    expect(spy).toHaveBeenCalled();
    expect(modalInstance.close).toHaveBeenCalled();
  }));

  it('Deve ter o nome do favorito preenchido', inject(function($controller, $state, $noty, $modal, $httpBackend, $templateCache, $compile, APP_BASE_URL) {
    var template;

    $controller('NovoFavoritoModalCtrl', controllerInjections);

    scope.$digest();

    template = $templateCache.get('app/features/general/modais/modal-novo-endereco-favorito/modal-novo-endereco-favorito.html');
    $compile(template)(scope);

    scope.novoFavorito.nome = null;
    scope.$digest();

    expect(scope.form.nome.$error.required).toBeTruthy();
  }));


  it('Não deve salvar o favorito se o nome for maior que 60 caracteres', inject(function($controller, $state, $noty, $modal, $httpBackend, $templateCache, $compile, APP_BASE_URL) {
    var template;

    $controller('NovoFavoritoModalCtrl', controllerInjections);

    scope.$digest();

    template = $templateCache.get('app/features/general/modais/modal-novo-endereco-favorito/modal-novo-endereco-favorito.html');
    $compile(template)(scope);

    scope.novoFavorito.nome = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua';
    scope.$digest();

    expect(scope.form.nome.$error.maxlength).toBeTruthy();
  }));
});