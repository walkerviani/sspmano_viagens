import 'package:drift/drift.dart';
import 'package:sspmano_viagens/data/tables/pessoa_table.dart';
import 'package:sspmano_viagens/data/tables/veiculo_table.dart';

@DataClassName('PassageiroData')
class Passageiros extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idVeiculo => integer().references(Veiculos, #id, onDelete: KeyAction.cascade)();
  IntColumn get idPessoa => integer().references(Pessoas, #id, onDelete: KeyAction.restrict).nullable()();
  IntColumn get numeroAssento => integer()();
  BoolColumn get foiPago => boolean()();
  IntColumn get tipoIngresso => integer().withDefault(const Constant(1))(); // Se um passageiro for inserido sem tipoIngresso, o banco usa 1 (INTEIRA)
}
