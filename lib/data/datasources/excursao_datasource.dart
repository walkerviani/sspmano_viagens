import 'package:drift/drift.dart';
import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/domain/entities/excursao.dart';

extension ExcursaoMapper on ExcursaoData {
  Excursao toEntity() {
    return Excursao(
      id,
      nome,
      dataHora,
      qtdAssentos,
      idStatus: idStatus,
    );
  }
}

extension ExcursaoCompanionMapper on Excursao {
  ExcursoesCompanion toCompanion() {
    return ExcursoesCompanion.insert(
      id: id != null ? Value(id!) : const Value.absent(),
      nome: nome,
      dataHora: dataHora,
      qtdAssentos: qtdAssentos,
      idStatus: idStatus,
    );
  }
}