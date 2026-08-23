import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sspmano_viagens/domain/entities/passageiro.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class AssentoDetalhesScreen extends StatefulWidget {
  final Passageiro passageiro;
  const AssentoDetalhesScreen({super.key, required this.passageiro});

  @override
  State<StatefulWidget> createState() => _AssentoDetalhesScreenState();
}

class _AssentoDetalhesScreenState extends State<AssentoDetalhesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Assento (Número)',
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.passageiro.foiPago
                    ? CoresApp.vinho
                    : CoresApp.verdeClaro,
                foregroundColor: CoresApp.branco,
                minimumSize: Size(double.infinity, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                widget.passageiro.foiPago
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
                text: 'Nome: Marcela Araújo\n',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 15),
              ),
              TextSpan(
                text: '999.999.999-99 | 99999999999\n',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 15),
              ),

              TextSpan(
                text: 'Status de pagamento: Pago',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _botaoNavBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {},
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
