angular.module "sescMotoFrete"
  .filter "formatDateFilter", () ->

    return (date) ->
      return moment(date, 'DDMMYYYY').format('DD/MM/YYYY')