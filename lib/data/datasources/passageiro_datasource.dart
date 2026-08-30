import 'package:drift/drift.dart';
import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/domain/entities/passageiro.dart';

extension PassageiroMapper on PassageiroData {
  Passageiro toEntity() {
    return Passageiro(
      id,
      idVeiculo,
      idPessoa,
      numeroAssento,
      idStatusAssento: idStatusAssento,
      foiPago: foiPago,
    );
  }
}

extension PassageiroCompanionMapper on Passageiro {
  PassageirosCompanion toCompanion() {
    return PassageirosCompanion.insert(
      id: id != null ? Value(id!) : const Value.absent(),
      idVeiculo: idVeiculo,
      idPessoa: idPessoa != null ? Value(idPessoa!) : const Value.absent(),
      numeroAssento: numeroAssento,
      idStatusAssento: idStatusAssento,
      foiPago: foiPago,
    );
  }
}