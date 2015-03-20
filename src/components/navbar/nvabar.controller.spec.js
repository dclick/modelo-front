'use strict';

describe('controllers', function(){
  var scope;

  //beforeEach(module('modeloFront.templates'));
  beforeEach(module('modeloFront.components.navbar'));
  //ou carrega o modulo inteiro
  
  //beforeEach(module('modeloFront'));

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
