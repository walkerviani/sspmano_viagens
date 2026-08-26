import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/presentation/viewmodels/pessoas_form_viewmodel.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class PessoasFormScreen extends StatefulWidget {
  final int? pessoaId;
  final bool modoEdicao;
  const PessoasFormScreen(this.pessoaId, this.modoEdicao, {super.key});

  @override
  State<StatefulWidget> createState() => _PessoasFormScreenState();
}

class _PessoasFormScreenState extends State<PessoasFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeController;
  late final TextEditingController _cpfController;
  late final TextEditingController _telefoneController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _cpfController = TextEditingController();
    _telefoneController = TextEditingController();

    if (widget.pessoaId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _carregarDados();
      });
    }
  }

  Future<void> _carregarDados() async {
    final viewmodel = context.read<PessoasFormViewmodel>();
    await viewmodel.carregarPessoa(widget.pessoaId!);
    if (!mounted) return;
    _nomeController.text = viewmodel.pessoa!.nome;
    _cpfController.text = viewmodel.pessoa!.cpf;
    _telefoneController.text = viewmodel.pessoa!.telefone;
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final viewmodel = context.read<PessoasFormViewmodel>();

    final nome = _nomeController.text.trim();
    final cpf = _cpfController.text.trim();
    final telefone = _telefoneController.text.trim();

    final sucesso = await viewmodel.salvarPessoa(
      id: widget.pessoaId,
      nome: nome,
      cpf: cpf,
      telefone: telefone,
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
    final viewmodel = context.watch<PessoasFormViewmodel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.modoEdicao ? 'Editar Pessoa' : 'Adicionar pessoa',
          style: GoogleFonts.poppins(fontSize: 28),
        ),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome não pode estar vazio';
                  }
                  if (value.trim().length > 50) {
                    return 'O Nome precisa ser menor que 50 caracteres';
                  }
                  if (value.trim().length < 3) {
                    return 'O nome precisa ter mais que 3 caracteres';
                  }
                  return null;
                },
                controller: _nomeController,
                maxLength: 50,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'Nome',
                  labelText: 'Nome',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O CPF não pode estar vazio';
                  }
                  final cpf = value.trim();
                  if (cpf.length < 11 || cpf.length > 11) {
                    return 'O CPF precisa ter 11 dígitos';
                  }
                  return null;
                },
                controller: _cpfController,
                maxLength: 11,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'CPF',
                  labelText: 'CPF',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 10),

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O Telefone não pode estar vazio';
                  }
                  final telefone = value.trim();
                  if (telefone.length < 11 || telefone.length > 11) {
                    return 'O telefone precisa ter 11 dígitos';
                  }
                  return null;
                },
                controller: _telefoneController,
                maxLength: 11,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'Telefone',
                  labelText: 'Telefone',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: viewmodel.estaCarregando ? null : _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CoresApp.verdeClaro,
                  foregroundColor: CoresApp.branco,
                  minimumSize: Size(double.infinity, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: viewmodel.estaCarregando
                    ? const CircularProgressIndicator(color: CoresApp.grafite)
                    : Text(
                        widget.modoEdicao ? 'Editar' : 'Adicionar',
                        style: GoogleFonts.poppins(fontSize: 20),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }
}
