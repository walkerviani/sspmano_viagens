import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class VisualizarPdfScreen extends StatelessWidget {
  final String tituloPagina;
  final String nomeArquivo;
  final Future<Uint8List> Function(PdfPageFormat) criarPdf;

  const VisualizarPdfScreen(
    this.tituloPagina,
    this.criarPdf,
    this.nomeArquivo, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: CoresApp.vermelhoClaro,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: CoresApp.vermelhoClaro,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(tituloPagina),
          backgroundColor: CoresApp.vermelhoClaro,
          foregroundColor: CoresApp.branco,
        ),
        body: PdfPreview(
          build: criarPdf,
          pdfFileName: nomeArquivo,
          allowPrinting: true,
          allowSharing: true,
          canChangeOrientation: false,
          canChangePageFormat: false,
        ),
      ),
    );
  }
}
