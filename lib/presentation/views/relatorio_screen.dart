import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sspmano_viagens/presentation/views/selecionar_excursao_screen.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class RelatorioScreen extends StatelessWidget {
  const RelatorioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatórios', style: GoogleFonts.poppins(fontSize: 28)),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _botaoMenu(
              'Bilhetes de passageiro',
              Icons.local_activity,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      SelecionarExcursaoScreen(relatorioPassageiro: true),
                ),
              ),
            ),

            const SizedBox(height: 10),

            _botaoMenu(
              'Relatório da excursão',
              Icons.explore,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      SelecionarExcursaoScreen(relatorioPassageiro: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _botaoMenu(String texto, IconData icone, VoidCallback funcaoClique) {
    return ElevatedButton(
      onPressed: funcaoClique,
      style: ElevatedButton.styleFrom(
        backgroundColor: CoresApp.azulPetroleo,
        foregroundColor: CoresApp.branco,
        minimumSize: Size(double.infinity, 70),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        children: [
          Icon(icone, size: 40),
          const SizedBox(width: 10),
          Text(
            texto,
            style: GoogleFonts.poppins(color: CoresApp.branco, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
