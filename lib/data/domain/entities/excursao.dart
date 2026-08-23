class Excursao {
  // Atributos
  final int? _id;
  String nome;
  DateTime dataHora;  
  String telefone;

  // Construtor
  Excursao(
    this._id,
    this.nome,
    this.dataHora,
    this.telefone,
  );

  // Getters
  int? get id => _id;

  // Json
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'nome': nome,
      'dataHora': dataHora.toIso8601String(),
      'telefone': telefone,
    };
  }
  factory Excursao.fromJson(Map<String, dynamic> json) {
    return Excursao(
      json['id'] as int?,
      json['nome'] as String,
      DateTime.parse(json['dataHora'] as String),
      json['telefone'] as String,
    );
  }
}