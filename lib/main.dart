import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
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
            RelatorioPdfService(),
            context.read<RelatorioService>(),
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
      home: const BackupPermissionGate(),
    );
  }
}

class BackupPermissionGate extends StatefulWidget {
  const BackupPermissionGate({super.key});

  @override
  State<BackupPermissionGate> createState() => _BackupPermissionGateState();
}

class _BackupPermissionGateState extends State<BackupPermissionGate> {
  bool _verificando = true;
  bool _permisionConcedida = false;

  @override
  void initState() {
    super.initState();
    _verificarPermissao();
  }

  Future<void> _verificarPermissao() async {
    if (!Platform.isAndroid) {
      if (mounted) {
        setState(() {
          _verificando = false;
          _permisionConcedida = true;
        });
      }
      return;
    }

    final statusAtual = await Permission.manageExternalStorage.status;

    if (statusAtual.isGranted) {
      if (mounted) {
        setState(() {
          _verificando = false;
          _permisionConcedida = true;
        });
      }
      return;
    }

    final statusSolicitado = statusAtual.isPermanentlyDenied
        ? statusAtual
        : await Permission.manageExternalStorage.request();

    if (statusSolicitado.isGranted) {
      if (mounted) {
        setState(() {
          _verificando = false;
          _permisionConcedida = true;
        });
      }
      return;
    }

    if (mounted) {
      setState(() => _verificando = false);
      _mostrarDialogoPermissao();
    }
  }

  void _mostrarDialogoPermissao() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Permissão de arquivo necessária'),
        content: const Text(
          'O backup precisa acessar os arquivos do dispositivo. '
          'Conceda a permissão para continuar usando o aplicativo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
          TextButton(
            onPressed: () async {
              await openAppSettings();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Configurar'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _verificarPermissao();
            },
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_verificando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_permisionConcedida) {
      return const HomeScreen();
    }

    return Scaffold(
      body: Center(
        child: Text(
          'A permissão de arquivo não foi concedida. '
          'Abra o aplicativo novamente para solicitar a permissão.',
          textAlign: TextAlign.center,
        ),
      ),
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
            _botaoFuncao(
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PessoasListScreen()),
              ),
              Icons.person,
              'Pessoas',
            ),

            const SizedBox(height: 10),

            _botaoFuncao(
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ExcursoesListScreen()),
              ),
              Icons.directions_bus,
              'Excursões',
            ),

            const SizedBox(height: 10),

            _botaoFuncao(
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RelatorioScreen()),
              ),
              Icons.content_paste,
              'Relatórios',
            ),

            const SizedBox(height: 10),

            _botaoFuncao(
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BackupScreen()),
              ),
              Icons.backup_outlined,
              'Backup',
            ),
          ],
        ),
      ),
    );
  }

  Widget _botaoFuncao(VoidCallback funcao, IconData icone, String texto) {
    return ElevatedButton(
      onPressed: funcao,
      style: ElevatedButton.styleFrom(
        backgroundColor: CoresApp.azulPetroleo,
        foregroundColor: CoresApp.branco,
        minimumSize: const Size(double.infinity, 70),
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
