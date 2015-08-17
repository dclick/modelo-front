'use strict'

angular.module "modeloBase"
  .filter "propsFilter", () ->
    (items, props) ->
      out = []

      if angular.isArray(items)
        items.forEach (item) ->
          itemMatches = false

          keys = Object.keys(props)
          for i of keys
            prop = keys[i]
            text = props[prop].toLowerCase()

            if item[prop].toString().toLowerCase().indexOf(text) > -1
              itemMatches = true
              break

          if itemMatches
            out.push(item)
      else
        # Let the output be the input untouched
        out = items

      return out
