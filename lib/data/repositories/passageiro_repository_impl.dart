import 'package:drift/drift.dart';
import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/data/datasources/passageiro_datasource.dart';
import 'package:sspmano_viagens/data/datasources/pessoa_datasource.dart';
import 'package:sspmano_viagens/data/dto/passageiro_com_pessoa_dto.dart';
import 'package:sspmano_viagens/domain/entities/passageiro.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';
import 'package:sspmano_viagens/domain/repositories/passageiro_repository.dart';

class PassageiroRepositoryImpl implements PassageiroRepository {
  final AppDatabase _database;

  PassageiroRepositoryImpl(this._database);

  @override
  Future<Passageiro?> listarPorId(int id) async {
    final passageiro = await (_database.select(
      _database.passageiros,
    )..where((p) => p.id.equals(id))).getSingleOrNull();

    return passageiro?.toEntity();
  }

  @override
  Future<List<int>> listarIdsPessoasNaExcursao(int idExcursao) async {
    final resultados = await (_database.select(_database.passageiros).join([
      innerJoin(
        _database.veiculos,
        _database.passageiros.idVeiculo.equalsExp(_database.veiculos.id),
      ),
    ])..where(_database.veiculos.idExcursao.equals(idExcursao))).get();
    return resultados
        .map((r) => r.readTable(_database.passageiros).idPessoa)
        .whereType<int>()
        .toList();
  }

  @override
  Future<Passageiro?> listarPorAssento(int idVeiculo, int numAssento) async {
    final passageiro =
        await (_database.select(_database.passageiros)..where(
              (p) =>
                  p.idVeiculo.equals(idVeiculo) &
                  p.numeroAssento.equals(numAssento),
            ))
            .getSingleOrNull();

    return passageiro?.toEntity();
  }

  @override
  Future<List<Passageiro>> listarTodos() async {
    final passageiros = await (_database.select(
      _database.passageiros,
    )..orderBy([(p) => OrderingTerm.asc(p.numeroAssento)])).get();

    return passageiros.map((p) => p.toEntity()).toList();
  }

  @override
  Future<List<Passageiro>> listarPorVeiculo(int idVeiculo) async {
    final passageiros = await (_database.select(
      _database.passageiros,
    )..where((p) => p.idVeiculo.equals(idVeiculo))).get();

    return passageiros.map((p) => p.toEntity()).toList();
  }

  @override
  Future<List<PassageiroComPessoaDto>> listarPorExcursao(int idExcursao) async {
    final resultados =
        await (_database.select(_database.passageiros).join([
              innerJoin(
                _database.veiculos,
                _database.passageiros.idVeiculo.equalsExp(
                  _database.veiculos.id,
                ),
              ),
              innerJoin(
                _database.pessoas,
                _database.passageiros.idPessoa.equalsExp(_database.pessoas.id),
              ),
            ])..where(
              _database.veiculos.idExcursao.equals(idExcursao) &
                  _database.passageiros.idPessoa.isNotNull(),
            ))
            .get();

    return resultados.map((resultado) {
      return PassageiroComPessoaDto(
        passageiro: resultado.readTable(_database.passageiros).toEntity(),
        pessoa: resultado.readTable(_database.pessoas).toEntity(),
      );
    }).toList();
  }

  @override
  Future<void> definirStatusAssento(int id, int status) async {
    final passageiro = await listarPorId(id);
    if (passageiro == null) throw ArgumentError('Passageiro não encontrado');
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
      throw ArgumentError('Não é possível atualizar um passageiro sem id');
    }
    await (_database.update(_database.passageiros)
          ..where((p) => p.id.equals(passageiro.id!)))
        .write(passageiro.toCompanion());
  }

  @override
  Future<void> criar(Passageiro passageiro) async {
    await _database
        .into(_database.passageiros)
        .insert(passageiro.toCompanion());
  }

  @override
  Future<void> deletar(int id) async {
    await (_database.delete(
      _database.passageiros,
    )..where((p) => p.id.equals(id))).go();
  }

  @override
  Future<void> deletarPorVeiculo(int idVeiculo) async {
    await (_database.delete(_database.passageiros)..where((p) => p.idVeiculo.equals(idVeiculo))).go();
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

    await atualizar(passageiro);
  }

  @override
  Future<void> removerPessoa(int id, Pessoa pessoa) async {
    final passageiros = await listarTodos();

    final passageiro = passageiros
        .where((p) => p.idPessoa == pessoa.id)
        .firstOrNull;

    if (passageiro == null) {
      throw ArgumentError('A pessoa não está associada a nenhum passageiro');
    }

    passageiro.idPessoa = null;
    passageiro.foiPago = false;

    await atualizar(passageiro);
  }
}
