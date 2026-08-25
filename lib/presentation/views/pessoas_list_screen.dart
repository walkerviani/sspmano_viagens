import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/domain/repositories/pessoa_repository.dart';
import 'package:sspmano_viagens/presentation/viewmodels/pessoas_form_viewmodel.dart';
import 'package:sspmano_viagens/presentation/views/pessoas_form_screen.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class PessoasListScreen extends StatefulWidget {
  const PessoasListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PessoasListScreenState();
}

class _PessoasListScreenState extends State<PessoasListScreen> {
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => PessoasFormViewmodel(
                        context.read<PessoaRepository>(),
                      ),
                      child: PessoasFormScreen(null, false),
                    ),
                  ),
                );
              },
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
          ],
        ),
      ),
    );
  }
}
