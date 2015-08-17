angular.module "modeloBase"
  .filter "formatDateFilter", () ->

    return (date) ->
      return moment(date, 'DDMMYYYY').format('DD/MM/YYYY')