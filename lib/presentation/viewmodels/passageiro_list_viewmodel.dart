import 'package:flutter/material.dart';
import 'package:sspmano_viagens/data/dto/passageiro_com_pessoa_dto.dart';
import 'package:sspmano_viagens/domain/repositories/passageiro_repository.dart';

class PassageiroListViewmodel extends ChangeNotifier {
  final PassageiroRepository _repository;

  PassageiroListViewmodel(this._repository);
  bool estaCarregando = false;
  String? mensagemErro;
  List<PassageiroComPessoaDto> passageiros = [];

  Future<void> carregarPassageiros(int idExcursao) async {
    mensagemErro = null;
    estaCarregando = true;
    notifyListeners();

    try {
      passageiros = await _repository.listarPorExcursao(idExcursao);
    } catch (e) {
      mensagemErro = 'Erro ao carregar os passageiros';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }
}
