import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/presentation/viewmodels/excursoes_detalhes_viewmodel.dart';
import 'package:sspmano_viagens/presentation/views/excursoes_form_screen.dart';
import 'package:sspmano_viagens/presentation/views/passageiro_list_screen.dart';
import 'package:sspmano_viagens/presentation/views/veiculo_list_screen.dart';
import 'package:sspmano_viagens/presentation/views/veiculo_selecionar_screen.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewmodel = context.read<ExcursoesDetalhesViewmodel>();
      viewmodel.carregarExcursao(widget.excursaoId);
      viewmodel.carregarPassageiros(widget.excursaoId);
    });
  }

  void _abrirFormulario(int id, bool modoEdicao) async {
    final viewmodel = context.read<ExcursoesDetalhesViewmodel>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ExcursoesFormScreen(excursaoId: id, modoEdicao: modoEdicao),
      ),
    );
    if (!mounted) return;
    viewmodel.carregarExcursao(id);
  }

  void _excluirExcursao() async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Excluir Excursão',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        content: Text(
          'Tem certeza que deseja excluir essa excursão?',
          style: GoogleFonts.poppins(),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: GoogleFonts.poppins(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final viewModel = context.read<ExcursoesDetalhesViewmodel>();
              final sucesso = await viewModel.deletar(widget.excursaoId);
              if (!mounted) return;
              if (sucesso) {
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      viewModel.mensagemErro ?? 'Erro ao excluir',
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text(
              'Excluir',
              style: GoogleFonts.poppins(color: CoresApp.vermelho),
            ),
          ),
        ],
      ),
    );
  }

  void _finalizarExcursao(int idExcursao) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Finalizar Excursão',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        content: Text(
          'Tem certeza que deseja finalizar essa excursão?\nRealizar essa ação impedirá que seja realizado qualquer tipo de alteração na excursão',
          style: GoogleFonts.poppins(),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: GoogleFonts.poppins(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final viewModel = context.read<ExcursoesDetalhesViewmodel>();
              final sucesso = await viewModel.finalizar(widget.excursaoId);
              if (!mounted) return;
              if (sucesso) {
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      viewModel.mensagemErro ?? 'Erro ao finalizar',
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text(
              'Finalizar',
              style: GoogleFonts.poppins(color: Colors.black),
            ),
          ),
        ],
      ),
    );
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VeiculoSelecionarScreen(widget.excursaoId),
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VeiculoListScreen(widget.excursaoId),
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
        const SizedBox(height: 10),

        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    PassageiroListScreen(idExcursao: widget.excursaoId),
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
              Icon(Icons.monetization_on, size: 40),
              const SizedBox(width: 10),
              Text(
                'Verificar pagamentos',
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

  Widget _cabecalhoFinalizado() {
    return Consumer<ExcursoesDetalhesViewmodel>(
      builder: (context, viewmodel, child) {
        final excursao = viewmodel.excursao;
        if (excursao == null) {
          return Center(
            child: Text(
              'Excursão não encontrada',
              style: GoogleFonts.poppins(
                color: CoresApp.grafite,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }
        String data = DateFormat('dd/MM/yyyy').format(excursao.dataHora);
        String hora = DateFormat('HH:mm').format(excursao.dataHora);
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: excursao.nome.toUpperCase(),
                        style: GoogleFonts.poppins(
                          color: CoresApp.grafite,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text: '\n$data às $hora',
                        style: GoogleFonts.poppins(
                          color: CoresApp.grafite,
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text: '\n${viewmodel.passageiros.length} passageiros',
                        style: GoogleFonts.poppins(
                          color: CoresApp.grafite,
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
      },
    );
  }

  Widget _listaPassageiros() {
    return Expanded(
      child: Consumer<ExcursoesDetalhesViewmodel>(
        builder: (context, viewmodel, _) {
          if (viewmodel.estaCarregando) {
            return Center(
              child: CircularProgressIndicator(color: CoresApp.vermelho),
            );
          } else if (viewmodel.mensagemErro != null) {
            return Center(
              child: Text(
                viewmodel.mensagemErro!,
                style: GoogleFonts.poppins(
                  color: CoresApp.grafite,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else if (viewmodel.passageiros.isEmpty) {
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
          } else {
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 70),
              itemCount: viewmodel.passageiros.length,
              itemBuilder: (context, index) {
                final item = viewmodel.passageiros[index];
                return Card(
                  color: CoresApp.azulPetroleo,
                  child: ListTile(
                    title: Text(
                      item.pessoa.nome,
                      style: GoogleFonts.poppins(
                        color: CoresApp.branco,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'CPF: ${item.pessoa.cpf}\nTelefone: ${item.pessoa.telefone}\nAssento: ${item.passageiro.numeroAssento}',
                      style: GoogleFonts.poppins(
                        color: CoresApp.branco,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _detalhesFinalizado() {
    return Consumer<ExcursoesDetalhesViewmodel>(
      builder: (context, viewmodel, child) {
        final excursao = viewmodel.excursao;
        if (excursao == null) {
          return Center(
            child: Text(
              'Excursão não encontrada',
              style: GoogleFonts.poppins(
                color: CoresApp.grafite,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _cabecalhoFinalizado(),
            const SizedBox(height: 10),
            _listaPassageiros(),
          ],
        );
      },
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
              onPressed: () => _excluirExcursao(),
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
              onPressed: () => _finalizarExcursao(widget.excursaoId),
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
