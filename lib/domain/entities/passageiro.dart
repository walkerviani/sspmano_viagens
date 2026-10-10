class Passageiro {
  // Atributos
  final int? _id;
  final int _idVeiculo;
  int? idPessoa;
  int numeroAssento;
  bool foiPago;
  int tipoIngresso;

  // Construtor
  Passageiro(
    this._id,
    this._idVeiculo,
    this.idPessoa,
    this.numeroAssento, {
    this.foiPago = false,
    this.tipoIngresso = 1
  });

  // Getters
  int? get id => _id;
  int get idVeiculo => _idVeiculo;

  // Json
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'idVeiculo': _idVeiculo,
      'idPessoa': idPessoa,
      'numeroAssento': numeroAssento,
      'foiPago': foiPago,
      'tipoIngresso': tipoIngresso,
    };
  }

  factory Passageiro.fromJson(Map<String, dynamic> json) {
    return Passageiro(
      json['id'] as int?,
      json['idVeiculo'] as int,
      json['idPessoa'] as int?,
      json['numeroAssento'] as int,
      foiPago: json['foiPago'] as bool,
      tipoIngresso: json['tipoIngresso'] as int,
    );
  }
}
