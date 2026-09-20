import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/excursao.dart';
import 'package:sspmano_viagens/domain/repositories/excursao_repository.dart';
import 'package:sspmano_viagens/utils/relatorio_pdf_service.dart';
import 'package:sspmano_viagens/presentation/services/relatorio_service.dart';

class SelecionarExcursaoViewmodel extends ChangeNotifier {
  final ExcursaoRepository _repository;
  final RelatorioPdfService _pdfService;
  final RelatorioService _relatorioService;

  SelecionarExcursaoViewmodel(
    this._repository,
    this._pdfService,
    this._relatorioService,
  );
  bool estaCarregando = false;
  String? mensagemErro;
  List<Excursao> excursoes = [];

  Future<void> carregarExcursoes() async {
    mensagemErro = null;

    estaCarregando = true;
    notifyListeners();

    try {
      excursoes = await _repository.listarTodos();
    } catch (e) {
      mensagemErro = 'Erro ao carregar as excursões';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  Future<Uint8List?> gerarRelatorioExcursao(int idExcursao) async {
    mensagemErro = null;
    try {
      final excursao = await _relatorioService.montarRelatorio(idExcursao);
      return await _pdfService.gerarPdfExcursao(excursao);
    } catch (e) {
      print(e);
      mensagemErro = 'Erro ao gerar relatório';
      return null;
    }
  }
}
