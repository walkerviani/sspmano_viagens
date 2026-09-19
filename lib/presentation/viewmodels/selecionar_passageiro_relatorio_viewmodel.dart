import 'package:flutter/material.dart';
import 'package:sspmano_viagens/data/dto/passageiros_por_veiculo_dto.dart';
import 'package:sspmano_viagens/domain/repositories/passageiro_repository.dart';

class SelecionarPassageiroRelatorioViewmodel extends ChangeNotifier {
  final PassageiroRepository _passageiroRepository;

  SelecionarPassageiroRelatorioViewmodel(this._passageiroRepository);

  bool estaCarregando = false;
  String? mensagemErro;
  List<PassageirosPorVeiculoDto> passageiros = [];

  Future<void> carregarPassageiros(int idExcursao) async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      passageiros = await _passageiroRepository.listarAgrupadoPorVeiculo(
        idExcursao,
      );
    } catch (e) {
      mensagemErro = 'Erro ao carregar os passageiros';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }
}
