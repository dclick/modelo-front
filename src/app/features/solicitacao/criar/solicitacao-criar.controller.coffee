angular.module "modeloBase"
  .controller "SolicitacaoCriarCtrl", ($scope, $rootScope, $modal, $state, $noty, $translate, SolicitacaoService, MeusEnderecosService, EnderecoService, UsuarioService, CceService, itemAtual, prioridades, formatos, unidades, contas, tipoSolicitacoes, enderecosFavoritos) ->

    ##################################
    ## Attributes
    ##################################
    $scope.prioridades        = prioridades.data.content
    $scope.formatos           = formatos.data.content
    $scope.unidades           = unidades.data
    $scope.contas             = contas.data
    $scope.tipoSolicitacoes   = tipoSolicitacoes.data.content
    $scope.enderecosFavoritos = enderecosFavoritos.data.content

    ##################################
    ## Methods
    ##################################
    $scope.create = () ->
      SolicitacaoService.create($scope.solicitacao)
        .success (result) ->
          $noty.success $translate.instant 'solicitacao.SOLICITACAO_SALVA_SUCESSO'
          $state.go 'solicitacao.listar'

    $scope.buscarSolicitantes = (unidadeId) ->
      $scope.solicitanteLoader       = yes
      $scope.solicitantes            = []
      UsuarioService.getByUnidade(unidadeId)
        .success (result) ->
          $scope.solicitantes      = result
          $scope.solicitanteLoader = no
        .error (result) ->
          $scope.solicitanteLoader = no

    $scope.buscarCces = (unidadeId) ->
      $scope.cceLoader       = yes
      $scope.cces            = []
      CceService.get(unidadeId)
        .success (result) ->
          $scope.cces      = result
          $scope.cceLoader = no
        .error (result) ->
          $scope.cceLoader = no

    $scope.$on 'recarregaFavoritos', () ->
      MeusEnderecosService.getAll()
        .success (result) ->
          $scope.enderecosFavoritos = result.content

    $scope.buscarPorCep = () ->
      $scope.enderecoLoader = yes
      EnderecoService.getByZip($scope.solicitacao.cep)
        .success (result) ->
          $scope.limparEndereco()
          $scope.solicitacao.uf         = result.siglaEstado
          $scope.solicitacao.cidade     = result.cidade
          $scope.solicitacao.bairro     = result.bairro
          $scope.solicitacao.logradouro = "#{result.tipoLogradouro} #{result.logradouro}"
          $scope.enderecoLoader         = no
          $('input[name="numero"]').focus()
        .error (result) ->
          $scope.enderecoLoader = no

    $scope.limparEndereco = () ->
      $scope.solicitacao.favorito     = {}
      $scope.solicitacao.cidade       = ''
      $scope.solicitacao.uf           = ''
      $scope.solicitacao.logradouro   = ''
      $scope.solicitacao.bairro       = ''
      $scope.solicitacao.numero       = ''
      $scope.solicitacao.complemento  = ''
      $scope.solicitacao.contato      = ''
      $scope.isFavorite               = false

    $scope.ativaBotaoNovoFavorito = () ->
      $scope.isFavorite or not
        $scope.solicitacao.uf or not
        $scope.solicitacao.cidade or not
        $scope.solicitacao.logradouro or not
        $scope.solicitacao.numero or not
        $scope.solicitacao.contato

    $scope.abrirModal = () ->
      $scope.modalInstance = $modal.open {
        templateUrl: 'app/features/general/modais/modal-novo-endereco-favorito/modal-novo-endereco-favorito.html'
        controller: 'NovoFavoritoModalCtrl'
        scope: $scope
        resolve:
          novoFavorito: () ->
            favorito = {
              cep          : $scope.solicitacao.cep,
              cidade       : $scope.solicitacao.cidade,
              logradouro   : $scope.solicitacao.logradouro,
              bairro       : $scope.solicitacao.bairro,
              uf           : $scope.solicitacao.uf,
              numero       : $scope.solicitacao.numero,
              complemento  : $scope.solicitacao.complemento,
              contato      : $scope.solicitacao.contato
            }
      }

    $scope.fecharModal = () ->
      $scope.modalInstance.close()

    ##################################
    ## Watchers
    ##################################
    $scope.$on '$destroy', () ->
      $scope.fecharModal() if $scope.modalInstance

    $scope.$watch 'solicitacao.unidade.idUnidade', (newVal) ->
      if angular.isDefined(newVal) && _.isFinite(newVal)
        $scope.buscarSolicitantes(newVal)
        $scope.buscarCces(newVal)

    $scope.$watch 'solicitacao.favorito.id', (newVal) ->
      if angular.isDefined(newVal) && _.isFinite(newVal)
        favorito = (_.filter $scope.enderecosFavoritos, (favorito) -> favorito.id is newVal)[0]
        $scope.solicitacao.cep          = favorito.cep
        $scope.solicitacao.uf           = favorito.uf
        $scope.solicitacao.cidade       = favorito.cidade
        $scope.solicitacao.logradouro   = favorito.logradouro
        $scope.solicitacao.bairro       = favorito.bairro
        $scope.solicitacao.numero       = favorito.numero
        $scope.solicitacao.complemento  = favorito.complemento
        $scope.solicitacao.contato      = favorito.contato
        $scope.isFavorite               = true

    # $scope.$watch 'solicitacao.uf', (newVal) ->
    #   if angular.isDefined(newVal) && !_.isEmpty(newVal)
    #     $scope.buscarCidades(newVal)

    ##################################
    ## Init
    ##################################
    if itemAtual
      $scope.solicitacao = itemAtual.data
      $scope.isDetails   = yes if itemAtual.data.situacao is 'APROVADO'
    else
      $scope.isDetails    = no
      $scope.isFavorite   = false
      unindadeUsuario     = _.filter unidades.data, (unidade) -> unidade.idUnidade is $rootScope.user.unidadeId;
      $scope.solicitacao  =
        unidade     : unindadeUsuario[0] # Traz selecionado a unidade do usuario logado
        conta       : null # Inicia a propriedade / Necessário para funcionamento correto do UI-Select
        cce         : null # Inicia a propriedade / Necessário para funcionamento correto do UI-Select
        solicitante : null # Inicia a propriedade / Necessário para funcionamento correto do UI-Select
