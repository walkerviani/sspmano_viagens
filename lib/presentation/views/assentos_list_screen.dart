import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class AssentosListScreen extends StatefulWidget {
  const AssentosListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AssentosListScreenState();
}

class _AssentosListScreenState extends State<AssentosListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assentos', style: GoogleFonts.poppins(fontSize: 28)),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: SafeArea(child: _mapearAssentos(15)),
    );
  }

  Widget _mapearAssentos(int quantidade) {
    final linha = (quantidade / 4)
        .ceil(); // Quantas linhas horizontais vai precisar
    final posicoesGrid =
        linha * 5; // 5 posições por linha, sendo a do meio vazia

    return GridView.builder(
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: posicoesGrid,
      itemBuilder: (context, index) {
        final coluna =
            index %
            5; // Resto de uma divisão por 5 só pode ser um desses valores: 0, 1, 2, 3, 4
        final fileira = index ~/ 5;

        if (coluna == 2) {
          // Corredor
          return const SizedBox();
        }

        // Número do assento
        final numeroAssento = fileira * 4 + (coluna > 2 ? coluna - 1 : coluna);

        // Não criar posições depois do último assento
        if (numeroAssento >= quantidade) {
          return const SizedBox();
        }

        // Assento
        return Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: CoresApp.azulClaro,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              '${numeroAssento + 1}',
              style: GoogleFonts.poppins(
                color: CoresApp.branco,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
