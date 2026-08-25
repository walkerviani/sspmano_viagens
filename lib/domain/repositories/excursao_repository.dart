import 'package:sspmano_viagens/domain/entities/excursao.dart';

abstract class ExcursaoRepository {
  Future<List<Excursao>>listarTodos();
  Future<Excursao>listarPorId(int id);
  Future<void>criar(Excursao excursao);
  Future<void>atualizar(Excursao excursao);
  Future<void>deletar(int id);
  Future<void>finalizarExcursao(int id);
  Future<void>definirQuantidadeAssentos(int id, int qtd);
  Future<void>definirDataHora(int id, DateTime dataHora);
}