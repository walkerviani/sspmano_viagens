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
  List<Pessoa> todasPessoas = [];
  List<Pessoa> pessoas = [];
  String termoBusca = '';

  Future<void> carregarPessoas(int idExcursao) async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      todasPessoas = await _pessoaRepository.listarTodos();
      final idsOcupados = await _passageiroRepository
          .listarIdsPessoasNaExcursao(idExcursao);
      todasPessoas = todasPessoas
          .where((pessoa) => !idsOcupados.contains(pessoa.id))
          .toList();
      aplicarFiltro(termoBusca);
    } catch (e) {
      mensagemErro = 'Erro ao carregar os usuários';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  void aplicarFiltro(String termo) {
    termoBusca = termo.trim().toLowerCase();

    final List<Pessoa> pessoasFiltradas = termoBusca.isEmpty
        ? List.from(todasPessoas)
        : todasPessoas.where((pessoa) {
            return pessoa.nome.toLowerCase().contains(termoBusca);
          }).toList();

    pessoas = pessoasFiltradas
      ..sort((primeira, segunda) =>
          primeira.nome.toLowerCase().compareTo(
            segunda.nome.toLowerCase(),
          ),
        );

    notifyListeners();
  }

  Future<bool> vincularPassageiro(
    Pessoa pessoa,
    int idVeiculo,
    int numAssento,
    bool foiPago,
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

      final passageiro = Passageiro(
        null,
        idVeiculo,
        pessoa.id,
        numAssento,
        foiPago: foiPago,
      );

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
