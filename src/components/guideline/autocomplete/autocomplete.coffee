'use strict'

angular.module('guideline.autocomplete', [])

.directive('guidelineAutocomplete', ['$timeout', '$state', '$http', '$parse', '$interpolate', '$q' , ($timeout, $state, $http, $parse, $interpolate, $q) ->
    restrict    : 'EA'

    link: (scope, element, attrs) ->
      ##################################
      ## Attributes
      ##################################
      items = null
      lastRequestTimeout = null

      ##################################
      ## Methods
      ##################################
      createLabel = (obj) ->
        attrs.label = eval(attrs.label)
        if _.isArray attrs.label
          label = []
          for i in attrs.label
            label.push obj[i] if obj[i]
          return label.join(' - ')
        else
          return obj[attrs.label]


      ##################################
      ## Watchers
      ##################################
      # scope.$watch attrs.ngModel, (newVal, oldVal) ->


      ##################################
      ## Init
      ##################################
      $timeout ->
        if attrs.src
          $(element).autocomplete({
            minLength: 3
            delay: attrs.delay || 500

            source: (request, response) ->
              $http({
                method : 'GET'
                url    : attrs.src
                timeout: lastRequestTimeout.promise
                params : { search: request.term }
              })
              .success (data) ->
                items = _.map(data, (obj) ->
                  result = {}
                  result.label = createLabel(obj)
                  result.value = if attrs.filter then obj[attrs.filter] else obj
                  return result
                )

                response(items)
              .error (err) ->
                $(element).removeClass 'ui-autocomplete-loading'
              .finally ->
                lastRequestTimeout = null

            create: (event, ui) ->
              model = eval("scope." + attrs.ngModel)
              if eval("scope." + attrs.ngModel)
                element.val(createLabel(model))

              event.preventDefault()

            focus: (event, ui) ->
              element.val(ui.item.label)
              event.preventDefault()

            search: (event, ui)->
              if lastRequestTimeout
                lastRequestTimeout.resolve({ data: { message: 'timeout'} })

              lastRequestTimeout = $q.defer()

              return true

            select: (event, ui) ->
              scope.$apply (scope) ->
                $parse(attrs.ngModel).assign(scope, ui.item.value)

              element.val(ui.item.label)

              event.preventDefault()

            change: (event, ui) ->
              currentVal = element.val()
              match = null

              if items
                for obj in items
                  match = obj.label if obj.label is currentVal

              if not match
                scope.$apply (scope) ->
                  $parse(attrs.ngModel).assign(scope, null)
          })

      return
  ])
