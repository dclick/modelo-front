'use strict';

describe('filter: valorFilter', function(){
  beforeEach(module('sescMotoFrete'));

  // =============================================
  // Tests
  // =============================================
  describe('Quando é float', function() {
    it('Deve retornar o valor separador por . (Milhar - Float)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')(123456.0)
      expect(result).toBe('123.456,00');
    }));

    it('Deve retornar o valor separador por . (Unidade)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('1.0')
      expect(result).toBe('1,00');
    }));

    it('Deve retornar o valor separador por . (Dezena)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('12.0')
      expect(result).toBe('12,00');
    }));

    it('Deve retornar o valor separador por . (Centena)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('123.0')
      expect(result).toBe('123,00');
    }));

    it('Deve retornar o valor separador por . (Milhar)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('1234.0')
      expect(result).toBe('1.234,00');
    }));

    it('Deve retornar o valor separador por . (Milhares)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('12345.0')
      expect(result).toBe('12.345,00');
    }));

    it('Deve retornar o valor separador por . (Centenas de milhar)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('123456.0')
      expect(result).toBe('123.456,00');
    }));

    it('Deve retornar o valor separador por . (Milhões)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('123456789.0')
      expect(result).toBe('123.456.789,00');
    }));

    it('Deve adicionar o símbolo na frente do valor', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('123456789.0', 'R$')
      expect(result).toBe('R$ 123.456.789,00');
    }));
  });

  describe('Quando não é float', function() {
    it('Deve retornar o valor separador por . (Milhar - Integer)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')(123456, 'R$')
      expect(result).toBe('R$ 123.456,00');
    }));


    it('Deve retornar o valor separador por . (Unidade)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('123', 'R$')
      expect(result).toBe('R$ 1,23');
    }));

    it('Deve retornar o valor separador por . (Dezena)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('1234', 'R$')
      expect(result).toBe('R$ 12,34');
    }));

    it('Deve retornar o valor separador por . (Centena)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('12345', 'R$')
      expect(result).toBe('R$ 123,45');
    }));

    it('Deve retornar o valor separador por . (Milhar)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('123456', 'R$')
      expect(result).toBe('R$ 1.234,56');
    }));

    it('Deve retornar o valor separador por . (Milhares)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('1234567', 'R$')
      expect(result).toBe('R$ 12.345,67');
    }));

    it('Deve retornar o valor separador por . (Centenas de milhar)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('12345678', 'R$')
      expect(result).toBe('R$ 123.456,78');
    }));

    it('Deve retornar o valor separador por . (Milhões)', inject(function($filter) {
      var result;

      result = $filter('valorFilter')('12345678900', 'R$')
      expect(result).toBe('R$ 123.456.789,00');
    }));
  });
});
