import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';
import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/data/datasources/backup/backup_config_datasource.dart';
import 'package:sspmano_viagens/data/datasources/backup/backup_file_datasource.dart';
import 'package:sspmano_viagens/data/datasources/backup/json_backup_datasource.dart';
import 'package:sspmano_viagens/data/repositories/backup_repository_impl.dart';

const String _backupTaskName = 'sspmano_viagens.backup_periodic';

class BackupBackgroundService {
  static Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher);
    await scheduleIfEnabled();
  }

  static Future<void> scheduleIfEnabled() async { // Registra tarefa periódica se frequência não estiver desativada; cancela se desativada
    final config = BackupConfigDatasource();
    final frequencia = await config.obterFrequencia();

    if (frequencia == null || frequencia == 'desativado') {
      await Workmanager().cancelByUniqueName(_backupTaskName);
      return;
    }

    await Workmanager().registerPeriodicTask(
      _backupTaskName,
      _backupTaskName,
      frequency: _intervalForFrequencia(frequencia),
      initialDelay: const Duration(minutes: 1),
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
    );
  }

  static Duration _intervalForFrequencia(String frequencia) => switch (frequencia) { // Retorna duração (7 dias, 30 dias ou 1 dia) conforme frequência
    'semanal' => const Duration(days: 7),
    'mensal' => const Duration(days: 30),
    _ => const Duration(seconds: 10), // default
  };

  static Future<void> cancel() => Workmanager().cancelByUniqueName(_backupTaskName);

}

@pragma('vm:entry-point')
void callbackDispatcher() { // Função executada em background; verifica se precisa fazer backup e executa
  Workmanager().executeTask((taskName, inputData) async {
    try {
      final repo = BackupRepositoryImpl(
        AppDatabase(),
        JsonBackupDatasource(AppDatabase()),
        BackupFileDatasource(),
        BackupConfigDatasource(),
      );

      if (await repo.precisaFazerBackup()) {
        await repo.criarBackup();
      }
      return true;
    } catch (error, stackTrace) {
      debugPrint('Erro ao realizar o backup em background: $error\n$stackTrace');

      // O plugin de notificações não deve ser inicializado no isolate de background,
      // porque o contexto Android fica indisponível e isso gera NPE.
      return true;
    }
  });
}