import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/data/database.dart';
import 'package:sspmano_viagens/data/repositories/excursao_repository_impl.dart';
import 'package:sspmano_viagens/data/repositories/passageiro_repository_impl.dart';
import 'package:sspmano_viagens/data/repositories/pessoa_repository_impl.dart';
import 'package:sspmano_viagens/data/repositories/veiculo_repository_impl.dart';
import 'package:sspmano_viagens/data/services/backup_background_service.dart';
import 'package:sspmano_viagens/data/services/relatorio_service_impl.dart';
import 'package:sspmano_viagens/domain/repositories/backup_repository.dart';
import 'package:sspmano_viagens/domain/repositories/excursao_repository.dart';
import 'package:sspmano_viagens/domain/repositories/passageiro_repository.dart';
import 'package:sspmano_viagens/domain/repositories/pessoa_repository.dart';
import 'package:sspmano_viagens/domain/repositories/veiculo_repository.dart';
import 'package:sspmano_viagens/utils/relatorio_pdf_service.dart';
import 'package:sspmano_viagens/presentation/services/relatorio_service.dart';
import 'package:sspmano_viagens/presentation/viewmodels/assento_detalhes_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/assentos_list_viewmodel.dart';
import 'package:sspmano_viagens/data/datasources/backup/backup_config_datasource.dart';
import 'package:sspmano_viagens/data/datasources/backup/backup_file_datasource.dart';
import 'package:sspmano_viagens/data/datasources/backup/json_backup_datasource.dart';
import 'package:sspmano_viagens/data/repositories/backup_repository_impl.dart';
import 'package:sspmano_viagens/presentation/viewmodels/backup_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/excursoes_detalhes_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/excursoes_form_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/excursoes_list_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/passageiro_list_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/pessoas_list_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/selecionar_excursao_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/selecionar_passageiro_relatorio_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/selecionar_passageiro_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/veiculo_form_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/veiculo_list_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/veiculo_selecionar_viewmodel.dart';
import 'package:sspmano_viagens/presentation/views/backup_screen.dart';
import 'package:sspmano_viagens/presentation/views/excursoes_list_screen.dart';
import 'package:sspmano_viagens/presentation/views/pessoas_list_screen.dart';
import 'package:sspmano_viagens/presentation/views/relatorio_screen.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BackupBackgroundService.initialize();

  final database = AppDatabase();

  final jsonBackupDatasource = JsonBackupDatasource(database);
  final backupFileDatasource = BackupFileDatasource();
  final backupConfigDatasource = BackupConfigDatasource();
  final backupRepository = BackupRepositoryImpl(
    database,
    jsonBackupDatasource,
    backupFileDatasource,
    backupConfigDatasource,
  );

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
        Provider<PassageiroRepository>(
          create: (_) => PassageiroRepositoryImpl(database),
        ),
        Provider<RelatorioService>(
          create: (context) => RelatorioServiceImpl(
            context.read<ExcursaoRepository>(),
            context.read<PassageiroRepository>(),
          ),
        ),
        Provider<PassageiroRepository>(
          create: (_) => PassageiroRepositoryImpl(database),
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

        Provider<BackupRepository>.value(value: backupRepository),
        ChangeNotifierProvider<BackupViewModel>(
          create: (context) =>
              BackupViewModel(context.read<BackupRepository>()),
        ),
        ChangeNotifierProvider<VeiculoFormViewmodel>(
          create: (context) => VeiculoFormViewmodel(
            context.read<VeiculoRepository>(),
            context.read<ExcursaoRepository>(),
            context.read<PassageiroRepository>(),
          ),
        ),
        ChangeNotifierProvider<VeiculoListViewmodel>(
          create: (context) => VeiculoListViewmodel(
            context.read<VeiculoRepository>(),
            context.read<ExcursaoRepository>(),
          ),
        ),
        ChangeNotifierProvider<VeiculoSelecionarViewmodel>(
          create: (context) =>
              VeiculoSelecionarViewmodel(context.read<VeiculoRepository>()),
        ),
        ChangeNotifierProvider<AssentosListViewmodel>(
          create: (context) =>
              AssentosListViewmodel(context.read<PassageiroRepository>()),
        ),
        ChangeNotifierProvider<SelecionarPassageiroViewmodel>(
          create: (context) => SelecionarPassageiroViewmodel(
            context.read<PessoaRepository>(),
            context.read<PassageiroRepository>(),
          ),
        ),
        ChangeNotifierProvider<AssentoDetalhesViewmodel>(
          create: (context) => AssentoDetalhesViewmodel(
            context.read<PassageiroRepository>(),
            context.read<PessoaRepository>(),
          ),
        ),
        ChangeNotifierProvider<PassageiroListViewmodel>(
          create: (context) =>
              PassageiroListViewmodel(context.read<PassageiroRepository>()),
        ),
        ChangeNotifierProvider<ExcursoesDetalhesViewmodel>(
          create: (context) => ExcursoesDetalhesViewmodel(
            context.read<ExcursaoRepository>(),
            context.read<PassageiroRepository>(),
          ),
        ),
        ChangeNotifierProvider<SelecionarPassageiroRelatorioViewmodel>(
          create: (context) => SelecionarPassageiroRelatorioViewmodel(
            context.read<PassageiroRepository>(),
          ),
        ),
        ChangeNotifierProvider<SelecionarExcursaoViewmodel>(
          create: (context) => SelecionarExcursaoViewmodel(
            context.read<ExcursaoRepository>(),
            RelatorioPdfService(),
            context.read<RelatorioService>(),
          ),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RelatorioScreen()),
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
                  Icon(Icons.content_paste, size: 40),
                  const SizedBox(width: 10),
                  Text(
                    'Relatórios',
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
                  MaterialPageRoute(builder: (_) => BackupScreen()),
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
                  Icon(Icons.backup_outlined, size: 40),
                  const SizedBox(width: 10),
                  Text(
                    'Backup',
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
