angular.module "sescMotoFrete"
  .filter "formatDateInverseFilter", () ->

    return (date) ->
      return moment(date, 'YYYYMMDD').format('DD/MM/YYYY')