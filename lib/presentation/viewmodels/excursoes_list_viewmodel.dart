import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/excursao.dart';
import 'package:sspmano_viagens/domain/repositories/excursao_repository.dart';

class ExcursoesListViewmodel extends ChangeNotifier {
  final ExcursaoRepository _repository;

  ExcursoesListViewmodel(this._repository);
  bool estaCarregando = false;
  String? mensagemErro;
  List<Excursao> todasExcursoes = [];
  List<Excursao> excursoes = [];
  String termoBusca = '';

  Future<void> carregarExcursoes() async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      todasExcursoes = await _repository.listarTodos();
      aplicarFiltro(termoBusca);
    } catch (e) {
      mensagemErro = 'Erro ao carregar as excursões';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  void aplicarFiltro(String termo) {
    termoBusca = termo.trim().toLowerCase();

    if (termoBusca.isEmpty) {
      excursoes = List.from(todasExcursoes);
      notifyListeners();
      return;
    }

    excursoes = todasExcursoes.where((excursao) {
      final nome = excursao.nome.toLowerCase();
      return nome.contains(termoBusca);
    }).toList();

    notifyListeners();
  }
}
