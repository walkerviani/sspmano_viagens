import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/data/dto/passageiro_com_pessoa_dto.dart';
import 'package:sspmano_viagens/data/dto/passageiros_por_veiculo_dto.dart';
import 'package:sspmano_viagens/presentation/viewmodels/selecionar_passageiro_relatorio_viewmodel.dart';
import 'package:sspmano_viagens/presentation/views/visualizar_pdf_screen.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class SelecionarPassageiroRelatorioScreen extends StatefulWidget {
  final int idExcursao;
  const SelecionarPassageiroRelatorioScreen({
    super.key,
    required this.idExcursao,
  });

  @override
  State<StatefulWidget> createState() =>
      _SelecionarPassageiroRelatorioScreenState();
}

class _SelecionarPassageiroRelatorioScreenState
    extends State<SelecionarPassageiroRelatorioScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewmodel = context.read<SelecionarPassageiroRelatorioViewmodel>();
      viewmodel.carregarPassageiros(widget.idExcursao);
    });
  }

  void _abrirPdfPassageiro(
    int idExcursao,
    PassageiroComPessoaDto passageiro,
  ) async {
    final viewmodel = context.read<SelecionarPassageiroRelatorioViewmodel>();
    if (viewmodel.estaCarregando) return;
    final bytes = await viewmodel.gerarRelatorioPassageiro(
      idExcursao,
      passageiro,
    );

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
          'Relatório',
          (format) async => bytes,
          'relatorio_passageiro_${passageiro.pessoa.nome}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passageiros', style: GoogleFonts.poppins(fontSize: 28)),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Consumer<SelecionarPassageiroRelatorioViewmodel>(
          builder: (context, viewmodel, child) {
            if (viewmodel.estaCarregando) {
              return const Center(
                child: CircularProgressIndicator(color: CoresApp.vermelho),
              );
            }
            if (viewmodel.mensagemErro != null) {
              return Center(child: Text(viewmodel.mensagemErro!));
            }
            if (viewmodel.passageiros.isEmpty) {
              return Center(
                child: Text(
                  'Nenhum passageiro encontrado',
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
              itemCount: viewmodel.passageiros.length,
              itemBuilder: (context, index) =>
                  _listaPassageiros(viewmodel.passageiros[index], index),
            );
          },
        ),
      ),
    );
  }

  Widget _listaPassageiros(PassageirosPorVeiculoDto passageiros, int index) {
    return Card(
      child: ExpansionTile(
        title: Text(
          'Veículo ${index + 1}',
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: CoresApp.branco,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          passageiros.passageiros.length == 1
              ? '${passageiros.passageiros.length} passageiro'
              : '${passageiros.passageiros.length} passageiros',
          style: GoogleFonts.poppins(fontSize: 16, color: CoresApp.branco),
        ),

        collapsedBackgroundColor: CoresApp.azulPetroleo,
        backgroundColor: CoresApp.azulPetroleo,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(5),
        ),
        collapsedIconColor: CoresApp.branco,
        iconColor: CoresApp.branco,
        children: passageiros.passageiros.asMap().entries.map((p) {
          final index = p.key;
          final passageiro = p.value;
          final ehUltimo = index == passageiros.passageiros.length - 1;

          return Column(
            children: [
              ListTile(
                title: Text(
                  passageiro.pessoa.nome,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: CoresApp.branco,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${passageiro.pessoa.cpf} | ${passageiro.pessoa.telefone}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: CoresApp.branco,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    _abrirPdfPassageiro(widget.idExcursao, passageiro);
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: CoresApp.verdeClaro,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  icon: const Icon(
                    Icons.check,
                    color: CoresApp.branco,
                    size: 30,
                  ),
                ),
              ),

              if (!ehUltimo)
                Divider(
                  color: CoresApp.branco,
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
