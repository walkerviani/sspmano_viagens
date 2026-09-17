import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/passageiro.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';
import 'package:sspmano_viagens/domain/repositories/passageiro_repository.dart';
import 'package:sspmano_viagens/domain/repositories/pessoa_repository.dart';

class SelecionarPassageiroViewmodel extends ChangeNotifier {
  final PessoaRepository _pessoaRepository;
  final PassageiroRepository _passageiroRepository;

  SelecionarPassageiroViewmodel(
    this._pessoaRepository,
    this._passageiroRepository,
  );
  bool estaCarregando = false;
  String? mensagemErro;
  List<Pessoa> pessoas = [];

  Future<void> carregarPessoas() async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      pessoas = await _pessoaRepository.listarTodos();
    } catch (e) {
      mensagemErro = 'Erro ao carregar os usuários';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  Future<bool> vincularPassageiro(
    Pessoa pessoa,
    int idVeiculo,
    int numAssento,
  ) async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      final passageiroExistente = await _passageiroRepository.listarPorAssento(
        idVeiculo,
        numAssento,
      );

      if (passageiroExistente != null) {
        mensagemErro = 'Este assento já está ocupado';
        return false;
      }

      final passageiro = Passageiro(null, idVeiculo, pessoa.id, numAssento);

      await _passageiroRepository.criar(passageiro);
      return true;
    } catch (e) {
      mensagemErro = 'Erro ao vincular o passageiro';
      return false;
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }
}
