import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/presentation/viewmodels/pessoas_form_viewmodel.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';
import 'package:sspmano_viagens/utils/formatadores.dart';

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
    _cpfController.text = formatarCpf(viewmodel.pessoa!.cpf);
    _telefoneController.text = formatarTelefone(viewmodel.pessoa!.telefone);
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final viewmodel = context.read<PessoasFormViewmodel>();

    final nome = _nomeController.text.trim();
    final cpf = UtilBrasilFields.removeCaracteres(_cpfController.text);
    final telefone = UtilBrasilFields.removeCaracteres(
      _telefoneController.text,
    );

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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'Nome',
                  counterText: '',
                  hintStyle: GoogleFonts.poppins(fontSize: 18),
                  labelText: 'Nome',
                  labelStyle: GoogleFonts.poppins(fontSize: 18),
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
                  final cpf = UtilBrasilFields.removeCaracteres(value);
                  if (cpf.length != 11) {
                    return 'O CPF precisa ter 11 dígitos';
                  }
                  if (!UtilBrasilFields.isCPFValido(cpf)) {
                    return 'CPF inválido';
                  }
                  return null;
                },
                controller: _cpfController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'CPF',
                  hintStyle: GoogleFonts.poppins(fontSize: 18),
                  labelText: 'CPF',
                  labelStyle: GoogleFonts.poppins(fontSize: 18),
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
              ),

              const SizedBox(height: 10),

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O telefone não pode estar vazio';
                  }
                  final telefone = UtilBrasilFields.removeCaracteres(value);
                  if (telefone.length != 10 && telefone.length != 11) {
                    return 'O telefone precisa ter 10 ou 11 dígitos';
                  }
                  return null;
                },
                controller: _telefoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'Telefone',
                  counterText: '',
                  hintStyle: GoogleFonts.poppins(fontSize: 18),
                  labelText: 'Telefone',
                  labelStyle: GoogleFonts.poppins(fontSize: 18),
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneOuCelularInputFormatter(),
                ],
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
