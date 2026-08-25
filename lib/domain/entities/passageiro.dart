class Passageiro {
  // Atributos
  final int? _id;
  final int _idExcursao;
  int? idPessoa;
  int numeroAssento;
  int idStatusAssento;
  bool foiPago;

  // Construtor
  Passageiro(
    this._id,
    this._idExcursao,
    this.idPessoa,
    this.numeroAssento, {
    this.idStatusAssento = 1,
    this.foiPago = false,
  });

  // Getters
  int? get id => _id;
  int get idExcursao => _idExcursao;

  // Json
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'idExcursao': _idExcursao,
      'idPessoa': idPessoa,
      'numeroAssento': numeroAssento,
      'idStatusAssento': idStatusAssento,
      'foiPago': foiPago,
    };
  }

  factory Passageiro.fromJson(Map<String, dynamic> json) {
    return Passageiro(
      json['id'] as int?,
      json['idExcursao'] as int,
      json['idPessoa'] as int?,
      json['numeroAssento'] as int,
      idStatusAssento: json['idStatusAssento'] as int,
      foiPago: json['foiPago'] as bool,
    );
  }
}
