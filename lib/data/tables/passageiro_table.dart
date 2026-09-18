import 'package:drift/drift.dart';
import 'package:sspmano_viagens/data/tables/pessoa_table.dart';
import 'package:sspmano_viagens/data/tables/veiculo_table.dart';

@DataClassName('PassageiroData')
class Passageiros extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idVeiculo => integer().references(Veiculos, #id, onDelete: KeyAction.cascade)();
  IntColumn get idPessoa => integer().references(Pessoas, #id).nullable()();
  IntColumn get numeroAssento => integer()();
  BoolColumn get foiPago => boolean()();
}