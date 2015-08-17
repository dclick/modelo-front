angular.module "modeloBase"
  .filter "valorFilter", () ->

    return (valor, currency) ->
      result = []

      if typeof valor is 'number' then valor = valor.toFixed(2) else valor = valor.toString()

      if valor.indexOf('.') is -1
        dinheiro = valor.replace(/(.+)([^.]{2})$/, '$1')
        centavos = valor.replace(/(.+)([^.]{2})$/, '$2')
      else
        dinheiro = valor.replace(/^(\d+).(\d{1,})$/, '$1')
        centavos = valor.replace(/^(\d+).(\d{1,})$/, '$2')
      if centavos.length is 1 then result.push("#{centavos}0") else result.push(centavos)

      while /(\d{3})$/g.test(dinheiro)
        digitos  = dinheiro.match(/(\d{3})$/g)[0]
        dinheiro = dinheiro.replace(/(\d{3})$/g, '')
        result.push(digitos)

      result.push(dinheiro) if dinheiro.length
      result = result.reverse().join('.')
      result = result.replace(/.([^.]*)$/, ',$1')
      result = "#{currency} #{result}" if currency

      return result