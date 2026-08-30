import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/veiculo.dart';
import 'package:sspmano_viagens/domain/repositories/veiculo_repository.dart';

class VeiculoFormViewmodel extends ChangeNotifier {
  final VeiculoRepository _repository;

  VeiculoFormViewmodel(this._repository);
  bool estaCarregando = false;
  String? mensagemErro;
  Veiculo? veiculo;

  Future<void> carregarVeiculo(int id) async {
    mensagemErro = null;
    estaCarregando = true;
    notifyListeners();

    try {
      veiculo = await _repository.listarPorId(id);
    } catch (e) {
      mensagemErro = 'Erro ao carregar o veículo';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  Future<bool> salvarVeiculo({
    int? id,
    required int idExcursao,
    required int capacidade,
  }) async {
    mensagemErro = null;

    if (capacidade < 1 || capacidade >= 60) {
      mensagemErro = 'Digite uma quantidade de assentos entre 1 e 60';
      return false;
    }

    estaCarregando = true;
    notifyListeners();

    try {
      Veiculo veiculo = Veiculo(id, idExcursao, capacidade);
      if (id != null) {
        await _repository.atualizar(veiculo);
      } else {
        await _repository.criar(veiculo);
      }
      return true;
    } catch (e) {
      mensagemErro = 'Erro ao salvar o veículo';
      return false;
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }
}
