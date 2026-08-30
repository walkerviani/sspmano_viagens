import 'package:drift/drift.dart';
import 'package:sspmano_viagens/data/tables/excursao_table.dart';

@DataClassName('VeiculoData')
class Veiculos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idExcursao => integer().references(Excursoes, #id).nullable()();
  IntColumn get capacidade => integer()();
}