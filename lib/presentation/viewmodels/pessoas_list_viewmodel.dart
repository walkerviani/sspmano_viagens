import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';
import 'package:sspmano_viagens/domain/repositories/pessoa_repository.dart';

class PessoasListViewmodel extends ChangeNotifier {
  final PessoaRepository _repository;

  PessoasListViewmodel(this._repository);
  bool estaCarregando = false;
  String? mensagemErro;
  List<Pessoa> todasPessoas = [];
  List<Pessoa> pessoas = [];
  String termoBusca = '';

  Future<void> carregarPessoas() async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      todasPessoas = await _repository.listarTodos();
      aplicarFiltro(termoBusca);
    } catch (e) {
      mensagemErro = 'Erro ao carregar os dados das pessoas';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  void aplicarFiltro(String termo) {
    termoBusca = termo.trim().toLowerCase();

    if (termoBusca.isEmpty) {
      pessoas = List.from(todasPessoas);
      notifyListeners();
      return;
    }

    pessoas = todasPessoas.where((pessoa) {
      final nome = pessoa.nome.toLowerCase();
      final cpf = pessoa.cpf.toLowerCase();
      final telefone = pessoa.telefone.toLowerCase();

      return nome.contains(termoBusca) ||
          cpf.contains(termoBusca) ||
          telefone.contains(termoBusca);
    }).toList();

    notifyListeners();
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
