angular.module "modeloBase"
  .filter "arrayRepresentationFilter", () ->

    return (array) ->
      formattedArray = array.join(', ');
      formattedArray = formattedArray.replace(/(.*),/, '$1 e');
      return formattedArray