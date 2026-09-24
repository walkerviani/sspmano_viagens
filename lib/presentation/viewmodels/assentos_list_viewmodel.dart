import 'package:flutter/widgets.dart';
import 'package:sspmano_viagens/domain/entities/passageiro.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';
import 'package:sspmano_viagens/domain/repositories/passageiro_repository.dart';

class AssentosListViewmodel extends ChangeNotifier {
  final PassageiroRepository _repository;

  AssentosListViewmodel(this._repository);
  bool estaCarregando = false;
  String? mensagemErro;
  List<Passageiro> passageiros = [];
  Map<int, Passageiro> passageiroPorAssento = {};
  Map<int, Pessoa> pessoaPorAssento = {};

  Future<void> carregarPassageirosVeiculo(int idVeiculo) async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      passageiros = await _repository.listarPorVeiculo(idVeiculo);
      final passageirosComPessoa = await _repository.listarComPessoaPorVeiculo(
        idVeiculo,
      );

      passageiroPorAssento = {
        for (final passageiro in passageiros)
          passageiro.numeroAssento: passageiro,
      };

      pessoaPorAssento = {
        for (final item in passageirosComPessoa)
          item.passageiro.numeroAssento: item.pessoa,
      };
    } catch (e) {
      mensagemErro = 'Erro ao carregar os passageiros';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  Passageiro? buscarPassageiroPeloAssento(int numAssento) {
    return passageiroPorAssento[numAssento];
  }

  Pessoa? buscarPessoaPeloAssento(int numAssento) {
    return pessoaPorAssento[numAssento];
  }
}
