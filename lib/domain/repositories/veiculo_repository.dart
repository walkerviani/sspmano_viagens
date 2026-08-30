import 'package:sspmano_viagens/domain/entities/veiculo.dart';

abstract class VeiculoRepository {
  Future<List<Veiculo>> listarTodos();
  Future<Veiculo?> listarPorId(int id);
  Future<List<Veiculo>> listarPorExcursao(int idExcursao);
  Future<void> criar(Veiculo veiculo);
  Future<void> atualizar(Veiculo veiculo);
  Future<void> deletar(int id);
}
