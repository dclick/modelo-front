angular.module "modeloBase", ['ngAnimate', 'ngCookies', 'ngSanitize', 'ui.router', 'ui.bootstrap', 'ui.utils', 'ui.select', 'ui.utils.masks', 'pascalprecht.translate', 'guideline', 'angularSpinner']
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

    $urlRouterProvider.otherwise APP_OTHERWISE_URL
    $urlRouterProvider.when '/home', APP_OTHERWISE_URL

  .config ($translateProvider) ->
    $translateProvider.useStaticFilesLoader {
      type: 'static-files'
      prefix: 'i18n/'
      suffix: '.json'
    }

    $translateProvider.preferredLanguage('pt-BR')