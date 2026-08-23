class Pessoa {
  // Atributos
  final int? _id;
  String nome;
  String cpf;  
  String telefone;

  // Construtor
  Pessoa(
    this._id,
    this.nome,
    this.cpf,
    this.telefone,
  );

  // Getters
  int? get id => _id;

  // Json
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
    };
  }
  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      json['id'] as int?,
      json['nome'] as String,
      json['cpf'] as String,
      json['telefone'] as String,
    );
  }
}