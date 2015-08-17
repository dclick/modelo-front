'use strict'

###*
 # @ngdoc directive
 # @name sgdlApp.directive:Datatables
 # @description
 # # Datatables
###
angular.module('guideline.datatables', ['guideline.datatables.template'])

.config(
  ()->
    $.fn.dataTableExt.ofnSearch['string'] = ( data ) ->
      if not data
        return ""
      else
        if typeof data is 'string'
          return data
            .replace(/[ãáâàåäÃÁÂÀÅÄ]/g, "a")
            .replace(/[íìîïÍÌÎÏ]/g, "i")
            .replace(/[úùûüÚÙÛÜ]/g, "u")
            .replace(/[éèêëÉÈÊË]/g, "e")
            .replace(/[õóòôöÕÓÒÔÖ]/g, "o")
            .replace(/[çÇ]/g, "c")
            .replace(/[ñÑ]/g, "n")
        else
          return data

    $.extend(true, $.fn.dataTable.defaults, {
      "oLanguage": {
        "sEmptyTable": "Nenhum resultado encontrado"
        "sProcessing": "<span class='loader'></span>"
      }
    })

)


.directive('datatableHeading', [()->
    restrict: 'A'
    require: '^guidelineDatatables'
    link: (scope, element, attrs, controller)->


# check if is the last row at the datatable header and execute drawTable
      if scope.$last

        do controller.scope.drawTable
        return

      return
])

.directive('guidelineDatatables', ['$templateCache','$timeout', ($templateCache, $timeout) ->
    templateUrl: 'guideline/datatables/table.html'
    controller: ($scope)->
      this.scope = $scope
      return
    transclude: true
    restrict: 'EA'
    replace: true
    scope:
      guidelineDatatables: '@'
      options: '='

    link: (scope, element, attrs) ->


# initial element vars
      $table      = undefined
      $listeners  = false
      $buttons    = false


# callback when selecting a row
      selectedRow = (row)->
        scope.options.selectedRow? row, $table

      deleteRow = (row, index)->
        scope.options.deleteRow? row, index, $table

      cbSelected = (isHeaderCb, row)->
        scope.options.cbSelected? isHeaderCb, row

      selectedRows = ()->
        rows = []
        $('tbody > tr.selected', $table).each (index, element)->
          obj.push getRow(this._DT_RowIndex)

        $timeout ->
          scope.options.selectedRows? rows


# GetRow method
      getRow = (index)->
        # scope.options.data[index] || null
        return $table.fnGetData(index)

# watch options data to clear all table content and add it inside javascript
      scope.$watch 'options.config', (newVal, oldVal)->
        if newVal
          if $table
# do setHelpers
            return
      , true

      scope.$on 'dataTables:redraw', () ->
        if $table
          $table._fnReDraw()
          # $("#" + attrs.id + " > thead > tr > th input[type='checkbox']").prop('checked', false);

# Check Checkboxes
      scope.$on 'dataTables:redrawCheckboxes', (event, args) ->
        chechboxesToCheck = args
        for checkbox in chechboxesToCheck
          id = if checkbox.id is undefined then checkbox else checkbox.id
          $("input[type='checkbox'][value='#{id}']").prop('checked', true);
        checkboxesOnTable = $("input[type='checkbox']").not("[value='all']");
        checkboxesChecked = 0
        for checkbox in checkboxesOnTable
          if checkbox.checked
            checkboxesChecked++
          
        checkboxesLength = $("input[type='checkbox']").length - 1;
        if checkboxesLength isnt 0 and checkboxesChecked is checkboxesLength
          $("input[type='checkbox'][value='all']").prop('checked', true);
        

      createArrayString = (list, property)->
        string = ""
        for item, index in list
          string += item[property] if property
          string += item if !property
          if (index + 1) isnt list.length
            string += ", "
          string


      removeListeners = ->
        $listeners = false
        $("##{attrs.id} > tbody > tr button.edit-action").off "click"
        $("##{attrs.id} > tbody > tr button.delete-action").off "click"

        if scope.options.config?.selectable
          $("##{attrs.id} > tbody > tr").off "click"

# set table listeners for selecting row, click in edit button
      setListeners = ->
        if !$listeners

# Edit button listener
          $("##{attrs.id} > tbody > tr button.edit-action, ##{attrs.id} > tbody > tr button.inspect-action").on 'click', ->
            $rowIndex = if scope.options.config.group then this.parentElement.parentElement.parentElement.nextSibling._DT_RowIndex else this.parentElement.parentElement.parentElement._DT_RowIndex
            obj = {}
            angular.forEach getRow($rowIndex), (value, key)->
              obj[key] = value
              return

            $timeout ->
              selectedRow obj

            return

# Link listener
          $("##{attrs.id} > tbody > tr a").on 'click', ->
            if scope.options.config.group and scope.options.config.linkGroupChild
               $rowIndex = this.parentElement.parentElement._DT_RowIndex
            else if scope.options.config.group 
               $rowIndex = this.parentElement.parentElement.nextSibling._DT_RowIndex 
            else 
               $rowIndex = this.parentElement.parentElement._DT_RowIndex
            obj = {}
            angular.forEach getRow($rowIndex), (value, key)->
              obj[key] = value
              return

            $timeout ->
              selectedRow obj

            return

# Checkbox All listener
          $("#" + attrs.id + " > thead > tr > th input[type='checkbox']").off() # Removes previous listeners
          $("#" + attrs.id + " > thead > tr > th input[type='checkbox']").on 'click', ->
            checkbox = $("#" + attrs.id + " > tbody > tr > td input[type='checkbox']")
            obj =
              value: this.checked

            if obj.value
              checkbox.each (i, elem) ->
                $(elem).prop('checked', true)
            else
              checkbox.each (i, elem) ->
                $(elem).prop('checked', false)

            $timeout ->
              cbSelected(yes, obj)

            return

# Checkbox listener
          $("#" + attrs.id + " > tbody > tr > td input[type='checkbox']").on 'click', ->
            allChecked  = false
            checkboxAll = $("#" + attrs.id + " > thead > tr > th input[type='checkbox']")
            checkbox    = $("#" + attrs.id + " > tbody > tr > td input[type='checkbox']")
            $rowIndex   = if scope.options.config.group then this.parentElement.parentElement.nextSibling._DT_RowIndex else this.parentElement.parentElement._DT_RowIndex
            obj         = {}

            angular.forEach getRow($rowIndex), (value, key)->
              obj[key] = value
              return

            unless this.checked
              checkboxAll.prop('checked', false)

            checkbox.each (i, elem) ->
              allChecked = false or elem.checked
            checkboxAll.prop('checked', true) if allChecked

            $timeout ->
              cbSelected(no, obj)

            return

          $("##{attrs.id} > tbody > tr button.delete-action").on 'click', ->
            $rowIndex = if scope.options.config.group then this.parentElement.parentElement.parentElement.nextSibling._DT_RowIndex else this.parentElement.parentElement.parentElement._DT_RowIndex
            obj = {}
            angular.forEach getRow($rowIndex), (value, key)->
              obj[key] = value
              return

            $timeout ->
              deleteRow obj, $rowIndex

            return

# Row Selector listener
          if scope.options.config?.selectable

            $('tbody > tr', $table).on 'click', (event)->
              if event.target.tagName is 'TR' or event.target.tagName is 'TD'
                if $(this).hasClass 'selected'
                  $(this).removeClass 'selected'
                else
                  $(this).addClass 'selected'
                return

# Filter Listener

          $($table).on 'draw', (event) ->
            $("#" + attrs.id + " > thead > tr > th input[type='checkbox']").prop('checked', false);
            scope.$emit 'dataTables:redrawn'

# Window Resize Listener
          $(window).resize ->
            $($table).css(
              width: $($table).parent().parent().width()
            )

# TODO: causing null oFeatures stack error, check the DataTables API for redrawing it correctly
# if $table.fnAdjustColumnSizing
#   do $table.fnAdjustColumnSizing

          $listeners = true

          return

      createGroupOptions = ->
        if scope.grouped
          return
        obj = {}
        obj.bExpandableGrouping = scope.options.config.bExpandableGrouping
        _.defaults obj, scope.options.config?.groupConfig
        if scope.options.config?.group
          $table.rowGrouping obj
          scope.grouped = true
        # createButtons true
        return


# append edit buttons inside each row data
      createButtons = (grouped)->
        if !$buttons and scope.options.config?.actionButtons
          $selector = undefined
          $actionsButton = $templateCache.get 'guideline/datatables/actions-button.html'

          if !scope.options.config.group
            $selector = "tbody > tr"
          else
            $selector = "tbody > tr[id*='group-id-datatable']"

          if scope.options.config.group && !grouped
            return

          $($selector, $table).each(
            (index, element)->
#             if !element.hasClass('')

              $lastCell = $('td', this).last()
              if !$lastCell.hasClass 'dataTables_empty' or !$lastCell.hasClass 'group-item-expander'
                if !$lastCell.hasClass 'action-cell'
                  $lastCell.addClass 'action-cell'
                  $lastCell.prepend($actionsButton)
                  if scope.editButton is false
                    $("button.edit-action", $lastCell).hide()
                  if scope.deleteButton is false
                    $("button.delete-action", $lastCell).hide()
                  if scope.inspectButton is false
                    $("button.inspect-action", $lastCell).hide()
          )
          $buttons = true
        return


# method that determines the use of the helpers and additional configurations like the rowGrouping plugin used inside the sesc-guideline
      setHelpers = ->
        # createButtons false
        do createGroupOptions


# set some configurations to use datatables
      setConfig = ->
        config =
          bInfo: true
          bDeferRender: true
          bServerSide: true
          bProcessing: true

        if scope.options.config

          config = $.extend true, config, scope.options.config

          config.fnDrawCallback = (oSettings) ->
            element.parent().find(".table-footer .dataTables_info").html "Total: #{$table.fnPagingInfo().iTotal}"

          scope.editButton     = if angular.isDefined(scope.options.config.editButton)  then scope.options.config.editButton  else true
          scope.deleteButton   = if angular.isDefined(scope.options.config.deleteButton)  then scope.options.config.deleteButton  else true
          scope.inspectButton  = if angular.isDefined(scope.options.config.inspectButton) then scope.options.config.inspectButton else true

          if config.bPaginate
            config.fnInfoCallback = (oSetting, iStart, iEnd, iMax, iTotal, sPre)->
              $buttons    = false
              if config.group
                createButtons true
              else
                createButtons false
              do removeListeners
              do setListeners


        config

# init method that executes initial configurations
      init = ->

# create config and store in config var to use in dataTable method
        config = do setConfig

# execute dataTable plugin method and store inside $table var to make it exposed
        if !$table
          $table = $("##{attrs.id}").dataTable(config).fnSetFilteringDelay(1000)
          scope.$emit 'dataTables:done', $table

# register helpers
        do setHelpers

# register listeners
        do setListeners

        return


# drawTable method exposed to children's scope to init the datatable
      scope.drawTable = ->
        do init
        return

      return
  ])
