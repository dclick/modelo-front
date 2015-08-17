'use strict';

describe('directive: GuidelineApplicationNavbar', function(){
  var $rootScope, $scope, $window, $compile, $timeout, $state, $templateCache, isolateScope, elem;

  beforeEach(module('sescMotoFrete'));
  beforeEach(module('pascalprecht.translate'));
  beforeEach(module('guideline.application-navbar.template'));

  // Angular Translates
  beforeEach(module('sescMotoFrete', function ($translateProvider) {
    $translateProvider.translations('pt-BR', {});
  }));

  beforeEach(inject(function(_$rootScope_, _$window_, _$compile_, _$timeout_, _$state_, _$templateCache_) {
    $rootScope     = _$rootScope_
    $scope         = $rootScope.$new();
    $window        = _$window_;
    $compile       = _$compile_;
    $timeout       = _$timeout_;
    $state         = _$state_;
    $templateCache = _$templateCache_;

    // =============================================
    // User info
    // =============================================
    $rootScope.user = {
      authorities: []
    };

    // $templateCache.get('guideline/application-navbar/application-navbar.html');
    // =============================================
    // Compile
    // =============================================
    elem = angular.element("<div application-navbar></div>");
    elem = $compile(elem)($scope);
    $scope.$digest();
    isolateScope = elem.isolateScope();
  }));

  // =============================================
  // Tests
  // =============================================
  it('Deve invocar $window.close ao clicar em Sair', inject(function() {
    // $state.transitionTo('acervo.listar');
    // $rootScope.$digest()

    var spy, spy2;

    spy  = spyOn($window, 'confirm').and.returnValue(true);
    spy2 = spyOn($window, 'close');

    isolateScope.closeApplication();

    expect(spy).toHaveBeenCalled();
    expect(spy2).toHaveBeenCalled();
  }));
});
