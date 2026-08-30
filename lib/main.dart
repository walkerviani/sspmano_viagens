import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/data/repositories/excursao_repository_impl.dart';
import 'package:sspmano_viagens/data/repositories/pessoa_repository_impl.dart';
import 'package:sspmano_viagens/data/repositories/veiculo_repository_impl.dart';
import 'package:sspmano_viagens/domain/repositories/excursao_repository.dart';
import 'package:sspmano_viagens/domain/repositories/pessoa_repository.dart';
import 'package:sspmano_viagens/domain/repositories/veiculo_repository.dart';
import 'package:sspmano_viagens/presentation/viewmodels/excursoes_form_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/excursoes_list_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/pessoas_list_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/veiculo_form_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/veiculo_list_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/veiculo_selecionar_viewmodel.dart';
import 'package:sspmano_viagens/presentation/views/excursoes_list_screen.dart';
import 'package:sspmano_viagens/presentation/views/pessoas_list_screen.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  final database = AppDatabase();

  runApp(
    MultiProvider(
      providers: [
        Provider<PessoaRepository>(
          create: (_) => PessoaRepositoryImpl(database),
        ),
        Provider<ExcursaoRepository>(
          create: (_) => ExcursaoRepositoryImpl(database),
        ),
        Provider<VeiculoRepository>(
          create: (_) => VeiculoRepositoryImpl(database),
        ),
        ChangeNotifierProvider<PessoasListViewmodel>(
          create: ((context) =>
              PessoasListViewmodel(context.read<PessoaRepository>())),
        ),
        ChangeNotifierProvider<ExcursoesFormViewmodel>(
          create: ((context) =>
              ExcursoesFormViewmodel(context.read<ExcursaoRepository>())),
        ),
        ChangeNotifierProvider<ExcursoesListViewmodel>(
          create: (context) =>
              ExcursoesListViewmodel(context.read<ExcursaoRepository>()),
        ),
        ChangeNotifierProvider<VeiculoFormViewmodel>(
          create: (context) =>
              VeiculoFormViewmodel(context.read<VeiculoRepository>()),
        ),
        ChangeNotifierProvider<VeiculoListViewmodel>(
          create: (context) =>
              VeiculoListViewmodel(context.read<VeiculoRepository>()),
        ),
        ChangeNotifierProvider<VeiculoSelecionarViewmodel>(
          create: (context) =>
              VeiculoSelecionarViewmodel(context.read<VeiculoRepository>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
                backgroundColor: CoresApp.azulPetroleo,
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
                backgroundColor: CoresApp.azulPetroleo,
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
