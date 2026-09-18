import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/presentation/viewmodels/passageiro_list_viewmodel.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class PassageiroListScreen extends StatefulWidget {
  final int idExcursao;

  const PassageiroListScreen({super.key, required this.idExcursao});

  @override
  State<PassageiroListScreen> createState() => _PassageiroListScreenState();
}

class _PassageiroListScreenState extends State<PassageiroListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewmodel = context.read<PassageiroListViewmodel>();
      viewmodel.carregarPassageiros(widget.idExcursao);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passageiros', style: GoogleFonts.poppins(fontSize: 28)),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: _listaPassageiros(),
        ),
      ),
    );
  }

  Widget? _listaPassageiros() {
    return Consumer<PassageiroListViewmodel>(
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
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: viewmodel.passageiros.length,
            itemBuilder: (context, index) {
              final item = viewmodel.passageiros[index];
              final statusPagamento = item.passageiro.foiPago;
              return Card(
                color: statusPagamento ? CoresApp.verdeClaro : CoresApp.vinho,
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
                    'CPF: ${item.pessoa.cpf}',
                    style: GoogleFonts.poppins(
                      color: CoresApp.branco,
                      fontSize: 15,
                    ),
                  ),
                  trailing: Text(
                    statusPagamento ? 'Pago' : 'Pendente',
                    style: GoogleFonts.poppins(
                      color: CoresApp.branco,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
