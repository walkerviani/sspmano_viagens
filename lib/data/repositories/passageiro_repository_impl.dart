import 'package:drift/drift.dart';
import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/data/datasources/passageiro_datasource.dart';
import 'package:sspmano_viagens/domain/entities/passageiro.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';
import 'package:sspmano_viagens/domain/repositories/passageiro_repository.dart';

class PassageiroRepositoryImpl implements PassageiroRepository {
  final AppDatabase _database;

  PassageiroRepositoryImpl(this._database);

  @override
  Future<Passageiro?> listarPorId(int id) async {
    final passageiros = await (_database.select(_database.passageiros)
      ..where((p) => p.id.equals(id))).getSingleOrNull();

    return passageiros?.toEntity();
  }

  @override
  Future<List<Passageiro>> listarTodos() async {
    final passageiros = await (_database.select(_database.passageiros)
      ..orderBy([(p) => OrderingTerm.asc(p.numeroAssento)])).get();

    return passageiros.map((p) => p.toEntity()).toList();
  }

  @override
  Future<void> definirStatusAssento(int id, int status) async {
    final passageiro = await listarPorId(id);
    if (passageiro == null) throw ArgumentError('Passageiro não encontrado');
    passageiro.idStatusAssento = status;
    await atualizar(passageiro);
  }

  @override
  Future<void> definirStatusPagamento(int id, bool foiPago) async {
    final passageiro = await listarPorId(id);
    if (passageiro == null) throw ArgumentError('Passageiro não encontrado');
    passageiro.foiPago = foiPago;
    await atualizar(passageiro);
  }

  @override
  Future<void> atualizar(Passageiro passageiro) async {
    if (passageiro.id == null) {
      throw ArgumentError(
        'Não é possível atualizar um passageiro sem id',
      );
    }
    await (_database.update(_database.passageiros)..where((p) => p.id.equals(passageiro.id!))).write(passageiro.toCompanion());
  }

  @override
  Future<void> criar(Passageiro passageiro) async {
    await _database.into(_database.passageiros).insert(passageiro.toCompanion());
  }

  @override
  Future<void> deletar(int id) async {
    await (_database.delete(_database.passageiros)..where((p) => p.id.equals(id))).go();
  }

  @override
  Future<void> adicionarPessoa(int id, Pessoa pessoa) async {
    final passageiro = await listarPorId(id);

    if (passageiro == null) {
      throw ArgumentError('Passageiro não encontrado');
    }

    if (passageiro.idPessoa != null) {
      throw ArgumentError('Este assento já possui uma pessoa');
    }

    passageiro.idPessoa = pessoa.id;
    passageiro.idStatusAssento = 2; // Ocupado

    await atualizar(passageiro);
}

  @override
  Future<void> removerPessoa(int id, Pessoa pessoa) async {
    final passageiros = await listarTodos();

    final passageiro = passageiros.where((p) => p.idPessoa == pessoa.id).firstOrNull;

    if (passageiro == null) {
      throw ArgumentError(
        'A pessoa não está associada a nenhum passageiro',
      );
    }

    passageiro.idPessoa = null;
    passageiro.foiPago = false;
    passageiro.idStatusAssento = 1; // Livre

    await atualizar(passageiro);
  }
}