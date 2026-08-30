import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/domain/entities/veiculo.dart';
import 'package:sspmano_viagens/presentation/viewmodels/veiculo_list_viewmodel.dart';
import 'package:sspmano_viagens/presentation/views/veiculo_form_screen.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class VeiculoListScreen extends StatefulWidget {
  final int excursaoId;

  const VeiculoListScreen(this.excursaoId, {super.key});
  @override
  State<StatefulWidget> createState() => _VeiculoListScreenState();
}

class _VeiculoListScreenState extends State<VeiculoListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VeiculoListViewmodel>().carregarVeiculos();
    });
  }

  void _abrirFormulario(int? id, int idExcursao, bool modoEdicao) async {
    final viewmodel = context.read<VeiculoListViewmodel>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VeiculoFormScreen(id, idExcursao, modoEdicao),
      ),
    );
    if (!mounted) return;
    viewmodel.carregarVeiculos();
  }

  void _confirmarExcluir(Veiculo veiculo) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Excluir Veículo',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Tem certeza que deseja excluir esse veículo?',
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
              final viewModel = context.read<VeiculoListViewmodel>();
              final sucesso = await viewModel.deletar(veiculo.id!);
              if (!mounted) return;
              if (sucesso) {
                viewModel.carregarVeiculos();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gerenciar veículos',
          style: GoogleFonts.poppins(fontSize: 28),
        ),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _abrirFormulario(null, widget.excursaoId, false),
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
                    'Adicionar Veículo',
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
              child: Consumer<VeiculoListViewmodel>(
                builder: (context, viewmodel, child) {
                  if (viewmodel.estaCarregando) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: CoresApp.vermelho,
                      ),
                    );
                  }
                  if (viewmodel.veiculos.isEmpty) {
                    return Center(
                      child: Text(
                        'Nenhum veículo encontrado',
                        style: GoogleFonts.poppins(
                          color: CoresApp.grafite,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: viewmodel.veiculos.length,
                    itemBuilder: ((context, index) =>
                        _cardVeiculo(viewmodel.veiculos[index], index)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardVeiculo(Veiculo veiculo, index) {
    return Card(
      key: ValueKey(veiculo.id),
      color: CoresApp.cinzaGrafite,
      child: ListTile(
        title: Text(
          'Veículo ${index + 1}'.toUpperCase(),
          style: GoogleFonts.poppins(
            color: CoresApp.branco,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          '${veiculo.capacidade} passageiros',
          style: GoogleFonts.poppins(color: CoresApp.branco, fontSize: 17),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () =>
                  _abrirFormulario(veiculo.id, widget.excursaoId, true),
              icon: const Icon(Icons.edit, color: CoresApp.branco),
            ),
            IconButton(
              onPressed: () => _confirmarExcluir(veiculo),
              icon: const Icon(Icons.delete, color: CoresApp.branco),
            ),
          ],
        ),
      ),
    );
  }
}
