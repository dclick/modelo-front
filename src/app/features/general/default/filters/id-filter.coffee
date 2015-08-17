angular.module "modeloBase"
  .filter "idFilter", () ->

    return (id, prefix) ->
      regex = /\d{5}/ # Número de [0-9] exatamente 5 vezes
      padding = "0"

      # Adiciona padding
      while not regex.test(id)
        id = padding + id

      # Adiciona prefixo, se houver
      id = prefix + id if prefix

      return id.toString()