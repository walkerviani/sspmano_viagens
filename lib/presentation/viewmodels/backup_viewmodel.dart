// backup_viewmodel.dart
import 'package:flutter/foundation.dart';
import 'package:sspmano_viagens/data/services/backup_background_service.dart';
import 'package:sspmano_viagens/domain/repositories/backup_repository.dart';

enum FrequenciaBackup { diario, semanal, mensal, desativado }

class BackupViewModel extends ChangeNotifier {
  final BackupRepository _repository;

  BackupViewModel(this._repository);

  String? pasta;
  FrequenciaBackup frequencia = FrequenciaBackup.desativado;
  bool carregando = false;
  String? erro;
  bool sucesso = false;

  Future<void> inicializar() async {
    _resetState();
    carregando = true;
    notifyListeners();

    try {
      pasta = await _repository.obterPasta();
      final freq = await _repository.obterFrequencia();
      frequencia = _parseFrequencia(freq ?? 'desativado');
    } catch (e) {
      erro = 'Erro ao carregar configurações: $e';
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<void> escolherPasta() async { // Abre seletor de pasta e salva a escolha no repositório
    _resetState();
    try {
      final novaPasta = await _repository.escolherPasta();
      if (novaPasta != null) pasta = novaPasta;
    } catch (e) {
      erro = 'Erro ao escolher pasta: $e';
    }
    notifyListeners();
  }

  Future<void> alterarFrequencia(FrequenciaBackup novaFrequencia) async {
    _resetState();
    try {
      await _repository.salvarFrequencia(novaFrequencia.name);
      await BackupBackgroundService.scheduleIfEnabled();
      frequencia = novaFrequencia;
    } catch (e) {
      erro = 'Erro ao salvar frequência: $e';
    }
    notifyListeners();
  }

  Future<void> criarBackup() => executarOperacao(
    _repository.criarBackup,
    'backup',
  );

  Future<void> restaurarBackup() => executarOperacao(
    _repository.restaurarBackup,
    'restauração',
  );

  Future<void> executarOperacao( // Método genérico que gerencia estado de carregamento/erro para backup e restauração
    Future<void> Function() operacao,
    String nome,
  ) async {
    _resetState();
    carregando = true;
    notifyListeners();

    try {
      await operacao();
      sucesso = true;
    } catch (e) {
      erro = 'Erro ao realizar $nome: $e';
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  void _resetState() {
    erro = null;
    sucesso = false;
  }

  FrequenciaBackup _parseFrequencia(String valor) { // Converte string armazenada em enum FrequenciaBackup
    return FrequenciaBackup.values.firstWhere((f) => f.name == valor, orElse: () => FrequenciaBackup.desativado);
  }
}