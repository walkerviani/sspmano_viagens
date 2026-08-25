import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/data/datasources/pessoa_datasource.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';
import 'package:sspmano_viagens/domain/repositories/pessoa_repository.dart';

class PessoaRepositoryImpl implements PessoaRepository {
  final AppDatabase _database;

  PessoaRepositoryImpl(this._database);

  @override
  Future<Pessoa?> listarPorId(int id) async {
    final pessoa = await (_database.select(
      _database.pessoas,
    )..where((pessoa) => pessoa.id.equals(id))).getSingleOrNull();

    return pessoa?.toEntity();
  }

  @override
  Future<List<Pessoa>> listarTodos() async {
    final pessoas = await (_database.select(_database.pessoas)).get();
    return pessoas.map((pessoa) => pessoa.toEntity()).toList();
  }

  @override
  Future<void> criar(Pessoa pessoa) async {
    await _database.into(_database.pessoas).insert(pessoa.toCompanion());
  }

  @override
  Future<void> atualizar(Pessoa pessoa) async {
    if (pessoa.id == null) {
      throw ArgumentError('Não é possível atualizar uma pessoa sem id');
    }

    await (_database.update(
      _database.pessoas,
    )..where((p) => p.id.equals(pessoa.id!))).write(pessoa.toCompanion());
  }

  @override
  Future<void> deletar(int id) async {
    await (_database.delete(
      _database.pessoas,
    )..where((pessoa) => pessoa.id.equals(id))).go();
  }
}
