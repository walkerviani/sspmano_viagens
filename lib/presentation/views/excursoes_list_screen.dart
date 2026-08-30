import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/domain/entities/excursao.dart';
import 'package:sspmano_viagens/domain/enums/excursao_status.dart';
import 'package:sspmano_viagens/presentation/viewmodels/excursoes_list_viewmodel.dart';
import 'package:sspmano_viagens/presentation/views/excursoes_detalhes_screen.dart';
import 'package:sspmano_viagens/presentation/views/excursoes_form_screen.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class ExcursoesListScreen extends StatefulWidget {
  const ExcursoesListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ExcursoesListScreenState();
}

class _ExcursoesListScreenState extends State<ExcursoesListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExcursoesListViewmodel>().carregarExcursoes();
    });
  }

  void _abrirFormulario(bool modoEdicao) async {
    final viewmodel = context.read<ExcursoesListViewmodel>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExcursoesFormScreen(modoEdicao: modoEdicao),
      ),
    );
    if (!mounted) return;
    viewmodel.carregarExcursoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excursões', style: GoogleFonts.poppins(fontSize: 28)),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _abrirFormulario(false),
              style: ElevatedButton.styleFrom(
                backgroundColor: CoresApp.verdeClaro,
                foregroundColor: CoresApp.branco,
                minimumSize: Size(double.infinity, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.add, size: 40),
                  const SizedBox(width: 10),
                  Text(
                    'Criar excursão',
                    style: GoogleFonts.poppins(
                      color: CoresApp.branco,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Consumer<ExcursoesListViewmodel>(
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
                          fontSize: 20,
                        ),
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
    String statusExcursao = ExcursaoStatus.values
        .firstWhere((e) => e.id == excursao.idStatus)
        .excursaoStatus;
    String data = DateFormat('dd/MM/yyyy').format(excursao.dataHora);
    String hora = DateFormat('HH:mm').format(excursao.dataHora);
    String nomeCortado = excursao.nome.length > 20
        ? '${excursao.nome.substring(0, 20)}...'
        : excursao.nome;

    return Card(
      key: ValueKey(excursao.id),
      color: CoresApp.azulPetroleo,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ExcursoesDetalhesScreen(
                excursao.id!,
                statusFinalizado: false,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                statusExcursao.toUpperCase(),
                style: GoogleFonts.poppins(
                  color: CoresApp.branco,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '$nomeCortado\n'.toUpperCase(),
                          style: GoogleFonts.poppins(
                            color: CoresApp.branco,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: '$data às $hora\n',
                          style: GoogleFonts.poppins(
                            color: CoresApp.branco,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: excursao.qtdAssentos == 0
                              ? 'Sem veículos vinculados'
                              : '${excursao.qtdAssentos} passageiros',
                          style: GoogleFonts.poppins(
                            color: CoresApp.branco,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
