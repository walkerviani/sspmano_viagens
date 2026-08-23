class Passageiro {
  // Atributos
  final int? _id;
  final int? _idExcursao;
  final int? _idPessoa;
  int numeroAssento;
  final int _idStatusAssento;
  final int _idStatusPagamento;

  // Construtor
  Passageiro(
    this._id,
    this._idExcursao,
    this._idPessoa,
    this.numeroAssento,
    this._idStatusAssento,
    this._idStatusPagamento,
  );

  // Getters
  int? get id => _id;
  int? get idExcursao => _idExcursao;
  int? get idPessoa => _idPessoa;
  int get idStatusAssento => _idStatusAssento;
  int get idStatusPagamento => _idStatusPagamento;

  // Json
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'idExcursao': _idExcursao,
      'idPessoa': _idPessoa,
      'numeroAssento': numeroAssento,
      'idStatusAssento': _idStatusAssento,
      'idStatusPagamento': _idStatusPagamento,
    };
  }
  factory Passageiro.fromJson(Map<String, dynamic> json) {
    return Passageiro(
      json['id'] as int?,
      json['idExcursao'] as int?,
      json['idPessoa'] as int?,
      json['numeroAssento'] as int,
      json['idStatusAssento'] as int,
      json['idStatusPagamento'] as int,
    );
  }
}