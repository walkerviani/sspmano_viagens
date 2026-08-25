import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';
import 'package:sspmano_viagens/domain/repositories/pessoa_repository.dart';

class PessoasFormViewmodel extends ChangeNotifier {
  final PessoaRepository _repository;

  PessoasFormViewmodel(this._repository);
  bool estaCarregando = false;
  String? mensagemErro;
  Pessoa? pessoa;

  Future<void> carregarPessoa(int id) async {
    mensagemErro = null;
    estaCarregando = true;
    notifyListeners();

    try {
      pessoa = await _repository.listarPorId(id);
    } catch (e) {
      mensagemErro = 'Erro ao carregar pessoa';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  Future<bool> salvarPessoa({
    int? id,
    required String nome,
    required String cpf,
    required String telefone,
  }) async {
    mensagemErro = null;

    if (nome.trim().isEmpty) {
      mensagemErro = 'O nome não pode estar vazio';
      return false;
    }
    if (cpf.trim().isEmpty) {
      mensagemErro = 'O CPF não pode estar vazio';
      return false;
    }
    if (telefone.trim().isEmpty) {
      mensagemErro = 'O telefone não pode estar vazio';
      return false;
    }
    if (nome.length > 50) {
      mensagemErro = 'O Nome precisa ser menor que 50 caracteres';
      return false;
    }
    if (cpf.length < 11 || cpf.length > 11) {
      mensagemErro = 'O CPF deve ter 11 dígitos';
      return false;
    }

    estaCarregando = true;
    notifyListeners();

    try {
      Pessoa pessoa = Pessoa(id, nome, cpf, telefone);
      if (id != null) {
        await _repository.atualizar(pessoa);
      } else {
        await _repository.criar(pessoa);
      }
      return true;
    } on Exception catch (e) {
      final mensagem = e.toString();
      if (mensagem.contains('UNIQUE') && mensagem.contains('pessoas.cpf')) {
        mensagemErro = 'Uma pessoa com esse CPF já foi registrado';
      }
      if (mensagem.contains('UNIQUE') && mensagem.contains('pessoas.nome')) {
        mensagemErro = 'Uma pessoa com esse nome já foi registrado';
      }
      return false;
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }
}
