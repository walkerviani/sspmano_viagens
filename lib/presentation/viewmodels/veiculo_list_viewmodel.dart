import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/veiculo.dart';
import 'package:sspmano_viagens/domain/repositories/veiculo_repository.dart';

class VeiculoListViewmodel extends ChangeNotifier {
  final VeiculoRepository _repository;

  VeiculoListViewmodel(this._repository);
  bool estaCarregando = false;
  String? mensagemErro;
  List<Veiculo> veiculos = [];

  Future<void> carregarVeiculos() async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      veiculos = await _repository.listarTodos();
    } catch (e) {
      mensagemErro = 'Erro ao carregar os veiculos';
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
    } catch (e) {
      mensagemErro = 'Erro ao excluir o veículo';
      return false;
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }
}
