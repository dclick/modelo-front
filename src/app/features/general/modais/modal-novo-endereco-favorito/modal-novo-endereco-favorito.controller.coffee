angular.module "modeloBase"
  .controller "NovoFavoritoModalCtrl", ($scope, $rootScope, $modalInstance, $noty, $translate, MeusEnderecosService, novoFavorito) ->

    ##################################
    ## Attributes
    ##################################
    $scope.novoFavorito = novoFavorito

    ##################################
    ## Métodos
    ##################################
    $scope.fecharModal = () ->
      $modalInstance.close()

    $scope.create = () ->
      MeusEnderecosService.create($scope.novoFavorito)
        .success (result) ->
          $noty.success $translate.instant 'meusEnderecos.MEUS_ENDERECOS_SALVO_SUCESSO'
          $scope.$emit('recarregaFavoritos');
          $scope.fecharModal()

    ##################################
    ## Watchers
    ##################################

    ##################################
    ## Init
    ##################################
    $scope.$on '$destroy', () ->
        $scope.fecharModal()