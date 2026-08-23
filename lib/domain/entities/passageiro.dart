class Passageiro {
  // Atributos
  final int? _id;
  final int? _idExcursao;
  final int? _idPessoa;
  int numeroAssento;
  int idStatusAssento;
  int idStatusPagamento;

  // Construtor
  Passageiro(
    this._id,
    this._idExcursao,
    this._idPessoa,
    this.numeroAssento,
    {
    this.idStatusAssento = 1,
    this.idStatusPagamento = 1,
    }
  );

  // Getters
  int? get id => _id;
  int? get idExcursao => _idExcursao;
  int? get idPessoa => _idPessoa;

  // Json
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'idExcursao': _idExcursao,
      'idPessoa': _idPessoa,
      'numeroAssento': numeroAssento,
      'idStatusAssento': idStatusAssento,
      'idStatusPagamento': idStatusPagamento,
    };
  }
  factory Passageiro.fromJson(Map<String, dynamic> json) {
    return Passageiro(
      json['id'] as int?,
      json['idExcursao'] as int?,
      json['idPessoa'] as int?,
      json['numeroAssento'] as int,
      idStatusAssento: json['idStatusAssento'] as int,
      idStatusPagamento: json['idStatusPagamento'] as int,
    );
  }
}