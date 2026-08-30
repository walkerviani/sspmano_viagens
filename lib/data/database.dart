import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

import 'package:sspmano_viagens/data/tables/excursao_table.dart';
import 'package:sspmano_viagens/data/tables/passageiro_table.dart';
import 'package:sspmano_viagens/data/tables/pessoa_table.dart';
import 'package:sspmano_viagens/data/tables/veiculo_table.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Excursoes,
    Pessoas,
    Passageiros,
    Veiculos,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'sspmano_viagens.db'));
    return NativeDatabase.createInBackground(file);
  });
}