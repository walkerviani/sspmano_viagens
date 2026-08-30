import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/presentation/viewmodels/excursoes_form_viewmodel.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class ExcursoesFormScreen extends StatefulWidget {
  final int? excursaoId;
  final bool modoEdicao;

  const ExcursoesFormScreen({
    super.key,
    this.excursaoId,
    required this.modoEdicao,
  });

  @override
  State<StatefulWidget> createState() => _ExcursoesFormScreenState();
}

class _ExcursoesFormScreenState extends State<ExcursoesFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeController;
  late final TextEditingController _dataController;
  late final TextEditingController _horaController;

  DateTime? _dataSelecionada;
  TimeOfDay? _horaSelecionada;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _dataController = TextEditingController();
    _horaController = TextEditingController();

    if (widget.excursaoId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _carregarDados();
      });
    }
  }

  Future<void> _carregarDados() async {
    final viewmodel = context.read<ExcursoesFormViewmodel>();
    await viewmodel.carregarExcursao(widget.excursaoId!);
    if (!mounted) return;

    final dataHora = viewmodel.excursao!.dataHora;
    _dataSelecionada = DateTime(dataHora.year, dataHora.month, dataHora.day);
    _horaSelecionada = TimeOfDay(hour: dataHora.hour, minute: dataHora.minute);
    _dataController.text = _formatarData(_dataSelecionada!);
    _horaController.text = _horaSelecionada!.format(context);
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final viewmodel = context.read<ExcursoesFormViewmodel>();

    final nome = _nomeController.text.trim();

    final sucesso = await viewmodel.salvarExcursao(
      id: widget.excursaoId,
      nome: nome,
      data: _dataSelecionada!,
      hora: _horaSelecionada!,
      qntAssentos: 0,
      idStatus: 1,
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

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? selecionado = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: CoresApp.vermelho),
          ),
          child: child!,
        );
      },
    );
    if (selecionado != null) {
      setState(() {
        _dataSelecionada = selecionado;
        _dataController.text = _formatarData(selecionado);
      });
    }
  }

  Future<void> _selecionarHora(BuildContext context) async {
    final TimeOfDay? selecionado = await showTimePicker(
      context: context,
      initialTime: _horaSelecionada ?? TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: CoresApp.vinho),
            ),

            timePickerTheme: TimePickerThemeData(
              backgroundColor: CoresApp.branco,
              hourMinuteColor: WidgetStateColor.resolveWith(((states) {
                if (states.contains(WidgetState.selected)) {
                  return CoresApp.vinho;
                }
                return Colors.blueGrey;
              })),
              dialTextColor: CoresApp.branco,
              dialBackgroundColor: Colors.blueGrey,
              hourMinuteTextColor: CoresApp.branco,
              dialHandColor: CoresApp.vinho,
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        );
      },
    );
    if (selecionado != null) {
      setState(() {
        _horaSelecionada = selecionado;
        _horaController.text = selecionado.format(context);
      });
    }
  }

  String _formatarData(DateTime data) {
    return DateFormat('dd/MM/yyyy').format(data);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _dataController.dispose();
    _horaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = context.watch<ExcursoesFormViewmodel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.modoEdicao ? 'Editar excursão' : 'Criar excursão',
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
              // Nome do evento
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome não pode estar vazio';
                  }
                  if (value.trim().length > 100) {
                    return 'O Nome precisa ser menor que 100 caracteres';
                  }
                  if (value.trim().length < 3) {
                    return 'O nome precisa ter mais que 3 caracteres';
                  }
                  return null;
                },
                controller: _nomeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'Nome da excursão',
                  labelText: 'Nome da excursão',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Data do evento
              TextFormField(
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      _dataSelecionada == null) {
                    return 'A data não pode estar vazia';
                  }
                  return null;
                },
                onTap: () => _selecionarData(context),
                readOnly: true,
                controller: _dataController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'Data do evento',
                  labelText: 'Data do evento',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Hora do evento
              TextFormField(
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      _horaSelecionada == null) {
                    return 'A Hora não pode estar vazia';
                  }
                  return null;
                },
                onTap: () => _selecionarHora(context),
                readOnly: true,
                controller: _horaController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'Hora do evento',
                  labelText: 'Hora do evento',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: viewmodel.estaCarregando ? null : _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CoresApp.verdeClaro,
                  foregroundColor: CoresApp.branco,
                  minimumSize: Size(double.infinity, 60),
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
