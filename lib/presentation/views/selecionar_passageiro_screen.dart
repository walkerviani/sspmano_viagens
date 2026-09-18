import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';
import 'package:sspmano_viagens/presentation/viewmodels/selecionar_passageiro_viewmodel.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class SelecionarPassageiroScreen extends StatefulWidget {
  final int numAssento;
  final int idVeiculo;
  final int idExcursao;
  const SelecionarPassageiroScreen({
    super.key,
    required this.numAssento,
    required this.idVeiculo,
    required this.idExcursao,
  });

  @override
  State<StatefulWidget> createState() => _SelecionarPassageiroScreenState();
}

class _SelecionarPassageiroScreenState
    extends State<SelecionarPassageiroScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SelecionarPassageiroViewmodel>().carregarPessoas(
        widget.idExcursao,
      );
    });
  }

  void _vincularPassageiro(Pessoa pessoa) async {
    final viewmodel = context.read<SelecionarPassageiroViewmodel>();
    bool sucesso = await viewmodel.vincularPassageiro(
      pessoa,
      widget.idVeiculo,
      widget.numAssento,
    );
    if (!mounted) return;
    if (sucesso) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            viewmodel.mensagemErro ?? 'Houve algum erro desconhecido',
            style: GoogleFonts.poppins(color: CoresApp.branco),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passageiros', style: GoogleFonts.poppins(fontSize: 28)),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Consumer<SelecionarPassageiroViewmodel>(
          builder: (context, viewmodel, child) {
            if (viewmodel.estaCarregando) {
              return const Center(
                child: CircularProgressIndicator(color: CoresApp.vermelho),
              );
            }
            if (viewmodel.pessoas.isEmpty) {
              return Center(
                child: Text(
                  'Nenhum usuário encontrado',
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
              itemCount: viewmodel.pessoas.length,
              itemBuilder: ((context, index) =>
                  _cardPassageiro(viewmodel.pessoas[index])),
            );
          },
        ),
      ),
    );
  }

  Widget _cardPassageiro(Pessoa pessoa) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          title: Text(
            pessoa.nome,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${pessoa.cpf} | ${pessoa.telefone}',
            style: GoogleFonts.poppins(fontSize: 15),
          ),
          trailing: IconButton(
            onPressed: () {
              _vincularPassageiro(pessoa);
            },
            style: IconButton.styleFrom(
              backgroundColor: CoresApp.verdeClaro,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            icon: Icon(Icons.check, color: CoresApp.branco, size: 30),
          ),
        ),
      ),
    );
  }
}
