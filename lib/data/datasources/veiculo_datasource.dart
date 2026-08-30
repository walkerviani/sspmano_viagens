import 'package:drift/drift.dart';
import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/domain/entities/veiculo.dart';

extension VeiculoMapper on VeiculoData {
  Veiculo toEntity() {
    return Veiculo(
      id,
      idExcursao,
      capacidade,
    );
  }
}

extension VeiculoCompanionMapper on Veiculo {
  VeiculosCompanion toCompanion() {
    return VeiculosCompanion.insert(
      id: id != null ? Value(id!) : const Value.absent(),
      idExcursao: idExcursao != null ? Value(idExcursao!) : const Value.absent(),
      capacidade: capacidade,
    );
  }
}