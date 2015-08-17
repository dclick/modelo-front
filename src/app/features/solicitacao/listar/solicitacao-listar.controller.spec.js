'use strict';

describe('controller: SolicitacaoListarCtrl', function(){
  var scope, SolicitacaoMock, PrioridadesMock, FormatosMock, UnidadesMock, ContasMock, TipoSolicitacoesMock, CcesMock, MeusFavoritosMock, BotoesMock;

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
    $urlRouterProvider.otherwise('/solicitacao');
  }));

  beforeEach(module('sescMotoFrete.mocks'));
  beforeEach(module('app/features/login/default/login.html'));
  beforeEach(module('app/features/solicitacao/default/solicitacao.html'));
  beforeEach(module('app/features/solicitacao/listar/solicitacao-listar.html'));
  beforeEach(module('app/features/solicitacao/criar/solicitacao-criar.html'));

  beforeEach(inject(function($rootScope, $injector, $state, $httpBackend, APP_BASE_URL) {
    scope = $rootScope.$new();

    PrioridadesMock = {
      data: {
        content: $injector.get('PrioridadesMock')
      }
    };

    FormatosMock = {
      data: {
        content: $injector.get('FormatosMock')
      }
    };

    UnidadesMock = {
      data: $injector.get('UnidadesMock')
    };

    ContasMock = {
      data: $injector.get('ContasMock')
    };

    TipoSolicitacoesMock = {
      data: {
        content: $injector.get('TipoSolicitacoesMock')
      }
    };

    CcesMock = {
      data: $injector.get('CcesMock')
    };

    BotoesMock = {
      criarSS: true
    };

    SolicitacaoMock = $injector.get('SolicitacaoMock');
  }));

  it('Deve ter o $scope.options definido', inject(function($controller, SolicitacaoService) {
    expect(scope.options).toBeUndefined();

    $controller('SolicitacaoListarCtrl', {
      $scope             : scope,
      SolicitacaoService : SolicitacaoService,
      botoes             : BotoesMock
    });

    scope.$digest();

    expect(scope.options).toBeDefined();
  }));

  it('Deve ir até a rota de editar', inject(function($controller, $state, SolicitacaoService, $httpBackend, APP_BASE_URL) {
    var spy;

    $httpBackend.expect('GET', APP_BASE_URL + 'solicitacoes/1').respond(200, JSON.stringify(SolicitacaoMock));
    $httpBackend.expect('GET', APP_BASE_URL + 'prioridades?page=0&size=9999').respond(200, PrioridadesMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'formatos?page=0&size=9999').respond(200, FormatosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'unidades').respond(200, UnidadesMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'contas').respond(200, ContasMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'tipo-solicitacoes?page=0&size=9999').respond(200, TipoSolicitacoesMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'endereco-favoritos').respond(200, MeusFavoritosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'me/botoes').respond(200, BotoesMock);


    $controller('SolicitacaoListarCtrl', {
      $scope              : scope,
      SolicitacaoService  : SolicitacaoService,
      botoes              : BotoesMock
    });

    scope.$digest();

    spy = spyOn($state, 'go').and.callThrough();

    scope.editar(1);
    $httpBackend.flush();

    expect(spy).toHaveBeenCalledWith('solicitacao.editar', { id: 1 });
  }));

  it('Deve recarregar dados ao deletar uma row da tabela', inject(function($controller, $state, $noty, $httpBackend, SolicitacaoService, APP_BASE_URL) {
    var spy, spy2, spy3;

    $httpBackend.expect('DELETE', APP_BASE_URL + 'solicitacoes/1').respond(200, {});
    $httpBackend.expect('GET', APP_BASE_URL + 'me/botoes').respond(200, BotoesMock);

    $controller('SolicitacaoListarCtrl', {
      $scope              : scope,
      SolicitacaoService  : SolicitacaoService,
      botoes              : BotoesMock
    });

    spy = spyOn(SolicitacaoService, 'delete').and.callThrough();
    spy2 = spyOn($noty, 'success').and.callThrough();
    spy3 = spyOn(scope, '$broadcast').and.callThrough();

    scope.deletar(1);
    scope.$digest();

    $httpBackend.flush();

    expect(spy).toHaveBeenCalledWith(1);
    expect(spy2).toHaveBeenCalled();
  }));
});
