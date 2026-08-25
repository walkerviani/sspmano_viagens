import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class SelecionarPassageiroScreen extends StatefulWidget {
  const SelecionarPassageiroScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SelecionarPassageiroScreenState();
}

class _SelecionarPassageiroScreenState
    extends State<SelecionarPassageiroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passageiros', style: GoogleFonts.poppins(fontSize: 28)),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: Container(padding: EdgeInsets.all(12), child: _cardPassageiro()),
    );
  }

  Widget _cardPassageiro() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          title: Text(
            'Nome do passageiro',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '999.999.999-99 | 19971343538',
            style: GoogleFonts.poppins(fontSize: 15),
          ),
          trailing: IconButton(
            onPressed: () {},
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
