$(document).ready(function() {
  var request, bootstrapWithLoggedUser, bootstrapWithoutLoggedUser, bootstrap;

  request = {
    type    : "GET",
    url     : window.config.APP_BASE_URL + 'me',
    headers : { 'Authorization': 'Basic c2VzYzpzZXNj' }
  };

  bootstrapWithLoggedUser = function(result) {
    window.user = result;
    bootstrap();
  }

  bootstrapWithoutLoggedUser = function() {
    window.user = null
    bootstrap();
  }

  bootstrap = function() {
    // Bootstrap da aplicação
    angular.bootstrap(document, ['modeloBase']);
  }

  $.ajax(request).success(bootstrapWithLoggedUser).error(bootstrapWithoutLoggedUser);

});