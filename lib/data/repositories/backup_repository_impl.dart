import 'dart:convert';

import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/data/datasources/backup/backup_config_datasource.dart';
import 'package:sspmano_viagens/data/datasources/backup/backup_file_datasource.dart';
import 'package:sspmano_viagens/data/datasources/backup/json_backup_datasource.dart';
import 'package:sspmano_viagens/data/datasources/excursao_datasource.dart';
import 'package:sspmano_viagens/data/datasources/passageiro_datasource.dart';
import 'package:sspmano_viagens/data/datasources/pessoa_datasource.dart';
import 'package:sspmano_viagens/data/datasources/veiculo_datasource.dart';
import 'package:sspmano_viagens/domain/entities/excursao.dart';
import 'package:sspmano_viagens/domain/entities/passageiro.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';
import 'package:sspmano_viagens/domain/entities/veiculo.dart';
import 'package:sspmano_viagens/domain/repositories/backup_repository.dart';

class BackupRepositoryImpl implements BackupRepository {
  final AppDatabase _database;
  final JsonBackupDatasource _jsonBackup;
  final BackupFileDatasource _arquivo;
  final BackupConfigDatasource _config;

  BackupRepositoryImpl(
    this._database,
    this._jsonBackup,
    this._arquivo,
    this._config,
  );

  @override
  Future<String?> escolherPasta() async { // Abre file picker e salva seleção
    final pasta = await _arquivo.escolherPasta();
    if (pasta != null) {
      await _config.salvarPasta(pasta);
    }
    return pasta;
  }

  @override
  Future<String?> selecionarArquivoBackup() async {
    return _arquivo.escolherArquivoBackup();
  }

  @override
  Future<String?> obterPasta() async { // Retorna pasta configurada
    return _config.obterPasta();
  }

  @override
  Future<String?> obterFrequencia() async { // Retorna frequência configurada
    return _config.obterFrequencia();
  }

  @override
  Future<void> salvarFrequencia(String frequencia) async { // Salva frequência
    await _config.salvarFrequencia(frequencia);
  }

  @override
  Future<void> criarBackup({bool solicitarPermissao = true}) async { // Gera JSON e salva arquivo no disco
    final pasta = await _config.obterPasta();

    if (pasta == null || pasta.isEmpty) {
      throw StateError('Nenhuma pasta de backup foi configurada.');
    }

    final possuiDados = await existeDadosLocais();

    if (!possuiDados) {
      throw StateError('Não existem dados no banco para realizar o backup.');
    }

    final json = await _jsonBackup.gerarJson();

    await _arquivo.salvarBackup(
      pasta: pasta,
      conteudo: json,
      solicitarPermissao: solicitarPermissao,
    );
    await _config.salvarUltimoBackup(DateTime.now());
  }

  @override
  Future<void> restaurarBackup({String? conteudoBackup}) async {
    String? conteudo = conteudoBackup;

    if (conteudo == null || conteudo.isEmpty) {
      final pasta = await _config.obterPasta();

      if (pasta == null || pasta.isEmpty) {
        throw StateError('Nenhuma pasta de backup foi configurada.');
      }

      conteudo = await _arquivo.lerBackup(pasta: pasta);
    }

    if (conteudo == null || conteudo.isEmpty) {
      throw StateError('Nenhum backup encontrado.');
    }

    final backup = jsonDecode(conteudo) as Map<String, dynamic>;

    await _restaurarDatabase(backup);
  }

  @override
  Future<bool> precisaFazerBackup() async {
    final pasta = await _config.obterPasta();
    if (pasta == null || pasta.isEmpty) return false;

    final frequencia = await _config.obterFrequencia();
    if (frequencia == null || frequencia == 'desativado') return false;

    final ultimoBackup = await _config.obterUltimoBackup();
    if (ultimoBackup == null) return true;

    final intervalo = _intervaloParaFrequencia(frequencia);
    return DateTime.now().difference(ultimoBackup) >= intervalo;
  }

  Duration _intervaloParaFrequencia(String? frequencia) {
    switch (frequencia) {
      case 'semanal':
        return const Duration(days: 7);
      case 'mensal':
        return const Duration(days: 30);
      case 'diario':
      default:
        return const Duration(days: 1);
    }
  }

  Future<void> _restaurarDatabase(Map<String, dynamic> backup) async {
    await _database.transaction(() async {
      await _database.delete(_database.passageiros).go();
      await _database.delete(_database.veiculos).go();
      await _database.delete(_database.excursoes).go();
      await _database.delete(_database.pessoas).go();

      for (final json in backup['pessoas'] as List) {
        final pessoa = Pessoa.fromJson(json as Map<String, dynamic>);
        await _database.into(_database.pessoas).insert(pessoa.toCompanion());
      }
      for (final json in backup['excursoes'] as List) {
        final excursao = Excursao.fromJson(json as Map<String, dynamic>);
        await _database.into(_database.excursoes).insert(excursao.toCompanion());
      }
      for (final json in backup['veiculos'] as List) {
        final veiculo = Veiculo.fromJson(json as Map<String, dynamic>);
        await _database.into(_database.veiculos).insert(veiculo.toCompanion());
      }
      for (final json in backup['passageiros'] as List) {
        final passageiro = Passageiro.fromJson(json as Map<String, dynamic>);
        await _database.into(_database.passageiros).insert(passageiro.toCompanion());
      }
    });
  }

  @override
  Future<bool> existeDadosLocais() async {
    final pessoas = await _database.select(_database.pessoas).get();
    final excursoes = await _database.select(_database.excursoes).get();
    final passageiros = await _database.select(_database.passageiros).get();
    final veiculos = await _database.select(_database.veiculos).get();

    return pessoas.isNotEmpty ||
        excursoes.isNotEmpty ||
        passageiros.isNotEmpty ||
        veiculos.isNotEmpty;
  }
}