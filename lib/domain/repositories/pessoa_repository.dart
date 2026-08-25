import 'package:sspmano_viagens/domain/entities/pessoa.dart';

abstract class PessoaRepository {
  Future<List<Pessoa>> listarTodos();
  Future<Pessoa?> listarPorId(int id);
  Future<void> criar(Pessoa pessoa);
  Future<void> atualizar(Pessoa pessoa);
  Future<void> deletar(int id);
}
