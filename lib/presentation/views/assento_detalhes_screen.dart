import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/presentation/viewmodels/assento_detalhes_viewmodel.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class AssentoDetalhesScreen extends StatefulWidget {
  final int numAssento;
  final int idVeiculo;
  const AssentoDetalhesScreen(this.numAssento, this.idVeiculo, {super.key});

  @override
  State<StatefulWidget> createState() => _AssentoDetalhesScreenState();
}

class _AssentoDetalhesScreenState extends State<AssentoDetalhesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carregarDados();
    });
  }

  Future<void> _carregarDados() async {
    final viewmodel = context.read<AssentoDetalhesViewmodel>();

    await viewmodel.carregarPassageiro(widget.numAssento, widget.idVeiculo);

    if (!mounted) return;

    final passageiro = viewmodel.passageiro;

    if (passageiro != null && passageiro.idPessoa != null) {
      await viewmodel.carregarPessoa(passageiro.idPessoa!);
    }
  }

  void _excluirPassageiro(int idPassageiro) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Remover Passageiro',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        content: Text(
          'Tem certeza que deseja remover esse passageiro?',
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
              final viewModel = context.read<AssentoDetalhesViewmodel>();
              final sucesso = await viewModel.deletar(idPassageiro);
              if (!mounted) return;
              if (sucesso) {
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      viewModel.mensagemErro ?? 'Erro ao remover',
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text(
              'Remover',
              style: GoogleFonts.poppins(color: CoresApp.vermelho),
            ),
          ),
        ],
      ),
    );
  }

  void _atualizarPagamento(int idPassageiro) async {
    final viewModel = context.read<AssentoDetalhesViewmodel>();
    final sucesso = await viewModel.atualizarStatusPago(idPassageiro);
    if (!mounted) return;
    if (!sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            viewModel.mensagemErro ?? 'Erro desconhecido',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = context.watch<AssentoDetalhesViewmodel>();
    final passageiro = viewmodel.passageiro;

    if (viewmodel.estaCarregando) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: CoresApp.vermelho),
        ),
      );
    }
    if (passageiro == null) {
      return Center(
        child: Text(
          'Passageiro não encontrado',
          style: GoogleFonts.poppins(
            color: CoresApp.grafite,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assento ${widget.numAssento}',
          style: GoogleFonts.poppins(fontSize: 28),
        ),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _cabecalhoAssento(),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: viewmodel.estaAtualizandoPagamento
                  ? null
                  : () => _atualizarPagamento(passageiro.id!),
              style: ElevatedButton.styleFrom(
                backgroundColor: passageiro.foiPago
                    ? CoresApp.vinho
                    : CoresApp.verdeClaro,
                foregroundColor: CoresApp.branco,
                minimumSize: Size(double.infinity, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: viewmodel.estaAtualizandoPagamento
                  ? null
                  : Text(
                      passageiro.foiPago
                          ? 'Cancelar pagamento'
                          : 'Pagamento realizado',
                      style: GoogleFonts.poppins(
                        color: CoresApp.branco,
                        fontSize: 20,
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _botaoNavBar(),
    );
  }

  Widget _cabecalhoAssento() {
    final viewmodel = context.watch<AssentoDetalhesViewmodel>();
    final passageiro = viewmodel.passageiro;
    final pessoa = viewmodel.pessoa;

    if (passageiro == null || pessoa == null) {
      return Center(
        child: Text(
          'Dados não encontrados',
          style: GoogleFonts.poppins(
            color: CoresApp.grafite,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Pessoa no assento atual\n',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              TextSpan(
                text: 'Nome: ${pessoa.nome}\n',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 15),
              ),
              TextSpan(
                text: '${pessoa.cpf} | ${pessoa.telefone}\n',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 15),
              ),

              TextSpan(
                text:
                    'Status de pagamento: ${passageiro.foiPago ? 'Pago' : 'Pendente'}',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _botaoNavBar() {
    final viewmodel = context.read<AssentoDetalhesViewmodel>();
    final passageiro = viewmodel.passageiro;

    if (passageiro == null) return const SizedBox.shrink();

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => _excluirPassageiro(passageiro.id!),
              style: ElevatedButton.styleFrom(
                backgroundColor: CoresApp.laranja,
                foregroundColor: CoresApp.branco,
                minimumSize: Size(double.infinity, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                'Remover passageiro',
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
