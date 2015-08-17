'use strict';

describe('controller: SolicitacaoCriarCtrl', function(){
  var scope, solicitacao, itemAtual, PrioridadesMock, FormatosMock, UnidadesMock, ContasMock, TipoSolicitacoesMock, MeusFavoritosMock, UsuariosMock, CcesMock, EnderecoMock, CidadesMock, DefaultController, modalMock, BotoesMock;

  beforeEach(module('modeloBase', function ($translateProvider, $provide, $urlRouterProvider) {
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

  beforeEach(module('modeloBase.mocks'));
  beforeEach(module('app/features/login/default/login.html'));
  beforeEach(module('app/features/solicitacao/default/solicitacao.html'));
  beforeEach(module('app/features/solicitacao/listar/solicitacao-listar.html'));
  beforeEach(module('app/features/solicitacao/criar/solicitacao-criar.html'));
  // beforeEach(module('app/features/solicitacao/criar/solicitacao-modal.html'));

  beforeEach(inject(function($rootScope, $injector, $state, $httpBackend, APP_BASE_URL, SolicitacaoService, UsuarioService, CceService, EnderecoService) {
    scope = $rootScope.$new();

    $rootScope.user = $injector.get('UserMock');

    itemAtual = {
      data: $injector.get('SolicitacaoMock')
    };

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

    MeusFavoritosMock = {
      data: {
        content: $injector.get('MeusFavoritosMock')
      }
    };

    CcesMock = $injector.get('CcesMock');
    UsuariosMock = $injector.get('UsuariosMock');

    BotoesMock = {
      criarSS: true
    };

    EnderecoMock  = $injector.get('EnderecoMock');
    CidadesMock = $injector.get('CidadesMock');

    solicitacao = {
      situacao: 'APROVADO',
      unidade: {
        id        : 1,
        idUnidade : 1,
        nome      : 'Unidade 1',
        sigla     : 'UNIDADE1'
      },
      dataAgendamento: '15/04/2016',
      prioridade: {
        id: 1,
        nome: 'Prioridade 1'
      },
      solicitante: {
        id: 1,
        nome: 'Solicitante 1'
      },
      conta: {
        id: 510000,
        descricao: 'Conta 510000',
        complemento: null
      },
      cce: {
        id: 1,
        nome: 'CCE 1'
      },
      formato: {
        id: 1,
        nome: 'Formato 1'
      },
      pesoAproximado: 21.5,
      altura: 10,
      largura: 9.3,
      profundidade: 4.7,
      tipoSolicitacao: {
        id: 1
      },
      cep: '14802280',
      uf: 'SP',
      cidade: 'Araraquara',
      logradouro: 'Rua Logradouro',
      numero: 123,
      complemento: 'Complemento',
      contato: 'Fulano'
    };

    DefaultController = {
      $scope             : scope,
      SolicitacaoService : SolicitacaoService,
      UsuarioService     : UsuarioService,
      CceService         : CceService,
      EnderecoService    : EnderecoService,
      prioridades        : PrioridadesMock,
      formatos           : FormatosMock,
      unidades           : UnidadesMock,
      contas             : ContasMock,
      tipoSolicitacoes   : TipoSolicitacoesMock,
      enderecosFavoritos : MeusFavoritosMock,
      itemAtual          : null
    };

    modalMock = {
      close: function() { return true }
    };

    $httpBackend.expect('GET', APP_BASE_URL + 'prioridades?page=0&size=9999').respond(200, PrioridadesMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'formatos?page=0&size=9999').respond(200, FormatosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'unidades').respond(200, UnidadesMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'contas').respond(200, ContasMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'tipo-solicitacoes?page=0&size=9999').respond(200, TipoSolicitacoesMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'endereco-favoritos').respond(200, MeusFavoritosMock);
    $httpBackend.flush();
  }));

describe('Criar', function() {
  it('Os itens que utilizam UI-Select deve ser iniciados como os dados do usuário', inject(function($controller, $httpBackend, APP_BASE_URL) {

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.$digest();
    $httpBackend.flush();
    expect(scope.solicitacao.unidade).not.toBeNull();
    expect(scope.solicitacao.conta).toBeNull();
    expect(scope.solicitacao.cce).toBeNull();
  }));

  it('Deve setar o scope.isDetails para false se não possuir itemAtual', inject(function($controller, $httpBackend, APP_BASE_URL) {

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.$digest();
    $httpBackend.flush();
    expect(scope.isDetails).toBeFalsy();
  }));

  it('Deve vir carregada a unidade do usuario', inject(function($controller, $httpBackend, APP_BASE_URL) {

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.$digest();
    $httpBackend.flush();
    expect(scope.solicitacao.unidade.idUnidade).not.toBeNull();
    expect(scope.solicitacao.unidade.idUnidade).toBe(1);
    expect(scope.solicitacao.unidade.nome).toBe('Unidade 1');
    expect(scope.solicitacao.unidade.sigla).toBe('UNIDADE1');
  }));

  it('Não deve salvar o solicitacao se a Unidade for inválida', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.unidade = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se a DataAgendamento for inválida', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.dataAgendamento = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se a DataAgendamento não corresponder ao pattern', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.dataAgendamento = '15042016';
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se a Prioridade for inválida', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.prioridade = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se o solicitanteNome for inválido', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.solicitanteNome = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se o solicitanteNome for maior que 60 caracteres', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.solicitanteNome = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua';
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se a Conta for inválida', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.conta = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se o CCE for inválido', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.cce = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se o Formato for inválido', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.formato = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se o PesoAproximado for inválido', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.pesoAproximado = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se o PesoAproximado for menor que 0.1', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.pesoAproximado = 0;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se a Altura for inválida', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.altura = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se a Altura for menor que 0.1', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.altura = 0;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se a largura for inválida', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.largura = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se a Largura for menor que 0.1', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.largura = 0;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se o profundidade for inválido', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.profundidade = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se o profundidade for menor que 0.1', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.profundidade = 0;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));


  it('Não deve salvar a solicitacao se o valorEstimado for menor que 0.1', inject(function($controller, $state, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.valorEstimado = 0;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar a solicitacao se o valorEstimado for nulo', inject(function($controller, $state, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.valorEstimado = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));


  it('Não deve salvar o solicitacao se o TipoSolicitacao for inválido', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.tipoSolicitacao = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se o CEP for inválido', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.cep = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se o CEP não tiver o tamanho correto', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.cep = '1480228';
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se a Cidade for inválida', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template, compiled;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    compiled = $compile(template)(scope);

    scope.solicitacao.cidade = null;
    scope.$digest();

    expect($(compiled).find('button[type="submit"]').attr('disabled')).toBe('disabled');
  }));

  it('Não deve salvar o solicitacao se o Logradouro for inválido', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template, compiled;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    compiled = $compile(template)(scope);

    scope.solicitacao.logradouro = null;
    scope.$digest();

    expect($(compiled).find('button[type="submit"]').attr('disabled')).toBe('disabled');
  }));

  it('Não deve salvar o solicitacao se o Numero for inválido', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.numero = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Não deve salvar o solicitacao se o Contato for inválido', inject(function($controller, $templateCache, $compile, $httpBackend, APP_BASE_URL) {
    var template;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao = solicitacao;
    scope.$digest();
    $httpBackend.flush();

    template = $templateCache.get('app/features/solicitacao/criar/solicitacao-criar.html');
    $compile(template)(scope);

    scope.solicitacao.contato = null;
    scope.$digest();

    expect(scope.form.$invalid).toBeTruthy();
  }));

  it('Deve buscar os Usuarios/Solicitantes ao selecionar/trocar a Unidade', inject(function($controller, $rootScope, $state, $noty, $templateCache, $compile, $httpBackend, APP_BASE_URL, SolicitacaoService, UsuarioService) {
    var spy, spy2;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    spy2 = spyOn(UsuarioService, 'getByUnidade').and.callThrough();

    $controller('SolicitacaoCriarCtrl', DefaultController);

    spy = spyOn(scope, 'buscarSolicitantes').and.callThrough();
    scope.$digest();

    expect(scope.solicitanteLoader).toBeTruthy();
    $httpBackend.flush();

    scope.$digest();
    expect(scope.solicitanteLoader).toBeFalsy();
    expect(spy).toHaveBeenCalledWith(1);
    expect(spy2).toHaveBeenCalledWith(1);
  }));

  it('Deve buscar as CCEs ao selecionar/trocar a Unidade', inject(function($controller, $rootScope, $state, $noty, $templateCache, $compile, $httpBackend, APP_BASE_URL, SolicitacaoService, CceService) {
    var spy, spy2;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    spy2 = spyOn(CceService, 'get').and.callThrough();

    $controller('SolicitacaoCriarCtrl', DefaultController);

    spy = spyOn(scope, 'buscarCces').and.callThrough();
    scope.$digest();

    expect(scope.cceLoader).toBeTruthy();
    $httpBackend.flush();

    scope.$digest();
    expect(scope.cceLoader).toBeFalsy();
    expect(spy).toHaveBeenCalledWith(1);
    expect(spy2).toHaveBeenCalledWith(1);
  }));

  it('Deve buscar os dados do endereço pelo CEP', inject(function($controller, $rootScope, $state, $noty, $templateCache, $compile, $httpBackend, APP_BASE_URL, SolicitacaoService, CceService, EnderecoService) {
    var spy;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'enderecos/ceps?cep=14802280').respond(200, EnderecoMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao.cep = '14802280';
    scope.$digest();

    spy = spyOn(EnderecoService, 'getByZip').and.callThrough();

    scope.buscarPorCep();
    expect(scope.enderecoLoader).toBeTruthy();
    $httpBackend.flush();


    expect(spy).toHaveBeenCalledWith('14802280');
    expect(scope.enderecoLoader).toBeFalsy();
    expect(scope.solicitacao.uf).toBe('SP');
    expect(scope.solicitacao.cidade).toBe('ARARAQUARA');
    expect(scope.solicitacao.logradouro).toBe('R TUPI');
  }));

  it('Deve limpar o endereco ao clicar em limparEndereco', inject(function($controller, $rootScope, $state, $noty, $templateCache, $compile, $httpBackend, APP_BASE_URL, SolicitacaoService, CceService, EnderecoService) {
    var spy;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.solicitacao.cep          = '14802280';
    scope.solicitacao.cidade       = 'Guarulhos';
    scope.solicitacao.uf           = 'SP';
    scope.solicitacao.logradouro   = 'Rua das Rudas';
    scope.solicitacao.bairro       = 'Bairroso';
    scope.solicitacao.numero       = '112';
    scope.solicitacao.complemento  = 'CASA';
    scope.solicitacao.contato      = 'Testando 123';

    scope.$digest();
    $httpBackend.flush();

    scope.limparEndereco();
    scope.$digest();

    expect(scope.solicitacao.cidade).toBe('');
    expect(scope.solicitacao.uf).toBe('');
    expect(scope.solicitacao.logradouro).toBe('');
    expect(scope.solicitacao.bairro).toBe('');
    expect(scope.solicitacao.numero).toBe('');
    expect(scope.solicitacao.complemento).toBe('');
    expect(scope.solicitacao.contato).toBe('');
  }));

  it('Deve chamar o SolicitacaoService para salvar o programa', inject(function($controller, $rootScope, $state, $noty, $templateCache, $compile, $httpBackend, APP_BASE_URL, SolicitacaoService) {
    var spy, spy2;


    $httpBackend.expect('POST', APP_BASE_URL + 'solicitacoes').respond(200, {});
    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'me/botoes').respond(200, BotoesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    spy = spyOn(SolicitacaoService, 'create').and.callThrough();
    spy2 = spyOn($noty, 'success').and.callThrough();

    scope.create(scope.solicitacao);
    $httpBackend.flush();

    expect($state.current.name).toBe('solicitacao.listar');
    expect(spy).toHaveBeenCalledWith(scope.solicitacao);
    expect(spy2).toHaveBeenCalled();
  }));
});

describe('Modal', function() {
  it('Deve instanciar o modal ao executar o método abrirModal', inject(function($controller, $state, $noty, $modal, $httpBackend, SolicitacaoService, APP_BASE_URL) {
    var spy;

    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', DefaultController);

    scope.$digest();

    spy = spyOn($modal, 'open').and.callThrough();

    scope.abrirModal();

    expect(spy).toHaveBeenCalled();
  }));

});

describe('Editar', function() {
  it('Deve setar o scope.solicitacao para ser o itemAtual', inject(function($controller, $rootScope, $state, $templateCache, $compile, $httpBackend, APP_BASE_URL, SolicitacaoService) {
    $state.go('solicitacao.editar', { id: 1 });
    $httpBackend.expect('GET', APP_BASE_URL + 'solicitacoes/1').respond(200, JSON.stringify(solicitacao));
    $httpBackend.expect('GET', APP_BASE_URL + 'prioridades?page=0&size=9999').respond(200, PrioridadesMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'formatos?page=0&size=9999').respond(200, FormatosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'unidades').respond(200, UnidadesMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'contas').respond(200, ContasMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'tipo-solicitacoes?page=0&size=9999').respond(200, TipoSolicitacoesMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'endereco-favoritos').respond(200, MeusFavoritosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', {
      $scope             : scope,
      SolicitacaoService : SolicitacaoService,
      prioridades        : PrioridadesMock,
      formatos           : FormatosMock,
      unidades           : UnidadesMock,
      contas             : ContasMock,
      tipoSolicitacoes   : TipoSolicitacoesMock,
      enderecosFavoritos : MeusFavoritosMock,
      itemAtual          : itemAtual
    });

    scope.$digest();
    $httpBackend.flush();

    expect(scope.solicitacao).toBe(itemAtual.data);
  }));

  it('Deve setar o scope.isDetails para true se o status for "APROVADO"', inject(function($controller, $rootScope, $state, $templateCache, $compile, $httpBackend, APP_BASE_URL, SolicitacaoService) {
    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    $controller('SolicitacaoCriarCtrl', {
      $scope             : scope,
      SolicitacaoService : SolicitacaoService,
      prioridades        : PrioridadesMock,
      formatos           : FormatosMock,
      unidades           : UnidadesMock,
      contas             : ContasMock,
      tipoSolicitacoes   : TipoSolicitacoesMock,
      enderecosFavoritos : MeusFavoritosMock,
      itemAtual          : itemAtual
    });

    scope.$digest();
    $httpBackend.flush();

    expect(scope.isDetails).toBeTruthy();
  }));

  it('Deve setar o scope.isDetails para false se o status não for "APROVADO"', inject(function($controller, $rootScope, $state, $templateCache, $compile, $httpBackend, APP_BASE_URL, SolicitacaoService) {
    $httpBackend.expect('GET', APP_BASE_URL + 'usuarios?unidade=1').respond(200, UsuariosMock);
    $httpBackend.expect('GET', APP_BASE_URL + 'cces?unidadeId=1').respond(200, CcesMock);

    itemAtual.data.situacao = 'REPROVADO';

    $controller('SolicitacaoCriarCtrl', {
      $scope             : scope,
      SolicitacaoService : SolicitacaoService,
      prioridades        : PrioridadesMock,
      formatos           : FormatosMock,
      unidades           : UnidadesMock,
      contas             : ContasMock,
      tipoSolicitacoes   : TipoSolicitacoesMock,
      enderecosFavoritos : MeusFavoritosMock,
      itemAtual          : itemAtual
    });

    scope.$digest();
    $httpBackend.flush();

    expect(scope.isDetails).toBeFalsy();
  }));
});
});