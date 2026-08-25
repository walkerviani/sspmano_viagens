import 'package:drift/drift.dart';
import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';

extension PessoaMapper on PessoaData {
  Pessoa toEntity() {
    return Pessoa(
      id,
      nome,
      cpf,
      telefone,
    );
  }
}

extension PessoaCompanionMapper on Pessoa {
  PessoasCompanion toCompanion() {
    return PessoasCompanion.insert(
      id: id != null ? Value(id!) : const Value.absent(),
      nome: nome,
      cpf: cpf,
      telefone: telefone,
    );
  }
}