import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';
import 'package:sspmano_viagens/domain/repositories/pessoa_repository.dart';
import 'package:sspmano_viagens/presentation/viewmodels/pessoas_form_viewmodel.dart';
import 'package:sspmano_viagens/presentation/viewmodels/pessoas_list_viewmodel.dart';
import 'package:sspmano_viagens/presentation/views/pessoas_form_screen.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class PessoasListScreen extends StatefulWidget {
  const PessoasListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PessoasListScreenState();
}

class _PessoasListScreenState extends State<PessoasListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PessoasListViewmodel>().carregarPessoas();
    });
  }

  void _abrirFormulario(int? id, bool modoEdicao) async {
    final viewmodel = context.read<PessoasListViewmodel>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (context) =>
              PessoasFormViewmodel(context.read<PessoaRepository>()),
          child: PessoasFormScreen(id, modoEdicao),
        ),
      ),
    );
    if (!mounted) return;
    viewmodel.carregarPessoas();
  }

  void _confirmarExcluir(Pessoa pessoa) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Excluir Pessoa',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Deseja excluir a pessoa com o nome: "${pessoa.nome}"?',
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
              final viewModel = context.read<PessoasListViewmodel>();
              final sucesso = await viewModel.deletar(pessoa.id!);
              if (!mounted) return;
              if (sucesso) {
                viewModel.carregarPessoas();
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
        title: Text('Pessoas', style: GoogleFonts.poppins(fontSize: 28)),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _abrirFormulario(null, false),
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
                  Icon(Icons.person_add, size: 40),
                  const SizedBox(width: 10),
                  Text(
                    'Adicionar pessoa',
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
              child: Consumer<PessoasListViewmodel>(
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
                        'Nenhuma pessoa encontrada',
                        style: GoogleFonts.poppins(
                          color: CoresApp.grafite,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: viewmodel.pessoas.length,
                    itemBuilder: ((context, index) =>
                        _cardPessoa(viewmodel.pessoas[index])),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardPessoa(Pessoa pessoa) {
    return Card(
      key: ValueKey(pessoa.id),
      color: CoresApp.cinzaGrafite,
      child: ListTile(
        title: Text(
          pessoa.nome.toUpperCase(),
          style: GoogleFonts.poppins(
            color: CoresApp.branco,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          'CPF: ${pessoa.cpf}\nTel: ${pessoa.telefone}',
          style: GoogleFonts.poppins(color: CoresApp.branco, fontSize: 17),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _abrirFormulario(pessoa.id, true),
              icon: const Icon(Icons.edit, color: CoresApp.branco),
            ),
            IconButton(
              onPressed: () => _confirmarExcluir(pessoa),
              icon: const Icon(Icons.delete, color: CoresApp.branco),
            ),
          ],
        ),
      ),
    );
  }
}
