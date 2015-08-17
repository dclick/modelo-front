'use strict';

describe('filter: idFilter', function(){
  beforeEach(module('sescMotoFrete'));

  // =============================================
  // Tests
  // =============================================
  it('Deve adicionar 0 até completar 5 dígitos', inject(function($filter) {
    var result;

    result = $filter('idFilter')(123)
    expect(result).toBe('00123');
  }));

  it('Não deve adicionar 0 até em números com 5 dígitos', inject(function($filter) {
    var result;

    result = $filter('idFilter')(12345)
    expect(result).toBe('12345');
  }));

  it('Não deve adicionar 0 até em números com mais de 5 dígitos', inject(function($filter) {
    var result;

    result = $filter('idFilter')(12345678)
    expect(result).toBe('12345678');
  }));

  it('Deve adicionar um prefixo caso seja passado comos segundo parametro', inject(function($filter) {
    var result;

    result = $filter('idFilter')(1234, 'SS')
    expect(result).toBe('SS01234');
  }));
});
