'use strict';

describe('controllers', function(){
  var scope;

  //beforeEach(module('redspark.templates'));
  beforeEach(module('redspark.components.navbar'));
  //ou carrega o modulo inteiro
  
  //beforeEach(module('redspark'));

  beforeEach(inject(function($rootScope) {
    scope = $rootScope.$new();
  }));

  it('should be define', inject(function($controller) {
    expect(scope.awesomeThings).toBeUndefined();

    $controller('NavbarCtrl', {
      $scope: scope
    });
    expect(angular.isDate(scope.date)).toBeTruthy();

  }));
});
