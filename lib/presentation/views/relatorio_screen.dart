import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sspmano_viagens/presentation/views/selecionar_excursao_screen.dart';
import 'package:sspmano_viagens/presentation/views/selecionar_passageiro_relatorio_screen.dart';
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SelecionarExcursaoScreen(relatorioPassageiro: true),
                  ),
                );
              },
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SelecionarExcursaoScreen(relatorioPassageiro: false),
                  ),
                );
              },
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
                  Icon(Icons.explore, size: 40),
                  const SizedBox(width: 10),
                  Text(
                    'Relatório da excursão',
                    style: GoogleFonts.poppins(
                      color: CoresApp.branco,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
