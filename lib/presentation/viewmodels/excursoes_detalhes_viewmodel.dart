import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/repositories/excursao_repository.dart';

class ExcursoesDetalhesViewmodel extends ChangeNotifier {
  final ExcursaoRepository _excursaoRepository;

  bool estaCarregando = false;
  String? mensagemErro;

  ExcursoesDetalhesViewmodel(this._excursaoRepository);

  Future<bool> deletar(int idExcursao) async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      final excursao = await _excursaoRepository.listarPorId(idExcursao);

      if (excursao == null) {
        mensagemErro = 'Excursão não encontrada';
        return false;
      }

      await _excursaoRepository.deletar(idExcursao);
      return true;
    } catch (e) {
      mensagemErro = 'Erro ao excluir a excursão';
      return false;
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }
}
