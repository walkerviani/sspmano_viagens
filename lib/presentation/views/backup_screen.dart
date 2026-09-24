import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:sspmano_viagens/presentation/viewmodels/backup_viewmodel.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BackupViewModel>().inicializar();
    });
  }

  Future<void> _executarOperacao(Future<void> Function() operacao) async {
    await operacao();

    if (!mounted) return;

    final viewModel = context.read<BackupViewModel>();
    final mensagem = viewModel.erro ?? 'Backup realizado com sucesso.';
    final cor = viewModel.erro == null ? Colors.green : Colors.red;

    _mostrarSnackBar(mensagem: mensagem, cor: cor);
  }

  void _mostrarSnackBar({required String mensagem, required Color cor}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensagem,
          style: GoogleFonts.poppins(color: CoresApp.branco),
        ),
        backgroundColor: cor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BackupViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
        title: Text(
          'Backup',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Local do backup
              Text(
                'Local do backup',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  viewModel.pasta != null
                    ? '${viewModel.pasta}/SSPMANOViagens/backup.json'
                    : 'Nenhuma pasta selecionada.',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: viewModel.carregando
                    ? null
                    : viewModel.escolherPasta,
                icon: const Icon(Icons.folder),
                label: Text(
                  'Escolher pasta',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CoresApp.azulPetroleo,
                  foregroundColor: CoresApp.branco,
                  minimumSize: const Size(double.infinity, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Frequência
              Text(
                'Frequência do backup',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField<FrequenciaBackup>(
                initialValue: viewModel.frequencia,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Frequência',
                  labelStyle: GoogleFonts.poppins(fontSize: 18),
                  hintText: 'Selecione a frequência',
                  hintStyle: GoogleFonts.poppins(fontSize: 18),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: FrequenciaBackup.diario,
                    child: Text('Diário', style: GoogleFonts.poppins()),
                    
                  ),
                  DropdownMenuItem(
                    value: FrequenciaBackup.semanal,
                    child: Text('Semanal', style: GoogleFonts.poppins()),
                  ),
                  DropdownMenuItem(
                    value: FrequenciaBackup.mensal,
                    child: Text('Mensal', style: GoogleFonts.poppins()),
                  ),
                  DropdownMenuItem(
                    value: FrequenciaBackup.desativado,
                    child: Text('Desativado', style: GoogleFonts.poppins()),
                  ),
                ],
                onChanged: viewModel.carregando
                    ? null
                    : (valor) {
                        if (valor != null) {
                          viewModel.alterarFrequencia(valor);
                        }
                      },
              ),

              const SizedBox(height: 20),

              // Ações
              Text(
                'Operações',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: viewModel.carregando
                    ? null
                    : () => _executarOperacao(viewModel.criarBackupComPermissao),
                icon: const Icon(Icons.backup),
                label: Text(
                  'Fazer backup agora',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CoresApp.azulPetroleo,
                  foregroundColor: CoresApp.branco,
                  minimumSize: const Size(double.infinity, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: viewModel.carregando
                    ? null
                    : () => _executarOperacao(viewModel.restaurarBackup),
                icon: const Icon(Icons.restore),
                label: Text(
                  'Restaurar backup',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CoresApp.azulPetroleo,
                  foregroundColor: CoresApp.branco,
                  minimumSize: const Size(double.infinity, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}