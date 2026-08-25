import 'package:drift/drift.dart';

@DataClassName('ExcursaoData')
class Excursoes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text()();
  DateTimeColumn get dataHora => dateTime()();
  IntColumn get qtdAssentos => integer()();
  IntColumn get idStatus => integer()();
}