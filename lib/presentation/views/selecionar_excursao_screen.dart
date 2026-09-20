import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/domain/entities/excursao.dart';
import 'package:sspmano_viagens/presentation/viewmodels/selecionar_excursao_viewmodel.dart';
import 'package:sspmano_viagens/presentation/views/selecionar_passageiro_relatorio_screen.dart';
import 'package:sspmano_viagens/presentation/views/visualizar_pdf_screen.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class SelecionarExcursaoScreen extends StatefulWidget {
  final bool relatorioPassageiro;
  const SelecionarExcursaoScreen({
    super.key,
    required this.relatorioPassageiro,
  });

  @override
  State<StatefulWidget> createState() => _SelecionarExcursaoScreenState();
}

class _SelecionarExcursaoScreenState extends State<SelecionarExcursaoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewmodel = context.read<SelecionarExcursaoViewmodel>();
      viewmodel.carregarExcursoes();
    });
  }

  void _abrirSelecaoPassageiro(int idExcursao) async {
    final viewmodel = context.read<SelecionarExcursaoViewmodel>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            SelecionarPassageiroRelatorioScreen(idExcursao: idExcursao),
      ),
    );
    if (!mounted) return;
    viewmodel.carregarExcursoes();
  }

  void _abrirPdfExcursao(Excursao excursao) async {
    final viewmodel = context.read<SelecionarExcursaoViewmodel>();
    if (viewmodel.estaCarregando) return;
    final bytes = await viewmodel.gerarRelatorioExcursao(excursao.id!);

    if (!mounted) return;

    if (bytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            viewmodel.mensagemErro ?? 'Não foi possível gerar o PDF',
          ),
          backgroundColor: CoresApp.vermelhoClaro,
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VisualizarPdfScreen(
          'Excursão',
          (format) async => bytes,
          'relatorio_excursao_${excursao.nome}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selecione a excursão',
          style: GoogleFonts.poppins(fontSize: 28),
        ),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: Consumer<SelecionarExcursaoViewmodel>(
                builder: (context, viewmodel, child) {
                  if (viewmodel.estaCarregando) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: CoresApp.vermelho,
                      ),
                    );
                  }
                  if (viewmodel.excursoes.isEmpty) {
                    return Center(
                      child: Text(
                        'Nenhuma excursão encontrada',
                        style: GoogleFonts.poppins(
                          color: CoresApp.grafite,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: viewmodel.excursoes.length,
                    itemBuilder: ((context, index) =>
                        _cardExcursoes(viewmodel.excursoes[index])),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardExcursoes(Excursao excursao) {
    String data = DateFormat('dd/MM/yyyy').format(excursao.dataHora);
    String hora = DateFormat('HH:mm').format(excursao.dataHora);
    return Card(
      color: CoresApp.azulPetroleo,
      child: ListTile(
        title: Text(
          excursao.nome,
          style: GoogleFonts.poppins(
            color: CoresApp.branco,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          '$data às $hora\n'
          '${excursao.qtdAssentos == 0 ? 'Sem veículos vinculados' : '${excursao.qtdAssentos} passageiros'}',
          style: GoogleFonts.poppins(color: CoresApp.branco, fontSize: 16),
        ),
        trailing: IconButton(
          onPressed: () {
            if (widget.relatorioPassageiro) {
              _abrirSelecaoPassageiro(excursao.id!);
            } else {
              _abrirPdfExcursao(excursao);
            }
          },
          style: IconButton.styleFrom(
            backgroundColor: CoresApp.verdeClaro,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          icon: Icon(Icons.check, color: CoresApp.branco, size: 30),
        ),
      ),
    );
  }
}
