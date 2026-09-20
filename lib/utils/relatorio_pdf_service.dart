import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sspmano_viagens/data/dto/excursao_relatorio_dto.dart';

class RelatorioPdfService {
  Future<pw.ThemeData> _carregarTema() async {
    final font = await PdfGoogleFonts.poppinsRegular();
    final bold = await PdfGoogleFonts.poppinsBold();

    return pw.ThemeData.withFont(base: font, bold: bold);
  }

  // Cria o cabeçalho com icone do app e título do relatório
  pw.Widget _cabecalhoRelatorio(pw.MemoryImage logo, String titulo) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Column(children: [pw.Image(logo, width: 150, height: 150)]),
            pw.SizedBox(width: 12),
            pw.Text(
              titulo,
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
        pw.Divider(),
        pw.SizedBox(height: 5),
      ],
    );
  }

  // Cria o cabeçalho da excursao
  pw.Widget _cabecalhoExcursao(ExcursaoRelatorioDto excursao) {
    String data = DateFormat('dd/MM/yyyy').format(excursao.excursao.dataHora);
    String hora = DateFormat('HH:mm').format(excursao.excursao.dataHora);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'EXCURSÃO: ${excursao.excursao.nome}',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Text('Data: $data às $hora'),
        pw.Text(
          excursao.excursao.qtdAssentos == 0
              ? 'Sem veículos vinculados'
              : '${excursao.excursao.qtdAssentos} passageiros',
        ),
      ],
    );
  }

  // Cria as informações de cada passageiro + veiculo
  pw.Widget _itensPassageiros(ExcursaoRelatorioDto excursao) {
    final itens = <pw.Widget>[];

    for (
      var indiceVeiculo = 0;
      indiceVeiculo < excursao.veiculos.length;
      indiceVeiculo++
    ) {
      final veiculoDto = excursao.veiculos[indiceVeiculo];

      itens.add(
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
          child: pw.Text(
            'VEÍCULO ${indiceVeiculo + 1}',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
      );

      for (final passageiroDto in veiculoDto.passageiros) {
        final passageiro = passageiroDto.passageiro;
        final pessoa = passageiroDto.pessoa;
        final strPago = passageiro.foiPago ? 'Pago' : 'Pendente';

        itens.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 12, bottom: 3),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '${pessoa.nome} ',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  'CPF: ${pessoa.cpf} | Telefone: ${pessoa.telefone}'
                  '\nPagamento: $strPago'
                  '\nAssento ${passageiro.numeroAssento}',
                ),
              ],
            ),
          ),
        );
      }
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: itens,
    );
  }

  Future<Uint8List> gerarPdfExcursao(ExcursaoRelatorioDto excursao) async {
    final bytesLogo = await rootBundle.load(
      'assets/icon/sspmano_fundo-transparente.png',
    );
    final logo = pw.MemoryImage(bytesLogo.buffer.asUint8List());

    final pdf = pw.Document(theme: await _carregarTema());

    pdf.addPage(
      pw.MultiPage(
        header: (context) => _cabecalhoRelatorio(logo, 'RELATÓRIO DA EXCURSÃO'),
        build: (context) => [
          _cabecalhoExcursao(excursao),
          pw.SizedBox(height: 8),
          _itensPassageiros(excursao),
          pw.Divider(),
        ],
      ),
    );
    return pdf.save();
  }
}
