import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/veiculo.dart';
import 'package:sspmano_viagens/domain/repositories/excursao_repository.dart';
import 'package:sspmano_viagens/domain/repositories/passageiro_repository.dart';
import 'package:sspmano_viagens/domain/repositories/veiculo_repository.dart';

class VeiculoFormViewmodel extends ChangeNotifier {
  final VeiculoRepository _veiculoRepository;
  final ExcursaoRepository _excursaoRepository;
  final PassageiroRepository _passageiroRepository;

  VeiculoFormViewmodel(
    this._veiculoRepository,
    this._excursaoRepository,
    this._passageiroRepository,
  );
  bool estaCarregando = false;
  String? mensagemErro;
  Veiculo? veiculo;

  Future<void> carregarVeiculo(int id) async {
    mensagemErro = null;
    estaCarregando = true;
    notifyListeners();

    try {
      veiculo = await _veiculoRepository.listarPorId(id);
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

    if (capacidade < 1 || capacidade > 60) {
      mensagemErro = 'Digite uma quantidade de assentos entre 1 e 60';
      return false;
    }

    estaCarregando = true;
    notifyListeners();

    try {
      // Deleta passageiros após diminuir o total de passageiros do veículo
      final veiculoAtual = id != null ? await _veiculoRepository.listarPorId(id) : null;
      if (id != null && veiculoAtual != null && capacidade < veiculoAtual.capacidade) {
        await _passageiroRepository.deletarPorVeiculo(id);
      }

      Veiculo veiculo = Veiculo(id, idExcursao, capacidade);
      if (id != null) {
        await _veiculoRepository.atualizar(veiculo);
      } else {
        await _veiculoRepository.criar(veiculo);
      }
      await atualizarCapacidadeExcursao(veiculo.idExcursao!);
      return true;
    } catch (e) {
      mensagemErro = 'Erro ao salvar o veículo';
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
