angular.module "sescMotoFrete"
  .filter "cep", () ->

    return (cep) ->
      return cep.substr(0, 5) + '-' + cep.substr(5)