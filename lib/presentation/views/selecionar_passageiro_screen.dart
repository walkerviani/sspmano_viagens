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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SelecionarPassageiroViewmodel>().carregarPessoas(
        widget.idExcursao,
      );
    });
  }

  void _executarPesquisa() {
    context.read<SelecionarPassageiroViewmodel>().aplicarFiltro(
      _searchController.text,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _vincularPassageiro(Pessoa pessoa, bool foiPago) async {
    final viewmodel = context.read<SelecionarPassageiroViewmodel>();
    bool sucesso = await viewmodel.vincularPassageiro(
      pessoa,
      widget.idVeiculo,
      widget.numAssento,
      foiPago,
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
        child: Column(
          children: [
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _searchController,
              builder: (context, value, child) {
                final possuiTexto = value.text.isNotEmpty;

                return TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  onChanged: (_) => _executarPesquisa(),
                  onSubmitted: (_) => _executarPesquisa(),
                  decoration: InputDecoration(
                    hintText: 'Digite o nome do passageiro...',
                    hintStyle: GoogleFonts.poppins(fontSize: 18),
                    border: const OutlineInputBorder(),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        possuiTexto
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  _executarPesquisa();
                                },
                              )
                            : IconButton(
                                icon: const Icon(Icons.search),
                                onPressed: _executarPesquisa,
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<SelecionarPassageiroViewmodel>(
                builder: (context, viewmodel, child) {
                  if (viewmodel.estaCarregando) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: CoresApp.vermelho,
                      ),
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
          ],
        ),
      ),
    );
  }

  Widget _cardPassageiro(Pessoa pessoa) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pessoa.nome,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'CPF: ${pessoa.cpf}',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  Text(
                    'Tel: ${pessoa.telefone}',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                _botaoAdicionar(
                  'Adicionar pendente',
                  CoresApp.verdeClaro,
                  () => _vincularPassageiro(pessoa, false),
                ),
                const SizedBox(height: 5),
                _botaoAdicionar(
                  'Adicionar pago',
                  CoresApp.azulEscuro,
                  () => _vincularPassageiro(pessoa, true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _botaoAdicionar(String texto, Color cor, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: cor,
        minimumSize: const Size(180, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(
        texto,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(color: CoresApp.branco, fontSize: 14),
      ),
    );
  }
}
