import 'dart:convert';
import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/data/datasources/excursao_datasource.dart';
import 'package:sspmano_viagens/data/datasources/passageiro_datasource.dart';
import 'package:sspmano_viagens/data/datasources/pessoa_datasource.dart';
import 'package:sspmano_viagens/data/datasources/veiculo_datasource.dart';

class JsonBackupDatasource {
  final AppDatabase _database;

  JsonBackupDatasource(this._database);

  Future<String> gerarJson() async {
    final dados = {
      'versao': 1,
      'dataBackup': DateTime.now().toIso8601String(),
      'pessoas': await _exportEntidade(_database.pessoas),
      'excursoes': await _exportEntidade(_database.excursoes),
      'passageiros': await _exportEntidade(_database.passageiros),
      'veiculos': await _exportEntidade(_database.veiculos),
    };

    return const JsonEncoder.withIndent('  ').convert(dados);
  }

  Future<List<dynamic>> _exportEntidade(dynamic table) async {
    final linhas = await _database.select(table).get();

    return linhas.map((linha) {
      if (linha is PessoaData) {
        return linha.toEntity().toJson();
      }

      if (linha is ExcursaoData) {
        return linha.toEntity().toJson();
      }

      if (linha is VeiculoData) {
        return linha.toEntity().toJson();
      }

      if (linha is PassageiroData) {
        return linha.toEntity().toJson();
      }

      throw UnsupportedError('Tipo de dado não suportado para backup: ${linha.runtimeType}');
    }).toList();
  }
}