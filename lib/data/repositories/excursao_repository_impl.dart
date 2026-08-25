import 'package:drift/drift.dart';
import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/data/datasources/excursao_datasource.dart';
import 'package:sspmano_viagens/domain/entities/excursao.dart';
import 'package:sspmano_viagens/domain/repositories/excursao_repository.dart';

class ExcursaoRepositoryImpl implements ExcursaoRepository {
  final AppDatabase _database;

  ExcursaoRepositoryImpl(this._database);

  @override
  Future<Excursao?> listarPorId(int id) async {
    final excursoes = await (_database.select(_database.excursoes)
      ..where((e) => e.id.equals(id))).getSingleOrNull();

    return excursoes?.toEntity();
  }

  @override
  Future<List<Excursao>> listarTodos() async {
    final excursoes = await (_database.select(_database.excursoes)
      ..orderBy([(p) => OrderingTerm.asc(p.id)])).get();

    return excursoes.map((p) => p.toEntity()).toList();
  }

  @override
  Future<void> atualizar(Excursao excursao) async {
    if (excursao.id == null) {
      throw ArgumentError(
        'Não é possível atualizar uma excursão sem id',
      );
    }
    await (_database.update(_database.excursoes)..where((e) => e.id.equals(excursao.id!))).write(excursao.toCompanion());
  }

  @override
  Future<void> criar(Excursao excursao) async {
    await _database.into(_database.excursoes).insert(excursao.toCompanion());
  }

  @override
  Future<void> deletar(int id) async {
    await (_database.delete(_database.excursoes)..where((e) => e.id.equals(id))).go();
  }

  @override
  Future<void> definirDataHora(int id, DateTime dataHora) async {
    final excursao = await listarPorId(id);
    if (excursao == null) throw ArgumentError('Excursão não encontrada');
    excursao.dataHora = dataHora;
    await atualizar(excursao);
  }

  @override
  Future<void> definirQuantidadeAssentos(int id, int qtd) async {
    final excursao = await listarPorId(id);
    if (excursao == null) throw ArgumentError('Excursão não encontrada');
    excursao.qtdAssentos = qtd;
    await atualizar(excursao);
  } 

  @override
  Future<void> finalizarExcursao(int id) async {
    final excursao = await listarPorId(id);
    if (excursao == null) throw ArgumentError('Excursão não encontrada');
    excursao.idStatus = 2;
    await atualizar(excursao);
  }
}