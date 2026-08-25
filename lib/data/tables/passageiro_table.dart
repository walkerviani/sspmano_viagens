import 'package:drift/drift.dart';
import 'package:sspmano_viagens/data/tables/pessoa_table.dart';
import 'package:sspmano_viagens/data/tables/excursao_table.dart';

@DataClassName('PassageiroData')
class Passageiros extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idExcursao => integer().references(Excursoes, #id)();
  IntColumn get idPessoa => integer().references(Pessoas, #id).nullable()();
  IntColumn get numeroAssento => integer()();
  IntColumn get idStatusAssento => integer()();
  BoolColumn get foiPago => boolean()();
}