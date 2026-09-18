import 'package:shared_preferences/shared_preferences.dart';

class BackupConfigDatasource {
  static const chavePasta = 'backup_pasta';
  static const chaveFrequencia = 'backup_frequencia';
  static const chaveUltimoBackup = 'backup_ultimo';

  late final SharedPreferences _preferences;
  bool inicializado = false;

  Future<void> inicializacaoCache() async { // Inicializa SharedPreferences uma única vez (cache)
    if (!inicializado) {
      _preferences = await SharedPreferences.getInstance();
      inicializado = true;
    }
  }

  Future<String?> obterPasta() async { // Recupera caminho da pasta salvo em SharedPreferences
    await inicializacaoCache();
    return _preferences.getString(chavePasta);
  }

  Future<String?> obterFrequencia() async { // Recupera frequência salva em SharedPreferences
    await inicializacaoCache();
    return _preferences.getString(chaveFrequencia);
  }

  Future<DateTime?> obterUltimoBackup() async { // Recupera data do último backup salvo e converte para DateTime
    await inicializacaoCache();
    final valor = _preferences.getString(chaveUltimoBackup);
    return valor != null ? DateTime.tryParse(valor) : null;
  }

  Future<void> salvarPasta(String pasta) async { // Armazena caminho da pasta em SharedPreferences
    await inicializacaoCache();
    await _preferences.setString(chavePasta, pasta);
  }

  Future<void> salvarFrequencia(String frequencia) async { // Armazena frequência em SharedPreferences
    await inicializacaoCache();
    await _preferences.setString(chaveFrequencia, frequencia);
  }

  Future<void> salvarUltimoBackup(DateTime data) async { // Armazena data do último backup em SharedPreferences
    await inicializacaoCache();
    await _preferences.setString(chaveUltimoBackup, data.toIso8601String());
  }
}