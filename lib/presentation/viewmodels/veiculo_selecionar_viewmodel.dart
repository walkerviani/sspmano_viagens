import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/veiculo.dart';
import 'package:sspmano_viagens/domain/repositories/veiculo_repository.dart';

class VeiculoSelecionarViewmodel extends ChangeNotifier {
  final VeiculoRepository _repository;

  VeiculoSelecionarViewmodel(this._repository);
  bool estaCarregando = false;
  String? mensagemErro;
  List<Veiculo> veiculos = [];

  Future<void> carregarVeiculosExcursao(int idExcursao) async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      veiculos = await _repository.listarPorExcursao(idExcursao);
    } catch (e) {
      mensagemErro = 'Erro ao carregar os veiculos';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }
}
