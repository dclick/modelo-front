angular.module "sescMotoFrete", ['ngAnimate', 'ngCookies', 'ngSanitize', 'ui.router', 'ui.bootstrap', 'ui.utils', 'ui.select', 'ui.utils.masks', 'pascalprecht.translate', 'guideline', 'angularSpinner']
  .config ($stateProvider, $urlRouterProvider, APP_OTHERWISE_URL) ->
    $stateProvider
      #############################
      # Login
      #############################
      .state "login",
        url         : "/login"
        templateUrl : "app/features/login/default/login.html"
        data        :
          restrict : no

      #############################
      # Home
      #############################
      .state "home",
        url         : '/home'
        # templateUrl : "app/features/home/default/home.html"
        data        :
          restrict : no # yes
          # breadcrumb :
          #   displayName : 'Página inicial'

      #############################
      # Tipo de contrato
      #############################
      .state "tipoContrato",
        abstract    : yes
        url         : "/tipocontrato"
        templateUrl : "app/features/tipo-contrato/default/tipo-contrato.html"
        data        :
          restrict   : yes
          breadcrumb :
            displayName : 'Tipo de contrato'
            before      : 'Administrativo'
            linkTo      : 'tipoContrato.listar'
      .state "tipoContrato.listar",
        url         : ""
        templateUrl : "app/features/tipo-contrato/listar/tipo-contrato-listar.html"
        controller  : "TipoContratoListarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_TIPOCONTRATO.LISTAR'
          breadcrumb  :
            displayName : 'Listar'
      .state "tipoContrato.criar",
        url         : "/criar"
        templateUrl : "app/features/tipo-contrato/criar/tipo-contrato-criar.html"
        controller  : "TipoContratoCriarCtrl"
        data        :
          restrict   : yes
          authorities : 'ROLE_TIPOCONTRATO.CRIAR'
          breadcrumb :
            displayName : 'Criar'
        resolve:
          itemAtual: () ->
            return null
      .state "tipoContrato.editar",
        url         : "/editar/:id"
        templateUrl : "app/features/tipo-contrato/criar/tipo-contrato-criar.html"
        controller  : "TipoContratoCriarCtrl"
        data        :
          restrict   : yes
          authorities : 'ROLE_TIPOCONTRATO.CRIAR'
          breadcrumb :
            displayName : 'Editar'
        resolve:
          itemAtual: (TipoContratoService, $stateParams) ->
            TipoContratoService.get($stateParams.id)

      #############################
      # Contrato
      #############################
      .state "contrato",
        abstract    : yes
        url         : "/contrato"
        templateUrl : "app/features/contrato/default/contrato.html"
        data        :
          restrict   : yes
          breadcrumb :
            displayName : 'Contrato'
            before      : 'Administrativo'
            linkTo      : 'contrato.listar'
      .state "contrato.listar",
        url         : ""
        templateUrl : "app/features/contrato/listar/contrato-listar.html"
        controller  : "ContratoListarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_CONTRATO.LISTAR'
          breadcrumb  :
            displayName : 'Listar'
      .state "contrato.criar",
        url         : "/criar"
        templateUrl : "app/features/contrato/criar/contrato-criar.html"
        controller  : "ContratoCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_CONTRATO.CRIAR'
          breadcrumb  :
            displayName : 'Criar'
        resolve:
          itemAtual: () ->
            return null
          tipoContratos: (TipoContratoService) ->
            TipoContratoService.getAll(0, 9999)
          tipoCobrancas: (TipoCobrancaService) ->
            TipoCobrancaService.getAll(0, 9999)
          unidades: (UnidadeService) ->
            UnidadeService.getAll()
      .state "contrato.editar",
        url         : "/editar/:id"
        templateUrl : "app/features/contrato/criar/contrato-criar.html"
        controller  : "ContratoCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_CONTRATO.CRIAR'
          breadcrumb  :
            displayName : 'Editar'
        resolve:
          itemAtual: (ContratoService, $stateParams) ->
            ContratoService.get($stateParams.id)
          tipoContratos: (TipoContratoService) ->
            TipoContratoService.getAll(0, 9999)
          tipoCobrancas: (TipoCobrancaService) ->
            TipoCobrancaService.getAll(0, 9999)
          unidades: (UnidadeService) ->
            UnidadeService.getAll()

      #############################
      # Solicitação
      #############################
      .state "solicitacao",
        abstract    : yes
        url         : "/solicitacao"
        templateUrl : "app/features/solicitacao/default/solicitacao.html"
        data        :
          restrict   : yes
          breadcrumb :
            displayName : 'Solicitação'
            linkTo      : 'solicitacao.listar'
      .state "solicitacao.listar",
        url         : ""
        templateUrl : "app/features/solicitacao/listar/solicitacao-listar.html"
        controller  : "SolicitacaoListarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_SOLICITACAO.LISTAR'
          breadcrumb  :
            displayName : 'Listar'
        resolve:
          botoes: (MeService) ->
            MeService.botoes()
      .state "solicitacao.criar",
        url         : "/criar"
        templateUrl : "app/features/solicitacao/criar/solicitacao-criar.html"
        controller  : "SolicitacaoCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_SOLICITACAO.CRIAR'
          breadcrumb  :
            displayName : 'Criar'
        resolve:
          itemAtual: () ->
            return null
          prioridades: (PrioridadeService) ->
            PrioridadeService.getAll(0, 9999)
          formatos: (FormatoService) ->
            FormatoService.getAll(0, 9999)
          unidades: (UnidadeService) ->
            UnidadeService.getAll()
          contas: (ContaService) ->
            ContaService.getAll()
          tipoSolicitacoes: (TipoSolicitacaoService) ->
            TipoSolicitacaoService.getAll(0, 9999)
          enderecosFavoritos: (MeusEnderecosService) ->
            MeusEnderecosService.getAll()
      .state "solicitacao.editar",
        url         : "/editar/:id"
        templateUrl : "app/features/solicitacao/criar/solicitacao-criar.html"
        controller  : "SolicitacaoCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_SOLICITACAO.CRIAR'
          breadcrumb  :
            displayName : 'Editar'
        resolve:
          itemAtual: (SolicitacaoService, $stateParams) ->
            SolicitacaoService.get($stateParams.id)
          prioridades: (PrioridadeService) ->
            PrioridadeService.getAll(0, 9999)
          formatos: (FormatoService) ->
            FormatoService.getAll(0, 9999)
          unidades: (UnidadeService) ->
            UnidadeService.getAll()
          contas: (ContaService) ->
            ContaService.getAll()
          tipoSolicitacoes: (TipoSolicitacaoService) ->
            TipoSolicitacaoService.getAll(0, 9999)
          enderecosFavoritos: (MeusEnderecosService) ->
            MeusEnderecosService.getAll()

      #############################
      # Prioridade
      #############################
      .state "prioridade",
        abstract    : yes
        url         : "/prioridade"
        templateUrl : "app/features/prioridade/default/prioridade.html"
        data        :
          restrict   : yes
          breadcrumb :
            displayName : 'Prioridade'
            before      : 'Administrativo'
            linkTo      : 'prioridade.listar'
      .state "prioridade.listar",
        url         : ""
        templateUrl : "app/features/prioridade/listar/prioridade-listar.html"
        controller  : "PrioridadeListarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_PRIORIDADE.LISTAR'
          breadcrumb  :
            displayName : 'Listar'
      .state "prioridade.criar",
        url         : "/criar"
        templateUrl : "app/features/prioridade/criar/prioridade-criar.html"
        controller  : "PrioridadeCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_PRIORIDADE.CRIAR'
          breadcrumb  :
            displayName : 'Criar'
        resolve:
          itemAtual: () ->
            return null
      .state "prioridade.editar",
        url         : "/editar/:id"
        templateUrl : "app/features/prioridade/criar/prioridade-criar.html"
        controller  : "PrioridadeCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_PRIORIDADE.CRIAR'
          breadcrumb  :
            displayName : 'Editar'
        resolve:
          itemAtual: (PrioridadeService, $stateParams) ->
            PrioridadeService.get($stateParams.id)


      #############################
      # Formato
      #############################
      .state "formato",
        abstract    : yes
        url         : "/formato"
        templateUrl : "app/features/formato/default/formato.html"
        data        :
          restrict   : yes
          breadcrumb :
            displayName : 'Formato'
            before      : 'Administrativo'
            linkTo      : 'formato.listar'
      .state "formato.listar",
        url         : ""
        templateUrl : "app/features/formato/listar/formato-listar.html"
        controller  : "FormatoListarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_FORMATO.LISTAR'
          breadcrumb  :
            displayName : 'Listar'
      .state "formato.criar",
        url         : "/criar"
        templateUrl : "app/features/formato/criar/formato-criar.html"
        controller  : "FormatoCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_FORMATO.CRIAR'
          breadcrumb  :
            displayName : 'Criar'
        resolve:
          itemAtual: () ->
            return null
      .state "formato.editar",
        url         : "/editar/:id"
        templateUrl : "app/features/formato/criar/formato-criar.html"
        controller  : "FormatoCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_FORMATO.CRIAR'
          breadcrumb  :
            displayName : 'Editar'
        resolve:
          itemAtual: (FormatoService, $stateParams) ->
            FormatoService.get($stateParams.id)


      #############################
      # Tipo de solicitação
      #############################
      .state "tipoSolicitacao",
        abstract    : yes
        url         : "/tiposolicitacao"
        templateUrl : "app/features/tipo-solicitacao/default/tipo-solicitacao.html"
        data        :
          restrict   : yes
          breadcrumb :
            displayName : 'Tipo de solicitação'
            before      : 'Administrativo'
            linkTo      : 'tipoSolicitacao.listar'
      .state "tipoSolicitacao.listar",
        url         : ""
        templateUrl : "app/features/tipo-solicitacao/listar/tipo-solicitacao-listar.html"
        controller  : "TipoSolicitacaoListarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_TIPOSOLICITACAO.LISTAR'
          breadcrumb  :
            displayName : 'Listar'
      .state "tipoSolicitacao.criar",
        url         : "/criar"
        templateUrl : "app/features/tipo-solicitacao/criar/tipo-solicitacao-criar.html"
        controller  : "TipoSolicitacaoCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_TIPOSOLICITACAO.CRIAR'
          breadcrumb  :
            displayName : 'Criar'
        resolve:
          itemAtual: () ->
            return null
      .state "tipoSolicitacao.editar",
        url         : "/editar/:id"
        templateUrl : "app/features/tipo-solicitacao/criar/tipo-solicitacao-criar.html"
        controller  : "TipoSolicitacaoCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_TIPOSOLICITACAO.CRIAR'
          breadcrumb  :
            displayName : 'Editar'
        resolve:
          itemAtual: (TipoSolicitacaoService, $stateParams) ->
            TipoSolicitacaoService.get($stateParams.id)

      #############################
      # Meus Enderecos
      #############################
      .state "meusEnderecos",
        abstract    : yes
        url         : "/meusEnderecos"
        templateUrl : "app/features/meus-enderecos/default/meus-enderecos.html"
        data        :
          restrict   : yes
          breadcrumb :
            displayName : 'Meus Endereços'
            linkTo      : 'meusEnderecos.listar'
      .state "meusEnderecos.listar",
        url         : ""
        templateUrl : "app/features/meus-enderecos/listar/meus-enderecos-listar.html"
        controller  : "MeusEnderecosListarCtrl"
        data        :
          restrict    : yes
          breadcrumb  :
            displayName : 'Listar'
      .state "meusEnderecos.criar",
        url         : "/criar"
        templateUrl : "app/features/meus-enderecos/criar/meus-enderecos-criar.html"
        controller  : "MeusEnderecosCriarCtrl"
        data        :
          restrict    : yes
          breadcrumb  :
            displayName : 'Criar'
        resolve:
          itemAtual: () ->
            return null
      .state "meusEnderecos.editar",
        url         : "/editar/:id"
        templateUrl : "app/features/meus-enderecos/criar/meus-enderecos-criar.html"
        controller  : "MeusEnderecosCriarCtrl"
        data        :
          restrict    : yes
          breadcrumb  :
            displayName : 'Editar'
        resolve:
          itemAtual: (MeusEnderecosService, $stateParams) ->
            MeusEnderecosService.get($stateParams.id)

      #############################
      # Ordem de serviço
      #############################
      .state "ordemServico",
        abstract    : yes
        url         : "/ordemservico"
        templateUrl : "app/features/ordem-servico/default/ordem-servico.html"
        data        :
          restrict   : yes
          breadcrumb :
            displayName : 'Ordem de serviço'
            linkTo      : 'ordemServico.listar'
      .state "ordemServico.listar",
        url         : ""
        templateUrl : "app/features/ordem-servico/listar/ordem-servico-listar.html"
        controller  : "OrdemServicoListarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_ORDEMSERVICO.LISTAR'
          breadcrumb  :
            displayName : 'Listar'
      .state "ordemServico.criar",
        url         : "/criar"
        templateUrl : "app/features/ordem-servico/criar/ordem-servico-criar.html"
        controller  : "OrdemServicoCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_ORDEMSERVICO.CRIAR'
          breadcrumb  :
            displayName : 'Criar'

      #############################
      # Expedição
      #############################
      .state "expedicao",
        abstract    : yes
        url         : "/expedicao"
        templateUrl : "app/features/expedicao/default/expedicao.html"
        data        :
          restrict   : yes
          breadcrumb :
            displayName : 'Expedição'
            linkTo      : 'expedicao.listar'
      .state "expedicao.listar",
        url         : ""
        templateUrl : "app/features/expedicao/listar/expedicao-listar.html"
        controller  : "ExpedicaoListarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_EXPEDICAO.LISTAR'
          breadcrumb  :
            displayName : 'Listar'
      .state "expedicao.criar",
        url         : "/criar"
        templateUrl : "app/features/expedicao/criar/expedicao-criar.html"
        controller  : "ExpedicaoCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_EXPEDICAO.CRIAR'
          breadcrumb  :
            displayName : 'Criar'
        resolve:
          contratos: (ContratoService) ->
            ContratoService.getAllContractsForExpedition()

      #############################
      # Nota Fiscal
      #############################
      .state "notaFiscal",
        abstract    : yes
        url         : "/notafiscal"
        templateUrl : "app/features/nota-fiscal/default/nota-fiscal.html"
        data        :
          restrict   : yes
          breadcrumb :
            displayName : 'Nota Fiscal'
            linkTo      : 'notaFiscal.listar'
      .state "notaFiscal.listar",
        url         : ""
        templateUrl : "app/features/nota-fiscal/listar/nota-fiscal-listar.html"
        controller  : "NotaFiscalListarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_NOTAFISCAL.LISTAR'
          breadcrumb  :
            displayName : 'Listar'
      .state "notaFiscal.criar",
        url         : "/criar"
        templateUrl : "app/features/nota-fiscal/criar/nota-fiscal-criar.html"
        controller  : "NotaFiscalCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_NOTAFISCAL.CRIAR'
          breadcrumb  :
            displayName : 'Criar'
        resolve:
          itemAtual: () ->
            return null
          unidades: (UnidadeService) ->
            UnidadeService.getAll()
          comprovantes: (NotaFiscalService) ->
            NotaFiscalService.getComprovantes()
          contratos: (ContratoService) ->
            ContratoService.getAll(0, 9999)
      .state "notaFiscal.editar",
        url         : "/editar/:id"
        templateUrl : "app/features/nota-fiscal/criar/nota-fiscal-criar.html"
        controller  : "NotaFiscalCriarCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_NOTAFISCAL.CRIAR'
          breadcrumb  :
            displayName : 'Editar'
        resolve:
          itemAtual: (NotaFiscalService, $stateParams) ->
            NotaFiscalService.get($stateParams.id)
          unidades: (UnidadeService) ->
            UnidadeService.getAll()
          comprovantes: (NotaFiscalService) ->
            NotaFiscalService.getComprovantes()
          contratos: (ContratoService) ->
            ContratoService.getAll(0, 9999)

      #############################
      # Solicitações Realizadas
      #############################
      .state "solicitacoesRealizadas",
        abstract    : yes
        url         : "/solicitacoesrealizadas"
        templateUrl : "app/features/solicitacoes-realizadas/default/solicitacoes-realizadas.html"
        data        :
          restrict   : yes
          breadcrumb :
            displayName : 'Solicitações Realizadas'
            linkTo      : 'solicitacoesRealizadas.listar'
      .state "solicitacoesRealizadas.listar",
        url         : ""
        templateUrl : "app/features/solicitacoes-realizadas/listar/solicitacoes-realizadas-listar.html"
        controller  : "SolicitacoesRealizadasCtrl"
        data        :
          restrict    : yes
          authorities : 'ROLE_ORDENSREALIZADAS.LISTAR'
          breadcrumb  :
            displayName : 'Listar'

    $urlRouterProvider.otherwise APP_OTHERWISE_URL
    $urlRouterProvider.when '/home', APP_OTHERWISE_URL

  .config ($translateProvider) ->
    $translateProvider.useStaticFilesLoader {
      type: 'static-files'
      prefix: 'i18n/'
      suffix: '.json'
    }

    $translateProvider.preferredLanguage('pt-BR')