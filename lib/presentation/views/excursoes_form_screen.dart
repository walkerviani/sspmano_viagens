import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class ExcursoesFormScreen extends StatefulWidget {
  final bool modoEdicao;
  const ExcursoesFormScreen({super.key, required this.modoEdicao});

  @override
  State<StatefulWidget> createState() => _ExcursoesFormScreenState();
}

class _ExcursoesFormScreenState extends State<ExcursoesFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? selecionado = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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
        _dataController.text = _formatarData(selecionado);
      });
    }
  }

  Future<void> _selecionarHora(BuildContext context) async {
    final TimeOfDay? selecionado = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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
                return CoresApp.grafite;
              })),
              dialTextColor: CoresApp.branco,
              dialBackgroundColor: CoresApp.grafite,
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
        _horaController.text = selecionado.format(context);
      });
    }
  }

  String _formatarData(DateTime data) {
    return DateFormat('dd/MM/yyyy').format(data);
  }

  @override
  Widget build(BuildContext context) {
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
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome não pode estar vazio';
                  }
                  return null;
                },
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

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
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

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
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

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A quantidade não pode estar vazia';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    return;
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CoresApp.verdeClaro,
                  foregroundColor: CoresApp.branco,
                  minimumSize: Size(double.infinity, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
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
