import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';
import 'package:sspmano_viagens/domain/repositories/pessoa_repository.dart';

class PessoasListViewmodel extends ChangeNotifier {
  final PessoaRepository _repository;

  PessoasListViewmodel(this._repository);
  bool estaCarregando = false;
  String? mensagemErro;
  List<Pessoa> pessoas = [];

  Future<void> carregarPessoas() async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      pessoas = await _repository.listarTodos();
    } catch (e) {
      mensagemErro = 'Erro ao carregar os dados das pessoas';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  Future<bool> deletar(int id) async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();
    try {
      await _repository.deletar(id);
      return true;
    } on Exception catch (e) {
      if (e.toString().contains('constraint failed')) {
        mensagemErro =
            'Não é possível excluir a pessoa, pois ela está associada a outros registros';
      } else {
        mensagemErro = 'Erro ao excluir a pessoa';
      }
      return false;
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }
}
