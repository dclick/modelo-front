angular.module "modeloBase"
  .filter "formatDateTimeFilter", () ->

    return (date) ->
      return moment(date, 'YYYYMMDD hh:mm').format('DD/MM/YYYY - HH:mm')