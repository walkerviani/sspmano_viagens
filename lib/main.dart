import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sspmano_viagens/presentation/views/excursoes_list_screen.dart';
import 'package:sspmano_viagens/presentation/views/pessoas_list_screen.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CoresApp.vermelho,
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'SSPMANO',
                style: GoogleFonts.poppins(
                  color: CoresApp.branco,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              TextSpan(text: ' '), // Espaço entre textos
              TextSpan(
                text: 'Viagens',
                style: GoogleFonts.poppins(
                  color: CoresApp.branco,
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ),
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
                  MaterialPageRoute(builder: (_) => PessoasListScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CoresApp.vinho,
                foregroundColor: CoresApp.branco,
                minimumSize: Size(double.infinity, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.person, size: 40),
                  const SizedBox(width: 10),
                  Text(
                    'Pessoas',
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
                  MaterialPageRoute(builder: (_) => ExcursoesListScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CoresApp.vinho,
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
                    'Excursões',
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
                backgroundColor: CoresApp.vinho,
                foregroundColor: CoresApp.branco,
                minimumSize: Size(double.infinity, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.content_paste, size: 40),
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
