import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/presentation/viewmodels/excursoes_list_viewmodel.dart';
import 'package:sspmano_viagens/presentation/views/excursoes_form_screen.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class ExcursoesDetalhesScreen extends StatefulWidget {
  final int excursaoId;
  final bool statusFinalizado;
  const ExcursoesDetalhesScreen(
    this.excursaoId, {
    super.key,
    required this.statusFinalizado,
  });

  @override
  State<StatefulWidget> createState() => _ExcursoesDetalhesScreenState();
}

class _ExcursoesDetalhesScreenState extends State<ExcursoesDetalhesScreen> {
  void _abrirFormulario(int id, bool modoEdicao) async {
    final viewmodel = context.read<ExcursoesListViewmodel>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ExcursoesFormScreen(excursaoId: id, modoEdicao: modoEdicao),
      ),
    );
    if (!mounted) return;
    viewmodel.carregarExcursoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes', style: GoogleFonts.poppins(fontSize: 28)),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: widget.statusFinalizado
            ? _detalhesFinalizado()
            : _detalhesAberto(),
      ),
      bottomNavigationBar: widget.statusFinalizado
          ? SizedBox.shrink()
          : _botoesNavBar(),
    );
  }

  Widget _detalhesAberto() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: CoresApp.azulPetroleo,
            foregroundColor: CoresApp.branco,
            minimumSize: Size(double.infinity, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.chair, size: 40),
              const SizedBox(width: 10),
              Text(
                'Ver assentos',
                style: GoogleFonts.poppins(
                  color: CoresApp.branco,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: CoresApp.azulPetroleo,
            foregroundColor: CoresApp.branco,
            minimumSize: Size(double.infinity, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.airport_shuttle, size: 40),
              const SizedBox(width: 10),
              Text(
                'Gerenciar veículos',
                style: GoogleFonts.poppins(
                  color: CoresApp.branco,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: CoresApp.azulPetroleo,
            foregroundColor: CoresApp.branco,
            minimumSize: Size(double.infinity, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.local_activity, size: 40),
              const SizedBox(width: 10),
              Text(
                'Bilhetes de passageiro',
                style: GoogleFonts.poppins(
                  color: CoresApp.branco,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        ElevatedButton(
          onPressed: () => _abrirFormulario(widget.excursaoId, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: CoresApp.azulPetroleo,
            foregroundColor: CoresApp.branco,
            minimumSize: Size(double.infinity, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.directions_bus, size: 40),
              const SizedBox(width: 10),
              Text(
                'Editar excursão',
                style: GoogleFonts.poppins(
                  color: CoresApp.branco,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _detalhesFinalizado() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Nome da excursão\n',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: 'Data e hora\n',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: 'Quantidade de passageiros',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _botoesNavBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: CoresApp.vermelhoClaro,
                foregroundColor: CoresApp.branco,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                'Excluir Excursão',
                style: GoogleFonts.poppins(
                  color: CoresApp.branco,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: CoresApp.verdeClaro,
                foregroundColor: CoresApp.branco,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                'Finalizar Excursão',
                style: GoogleFonts.poppins(
                  color: CoresApp.branco,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
