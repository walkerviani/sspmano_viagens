import 'package:drift/drift.dart';

@DataClassName('PessoaData')
class Pessoas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text().unique()();
  TextColumn get cpf => text().unique()();
  TextColumn get telefone => text()();
}