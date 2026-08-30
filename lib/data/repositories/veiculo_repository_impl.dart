import 'package:drift/drift.dart';
import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/data/datasources/veiculo_datasource.dart';
import 'package:sspmano_viagens/domain/entities/veiculo.dart';
import 'package:sspmano_viagens/domain/repositories/veiculo_repository.dart';

class VeiculoRepositoryImpl implements VeiculoRepository {
  final AppDatabase _database;

  VeiculoRepositoryImpl(this._database);

  @override
  Future<Veiculo?> listarPorId(int id) async {
    final veiculo = await (_database.select(
      _database.veiculos,
    )..where((v) => v.id.equals(id))).getSingleOrNull();

    return veiculo?.toEntity();
  }

  @override
  Future<List<Veiculo>> listarTodos() async {
    final veiculos = await (_database.select(
      _database.veiculos,
    )..orderBy([(p) => OrderingTerm.asc(p.id)])).get();

    return veiculos.map((v) => v.toEntity()).toList();
  }

  @override
  Future<List<Veiculo>> listarPorExcursao(int idExcursao) async {
    final veiculos =
        await (_database.select(_database.veiculos)
              ..where((v) => v.idExcursao.equals(idExcursao))
              ..orderBy([(p) => OrderingTerm.asc(p.id)]))
            .get();

    return veiculos.map((v) => v.toEntity()).toList();
  }

  @override
  Future<void> criar(Veiculo veiculo) async {
    await _database.into(_database.veiculos).insert(veiculo.toCompanion());
  }

  @override
  Future<void> atualizar(Veiculo veiculo) async {
    if (veiculo.id == null) {
      throw ArgumentError('Não é possível atualizar um veículo sem id');
    }

    await (_database.update(
      _database.veiculos,
    )..where((v) => v.id.equals(veiculo.id!))).write(veiculo.toCompanion());
  }

  @override
  Future<void> deletar(int id) async {
    await (_database.delete(
      _database.veiculos,
    )..where((v) => v.id.equals(id))).go();
  }
}
