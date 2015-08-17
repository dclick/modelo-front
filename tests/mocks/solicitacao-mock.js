angular.module('modeloBase.mocks')
  .constant('SolicitacaoMock', {
    "id": 1,
    "situacao": "APROVADO",
    "unidade": {
      "id"        : 1,
      "idUnidade" : 1,
      "nome"      : "Unidade 1",
      "sigla"     : "UNIDADE1"
    },
    "data": "15/04/2016",
    "prioridade": {
      "id": 1,
      "nome": "Prioridade 1"
    },
    "solicitante": {
      "id": 1,
      "nome": "Solicitante 1"
    },
    "conta": {
      "id": 510000,
      "descricao": "Conta 510000",
      "complemento": null
    },
    "cce": {
      "id": 1,
      "nome": "CCE 1"
    },
    "formato": {
      "id": 1,
      "nome": "Formato 1"
    },
    "pesoAproximado": 21.5,
    "altura": 10,
    "largura": 9.3,
    "profundidade": 4.7,
    "tipoSolicitacao": {
      "id": 1
    },
    "cep": "14802280",
    "uf": "SP",
    "cidade": "Araraquara",
    "logradouro": "Rua Logradouro",
    "numero": 123,
    "complemento": "Complemento",
    "contato": "Fulano"
  });