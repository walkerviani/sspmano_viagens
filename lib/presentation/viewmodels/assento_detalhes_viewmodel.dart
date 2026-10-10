import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/passageiro.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';
import 'package:sspmano_viagens/domain/enums/tipo_ingresso.dart';
import 'package:sspmano_viagens/domain/repositories/passageiro_repository.dart';
import 'package:sspmano_viagens/domain/repositories/pessoa_repository.dart';

class AssentoDetalhesViewmodel extends ChangeNotifier {
  final PassageiroRepository _passageiroRepository;
  final PessoaRepository _pessoaRepository;

  AssentoDetalhesViewmodel(this._passageiroRepository, this._pessoaRepository);
  bool estaCarregando = false;
  bool estaAtualizandoPagamento = false;
  String? mensagemErro;
  Passageiro? passageiro;
  Pessoa? pessoa;
  TipoIngresso? _tipoIngresso;

  TipoIngresso? get tipoIngresso => _tipoIngresso;

  Future<void> carregarPassageiro(int numAssento, int idVeiculo) async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      passageiro = await _passageiroRepository.listarPorAssento(
        idVeiculo,
        numAssento,
      );
      _tipoIngresso = TipoIngresso.deId(passageiro?.tipoIngresso);
    } catch (e) {
      mensagemErro = 'Erro ao carregar o passageiro';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  Future<void> carregarPessoa(int idPessoa) async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      pessoa = await _pessoaRepository.listarPorId(idPessoa);
    } catch (e) {
      mensagemErro = 'Erro ao carregar o usuário';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  Future<bool> deletar(int idPassageiro) async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      final passageiro = await _passageiroRepository.listarPorId(idPassageiro);

      if (passageiro == null) {
        mensagemErro = 'Passageiro não encontrado';
        return false;
      }

      await _passageiroRepository.deletar(idPassageiro);
      return true;
    } catch (e) {
      mensagemErro = 'Erro ao excluir o passageiro';
      return false;
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  Future<bool> atualizarStatusPago(int idPassageiro) async {
    mensagemErro = null;

    estaAtualizandoPagamento = true;
    notifyListeners();

    try {
      final passageiro = await _passageiroRepository.listarPorId(idPassageiro);
      if (passageiro == null) {
        mensagemErro = 'Passageiro não encontrado';
        return false;
      }
      final novoStatusPago = !passageiro.foiPago;
      await _passageiroRepository.definirStatusPagamento(
        idPassageiro,
        novoStatusPago,
      );

      if (this.passageiro?.id == idPassageiro) {
        this.passageiro!.foiPago = novoStatusPago;
      }
      return true;
    } catch (e) {
      mensagemErro = 'Erro ao atualizar o status de pagamento';
      return false;
    } finally {
      estaAtualizandoPagamento = false;
      notifyListeners();
    }
  }

  Future<bool> alterarTipoIngresso(TipoIngresso? valor) async {
    if (valor == null || passageiro == null) return false;
    if (valor == _tipoIngresso) return true;
    final idPassageiro = passageiro!.id!;
    mensagemErro = null;

    try {
      await _passageiroRepository.definirTipoIngresso(idPassageiro, valor.id);

      final atualizado = await _passageiroRepository.listarPorId(idPassageiro);
      passageiro = atualizado;
      _tipoIngresso = TipoIngresso.deId(atualizado?.tipoIngresso);
      return true;
    } catch (e) {
      mensagemErro = 'Erro ao atualizar o tipo de ingresso';
      return false;
    } finally {
      notifyListeners();
    }
  }
}
