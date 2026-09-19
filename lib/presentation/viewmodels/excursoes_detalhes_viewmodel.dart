import 'package:flutter/material.dart';
import 'package:sspmano_viagens/data/dto/passageiro_com_pessoa_dto.dart';
import 'package:sspmano_viagens/domain/entities/excursao.dart';
import 'package:sspmano_viagens/domain/repositories/excursao_repository.dart';
import 'package:sspmano_viagens/domain/repositories/passageiro_repository.dart';

class ExcursoesDetalhesViewmodel extends ChangeNotifier {
  final ExcursaoRepository _excursaoRepository;
  final PassageiroRepository _passageiroRepository;

  bool estaCarregando = false;
  String? mensagemErro;
  Excursao? excursao;
  List<PassageiroComPessoaDto> passageiros = [];

  ExcursoesDetalhesViewmodel(
    this._excursaoRepository,
    this._passageiroRepository,
  );

  Future<void> carregarExcursao(int idExcursao) async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      excursao = await _excursaoRepository.listarPorId(idExcursao);

      if (excursao == null) {
        mensagemErro = 'Excursão não encontrada';
      }
    } catch (e) {
      mensagemErro = 'Erro ao carregar a excursão';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  Future<void> carregarPassageiros(int idExcursao) async {
    mensagemErro = null;
    estaCarregando = true;
    notifyListeners();

    try {
      passageiros = await _passageiroRepository.listarPorExcursao(idExcursao);
    } catch (e) {
      mensagemErro = 'Erro ao carregar os passageiros';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

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

  Future<bool> finalizar(int idExcursao) async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      final excursao = await _excursaoRepository.listarPorId(idExcursao);

      if (excursao == null) {
        mensagemErro = 'Excursão não encontrada';
        return false;
      }

      await _excursaoRepository.finalizarExcursao(idExcursao);
      return true;
    } catch (e) {
      mensagemErro = 'Erro ao finalizar a excursão';
      return false;
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }
}
