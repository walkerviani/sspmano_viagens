import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/domain/entities/veiculo.dart';
import 'package:sspmano_viagens/presentation/viewmodels/veiculo_selecionar_viewmodel.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class VeiculoSelecionarScreen extends StatefulWidget {
  final int excursaoId;
  const VeiculoSelecionarScreen(this.excursaoId, {super.key});

  @override
  State<StatefulWidget> createState() => _VeiculoSelecionarScreenState();
}

class _VeiculoSelecionarScreenState extends State<VeiculoSelecionarScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VeiculoSelecionarViewmodel>().carregarVeiculosExcursao(
        widget.excursaoId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selecione o veículo',
          style: GoogleFonts.poppins(fontSize: 28),
        ),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: Consumer<VeiculoSelecionarViewmodel>(
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
                        'Nenhum veículo encontrado!\nVerifique se foram adicionados um ou mais veículos na excursão atual.',
                        style: GoogleFonts.poppins(
                          color: CoresApp.grafite,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
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
        leading: Icon(Icons.airport_shuttle, color: CoresApp.branco, size: 30),
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
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.check, color: CoresApp.branco, size: 30),
          style: IconButton.styleFrom(
            backgroundColor: CoresApp.verdeClaro,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
