import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sspmano_viagens/data/dto/passageiro_com_pessoa_dto.dart';
import 'package:sspmano_viagens/data/dto/passageiros_por_veiculo_dto.dart';
import 'package:sspmano_viagens/domain/repositories/passageiro_repository.dart';
import 'package:sspmano_viagens/presentation/services/relatorio_service.dart';
import 'package:sspmano_viagens/utils/relatorio_pdf_service.dart';

class SelecionarPassageiroRelatorioViewmodel extends ChangeNotifier {
  final PassageiroRepository _passageiroRepository;
  final RelatorioPdfService _pdfService;
  final RelatorioService _relatorioService;

  SelecionarPassageiroRelatorioViewmodel(
    this._passageiroRepository,
    this._pdfService,
    this._relatorioService,
  );

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

  Future<Uint8List?> gerarRelatorioPassageiro(
    int idExcursao,
    PassageiroComPessoaDto passageiro,
    String endereco,
  ) async {
    mensagemErro = null;
    estaCarregando = true;
    notifyListeners();
    try {
      final excursao = await _relatorioService.buscarExcursao(idExcursao);
      return await _pdfService.gerarPdfPassageiro(
        excursao,
        passageiro,
        endereco,
      );
    } catch (e) {
      mensagemErro = 'Erro ao gerar relatório';
      return null;
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }
}
