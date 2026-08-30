import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/presentation/viewmodels/veiculo_form_viewmodel.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class VeiculoFormScreen extends StatefulWidget {
  final int? veiculoId;
  final int idExcursao;
  final bool modoEdicao;
  const VeiculoFormScreen(
    this.veiculoId,
    this.idExcursao,
    this.modoEdicao, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _VeiculoFormScreenState();
}

class _VeiculoFormScreenState extends State<VeiculoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _capacidadeController;

  @override
  void initState() {
    super.initState();
    _capacidadeController = TextEditingController();

    if (widget.veiculoId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _carregarDados();
      });
    }
  }

  Future<void> _carregarDados() async {
    final viewmodel = context.read<VeiculoFormViewmodel>();
    await viewmodel.carregarVeiculo(widget.veiculoId!);
    if (!mounted) return;
    _capacidadeController.text = viewmodel.veiculo!.capacidade.toString();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final viewmodel = context.read<VeiculoFormViewmodel>();

    final capacidade = int.parse(_capacidadeController.text.trim());

    final sucesso = await viewmodel.salvarVeiculo(
      id: widget.veiculoId,
      idExcursao: widget.idExcursao,
      capacidade: capacidade,
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
    final viewmodel = context.watch<VeiculoFormViewmodel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.modoEdicao ? 'Editar Veículo' : 'Adicionar Veículo',
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
                    return 'A quantidade de assentos não pode estar vazia';
                  }
                  final capacidade = int.tryParse(value);

                  if (capacidade == null || capacidade < 1 || capacidade > 60) {
                    return 'Digite um valor válido entre 1 e 60';
                  }
                  return null;
                },
                controller: _capacidadeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'Quantidade de assentos',
                  labelText: 'Quantidade de assentos',
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
                        widget.modoEdicao ? 'Editar' : 'Criar',
                        style: GoogleFonts.poppins(fontSize: 20),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
