angular.module "modeloBase"
  .controller "SolicitacaoListarCtrl", ($scope, $state, $noty, $filter, $translate, $window, SolicitacaoService, STATUS, botoes) ->

    ##################################
    ## Attributes
    ##################################
    $scope.botoes = botoes.data

    ##################################
    ## Métodos
    ##################################
    $scope.editar = (id) ->
      $state.go 'solicitacao.editar', id: id

    $scope.deletar = (id) ->
      SolicitacaoService.delete(id)
        .success (result) ->
          $scope.$broadcast 'dataTables:redraw'
          $noty.success $translate.instant 'solicitacao.SOLICITACAO_EXCLUIDA_SUCESSO'

    ##################################
    ## Watchers
    ##################################

    ##################################
    ## Init
    ##################################
    $scope.options =
      config:
        actionButtons: true
        inspectButton: false
        aoColumnDefs: [
          {
            aTargets: ["_all"]
            defaultContent: '-'
          }
        ]
        aoColumns: [
          {
            sClass: "text-center"
            sTitle: 'Código'
            sWidth: "10%"
            mDataProp: (obj) -> return '<a>' + $filter('idFilter')(obj.id, 'SS') + '</a>'
          } #ID da solicitação
          {
            sClass: "text-center"
            sTitle: 'Data Criação'
            sWidth: "15%"
            mDataProp: (obj) ->
              $filter('formatDateTimeFilter')(obj.dataCriacao)
          } # Data Criação
          {
            sClass: "text-center"
            sTitle: 'Data'
            sWidth: "10%"
            mDataProp: (obj) ->
              $filter('formatDateFilter')(obj.dataAgendamento)
          } # Data
          { sClass: "text-left", sTitle: 'Tipo', mDataProp: 'tipoSolicitacao.nome', sWidth: "30%" }, # Tipo de solicitação
          {
            sClass: "text-left"
            sTitle: 'Destino'
            mDataProp: (obj) ->
              endereco = "#{obj.cidade} - #{obj.uf} - #{obj.cep} - #{obj.logradouro} - Nº #{obj.numero}"
              endereco += " - #{obj.complemento}" if obj.complemento
              return endereco
          } # Destino
          {
            sClass: "text-left"
            sTitle: 'Situação'
            mDataProp: (obj) -> return STATUS[obj.situacao]
          } # Situação
        ]
        bPaginate: true
        bProcessing: true
        bServerSide : true
        bSort: false
        # group: true
        fnServerData: (sSource, oaData, fnCallback, oSettings) ->
          page = Math.ceil(oSettings._iDisplayStart / oSettings._iDisplayLength)

          SolicitacaoService.getAll(page, oSettings._iDisplayLength, oSettings.oInstance.fnSettings().oPreviousSearch.sSearch)
            .success (result) ->
              $scope.options.data = result.content
              dataTablesData =
                iTotalRecords : result.totalElements
                iTotalDisplayRecords : result.totalElements
                sEcho: oSettings.iDraw

              dataTablesData.aaData = result.content
              fnCallback(dataTablesData)

      selectedRow: (row)->
        $scope.editar row.id

      deleteRow: (row, index)->
        if $window.confirm 'Deseja excluir esta solicitação?'
          $scope.deletar row.id

      # columns: [
        # { title: 'Situação'  }
      # ]
