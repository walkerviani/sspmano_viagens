import 'package:sspmano_viagens/data/dto/passageiro_com_pessoa_dto.dart';
import 'package:sspmano_viagens/domain/entities/passageiro.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';

abstract class PassageiroRepository {
  Future<List<Passageiro>> listarTodos();
  Future<Passageiro?> listarPorId(int id);
  Future<Passageiro?> listarPorAssento(int idVeiculo, int numAssento);
  Future<List<Passageiro>> listarPorVeiculo(int idVeiculo);
  Future<List<PassageiroComPessoaDto>> listarPorExcursao(int idExcursao);
  Future<List<int>> listarIdsPessoasNaExcursao(int idExcursao);
  Future<void> criar(Passageiro passageiro);
  Future<void> atualizar(Passageiro passageiro);
  Future<void> deletar(int id);
  Future<void> deletarPorVeiculo(int idVeiculo);
  Future<void> adicionarPessoa(int id, Pessoa pessoa);
  Future<void> removerPessoa(int id, Pessoa pessoa);
  Future<void> definirStatusAssento(int id, int status);
  Future<void> definirStatusPagamento(int id, bool foiPago);
}
