class Veiculo {
  // Atributos
  final int? _id;
  final int? _idExcursao;
  int capacidade;

  // Construtor
  Veiculo(
    this._id,
    this._idExcursao,
    this.capacidade, 
  );

   // Getters
  int? get id => _id;
  int? get idExcursao => _idExcursao;

  // Json
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'idExcursao': _idExcursao,
      'capacidade': capacidade,
    };
  }
  factory Veiculo.fromJson(Map<String, dynamic> json) {
    return Veiculo(
      json['id'] as int?,
      json['idExcursao'] as int?,
      json['capacidade'] as int,
    );
  }
}