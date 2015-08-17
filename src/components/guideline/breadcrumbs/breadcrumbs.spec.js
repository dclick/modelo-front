'use strict';

describe('directive: GuidelineBreadcrumbs', function(){
  var $rootScope, $scope, $window, $compile, $timeout, $templateCache, $state, isolateScope, elem;

  beforeEach(module('ui.router'));
  beforeEach(module('guideline.breadcrumbs'));
  beforeEach(module('guideline.breadcrumbs.template'));
  beforeEach(module(function($stateProvider) {
    // $state mock
    $stateProvider
      .state("tipoContrato", {
        abstract : true,
        url      : "/tipocontrato",
        data     : {
          breadcrumb : {
            displayName : 'Tipo de contrato',
            before      : 'Administrativo',
            linkTo      : 'tipoContrato.listar'
          }
        }
      })
      .state("tipoContrato.listar", {
        url  : "",
        data : {
          breadcrumb : {
            displayName : 'Listar'
          }
        }
      });
  }));

  beforeEach(inject(function(_$rootScope_, _$window_, _$compile_, _$timeout_, _$templateCache_, _$state_) {
    $rootScope     = _$rootScope_
    $scope         = $rootScope.$new();
    $window        = _$window_;
    $compile       = _$compile_;
    $timeout       = _$timeout_;
    $templateCache = _$templateCache_;
    $state         = _$state_;

    // =============================================
    // Compile
    // =============================================
    elem         = angular.element("<div guideline-breadcrumbs></div>");
    elem         = $compile(elem)($scope);
    $scope.$digest();
    isolateScope = elem.isolateScope();
  }));

  // =============================================
  // Tests
  // =============================================
  it('Deve montar um array com os estados pais do estado atual e o próprio', inject(function() {
    $state.go('tipoContrato.listar');
    var spy, spy2, expectedOutput;

    spy            = spyOn(isolateScope, 'createStateSequence').and.callThrough();
    spy2           = spyOn(isolateScope, 'copyState').and.callThrough();
    expectedOutput = [
      {abstract : true     , name : 'Administrativo'  , state : 'tipoContrato.listar', active : true},
      {abstract : true     , name : 'Tipo de contrato', state : 'tipoContrato.listar', active : true},
      {abstract : undefined, name : 'Listar'          , state : 'tipoContrato.listar', active : true}
    ]

    $timeout.flush();

    expect(spy).toHaveBeenCalled();
    expect(spy2).toHaveBeenCalled();

    // angular.copy to remove $$hashKey from objects
    expect(angular.copy(isolateScope.states)).toEqual(expectedOutput);
  }));
});
