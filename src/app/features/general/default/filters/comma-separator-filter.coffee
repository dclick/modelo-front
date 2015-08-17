angular.module "modeloBase"
  .filter "commaSeparator", () ->

    return (number) ->
      return parseFloat(number).toFixed(2).toString().replace(/.([^.]*)$/, ",$1") #replace only the last dot (in case there's others)