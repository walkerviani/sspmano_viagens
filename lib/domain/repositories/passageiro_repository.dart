import 'package:sspmano_viagens/domain/entities/passageiro.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';

abstract class PassageiroRepository {
  Future<List<Passageiro>>listarTodos();
  Future<Passageiro>listarPorId(int id);
  Future<void>criar(Passageiro passageiro);
  Future<void>atualizar(Passageiro passageiro);
  Future<void>deletar(int id);
  Future<void>adicionarPessoa(Pessoa pessoa);
  Future<void>removerPessoa(Pessoa pessoa);
  Future<void>definirStatusAssento(int status);
  Future<void>definirStatusPagamento(bool estaPago);
}