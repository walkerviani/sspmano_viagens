import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/excursao.dart';
import 'package:sspmano_viagens/domain/repositories/excursao_repository.dart';

class ExcursoesListViewmodel extends ChangeNotifier {
  final ExcursaoRepository _repository;

  ExcursoesListViewmodel(this._repository);
  bool estaCarregando = false;
  String? mensagemErro;
  List<Excursao> excursoes = [];

  Future<void> carregarExcursoes() async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      excursoes = await _repository.listarTodos();
    } catch (e) {
      mensagemErro = 'Erro ao carregar as excursões';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }
}
