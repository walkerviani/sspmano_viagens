import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sspmano_viagens/data/dto/excursao_relatorio_dto.dart';
import 'package:sspmano_viagens/data/dto/passageiro_com_pessoa_dto.dart';
import 'package:sspmano_viagens/domain/entities/excursao.dart';
import 'package:sspmano_viagens/domain/enums/tipo_ingresso.dart';
import 'package:sspmano_viagens/utils/formatadores.dart';

class RelatorioPdfService {
  Future<pw.ThemeData> _carregarTema() async {
    final regular = pw.Font.ttf(
      await rootBundle.load('assets/fonts/Poppins-Regular.ttf'),
    );
    final bold = pw.Font.ttf(
      await rootBundle.load('assets/fonts/Poppins-Bold.ttf'),
    );

    return pw.ThemeData.withFont(base: regular, bold: bold);
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
      int index = 1;
      for (final passageiroDto in veiculoDto.passageiros) {
        final passageiro = passageiroDto.passageiro;
        final pessoa = passageiroDto.pessoa;
        final strPago = passageiro.foiPago ? 'Pago' : 'Pendente';
        String tipoIngressoStr =
            TipoIngresso.deId(passageiro.tipoIngresso)?.tipoIngresso ??
            'Não definido';

        itens.add(
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 12, bottom: 3),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text(
                      '$index# - ${pessoa.nome}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      ' / CPF: ${formatarCpf(pessoa.cpf)} / Tel: ${formatarTelefone(pessoa.telefone)}',
                    ),
                  ],
                ),
                pw.Text(
                  'Pagamento: $strPago / Assento: ${passageiro.numeroAssento} / Ingresso: $tipoIngressoStr',
                ),
              ],
            ),
          ),
        );
        index++;
      }
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: itens,
    );
  }

  pw.Widget _infoPassageiro(
    Excursao excursao,
    PassageiroComPessoaDto passageiro,
    String endereco,
  ) {
    String data = DateFormat('dd/MM/yyyy').format(excursao.dataHora);
    String hora = DateFormat('HH:mm').format(excursao.dataHora);
    String tipoIngressoStr =
        TipoIngresso.deId(passageiro.passageiro.tipoIngresso)?.tipoIngresso ??
        'Não definido';
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Passageiro(a)',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(passageiro.pessoa.nome, style: pw.TextStyle(fontSize: 18)),
        pw.Text(
          'Excursão',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(excursao.nome, style: pw.TextStyle(fontSize: 18)),
        pw.Text(
          'Data da excursão',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text('$data - $hora', style: pw.TextStyle(fontSize: 18)),
        pw.Text(
          'Endereço do SSPMANO',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(endereco, style: pw.TextStyle(fontSize: 18)),
        pw.Text(
          'Assento',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          passageiro.passageiro.numeroAssento.toString(),
          style: pw.TextStyle(fontSize: 18),
        ),
        pw.Text(
          'Tipo de ingresso',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(tipoIngressoStr, style: pw.TextStyle(fontSize: 18)),
        pw.Text(
          'Pagamento',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          '${passageiro.passageiro.foiPago ? 'Pago' : 'Pendente'} ',
          style: pw.TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Future<Uint8List> gerarPdfExcursao(ExcursaoRelatorioDto excursao) async {
    final bytesLogo = await rootBundle.load(
      'assets/icons/sspmano_fundo-transparente.png',
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

  Future<Uint8List> gerarPdfPassageiro(
    Excursao excursao,
    PassageiroComPessoaDto passageiro,
    String endereco,
  ) async {
    final bytesLogo = await rootBundle.load(
      'assets/icons/sspmano_fundo-transparente.png',
    );
    final logo = pw.MemoryImage(bytesLogo.buffer.asUint8List());

    final pdf = pw.Document(theme: await _carregarTema());

    pdf.addPage(
      pw.MultiPage(
        header: (context) =>
            _cabecalhoRelatorio(logo, 'INFORMAÇÕES PASSAGEIRO'),
        build: (context) => [_infoPassageiro(excursao, passageiro, endereco)],
      ),
    );
    return pdf.save();
  }
}
