import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/veiculo.dart';
import 'package:sspmano_viagens/domain/repositories/excursao_repository.dart';
import 'package:sspmano_viagens/domain/repositories/veiculo_repository.dart';

class VeiculoListViewmodel extends ChangeNotifier {
  final VeiculoRepository _veiculoRepository;
  final ExcursaoRepository _excursaoRepository;

  VeiculoListViewmodel(this._veiculoRepository, this._excursaoRepository);
  bool estaCarregando = false;
  String? mensagemErro;
  List<Veiculo> veiculos = [];

  Future<void> carregarVeiculos() async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      veiculos = await _veiculoRepository.listarTodos();
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
      final veiculo = await _veiculoRepository.listarPorId(id);

      if (veiculo == null) {
        mensagemErro = 'Veículo não encontrado';
        return false;
      }

      await _veiculoRepository.deletar(id);
      await atualizarCapacidadeExcursao(veiculo.idExcursao!);
      return true;
    } catch (e) {
      mensagemErro = 'Erro ao excluir o veículo';
      return false;
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  Future<void> atualizarCapacidadeExcursao(int idExcursao) async {
    final capacidade = await _veiculoRepository.calcularCapacidadePorExcursao(
      idExcursao,
    );
    await _excursaoRepository.definirQuantidadeAssentos(idExcursao, capacidade);
  }
}
