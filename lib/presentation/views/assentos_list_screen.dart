import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sspmano_viagens/domain/entities/passageiro.dart';
import 'package:sspmano_viagens/presentation/viewmodels/assentos_list_viewmodel.dart';
import 'package:sspmano_viagens/presentation/views/assento_detalhes_screen.dart';
import 'package:sspmano_viagens/presentation/views/selecionar_passageiro_screen.dart';
import 'package:sspmano_viagens/utils/cores_app.dart';

class AssentosListScreen extends StatefulWidget {
  final int quantidadeAssentos;
  final int idVeiculo;
  const AssentosListScreen({
    super.key,
    required this.quantidadeAssentos,
    required this.idVeiculo,
  });

  @override
  State<StatefulWidget> createState() => _AssentosListScreenState();
}

class _AssentosListScreenState extends State<AssentosListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AssentosListViewmodel>().carregarPassageirosVeiculo(
        widget.idVeiculo,
      );
    });
  }

  Color _statusAssento(Passageiro? passageiro) {
    if (passageiro == null) {
      // Assento livre
      return CoresApp.verdeClaro;
    } else {
      // Assento ocupado
      return CoresApp.vinho;
    }
  }

  void _abrirDetalhesAssento(int numAssento, Passageiro? passageiro) async {
    final viewmodel = context.read<AssentosListViewmodel>();
    if (passageiro == null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SelecionarPassageiroScreen(
            numAssento: numAssento,
            idVeiculo: widget.idVeiculo,
          ),
        ),
      );
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AssentoDetalhesScreen(numAssento, widget.idVeiculo),
        ),
      );
    }
    if (!mounted) return;
    await viewmodel.carregarPassageirosVeiculo(widget.idVeiculo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assentos', style: GoogleFonts.poppins(fontSize: 28)),
        backgroundColor: CoresApp.vermelho,
        foregroundColor: CoresApp.branco,
      ),
      body: SafeArea(child: _mapearAssentos(widget.quantidadeAssentos)),
    );
  }

  Widget _mapearAssentos(int quantidade) {
    return Consumer<AssentosListViewmodel>(
      builder: (context, viewmodel, child) {
        if (viewmodel.estaCarregando) {
          return const Center(
            child: CircularProgressIndicator(color: CoresApp.vermelho),
          );
        }
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
            // Descobre em qual coluna da grade o item está
            // Como a grade possui 5 colunas, o resto da divisão por 5
            // sempre será 0, 1, 2, 3 ou 4.
            final coluna = index % 5;
            // Descobre em qual fileira o item está.
            // O operador ~/ faz uma divisão inteira, descartando as casas decimais.
            // Exemplo: index 0 a 4 → fileira 0
            //          index 5 a 9 → fileira 1
            //          index 10 a 14 → fileira 2
            final fileira = index ~/ 5;

            // A coluna 2 representa o espaço central do ônibus,
            // que será usado como corredor em vez de receber um assento
            if (coluna == 2) {
              // Corredor
              return const SizedBox();
            }

            // Calcula o número do assento
            // Cada fileira possui 4 assentos, então:
            // fileira * 4 --> pula os assentos das fileiras anteriores
            // Se a coluna for 3 ou 4, subtrai 1 porque existe uma
            // posição reservada para o corredor na coluna 2
            // Soma 1 para ajustar o inicio do vetor de 0 para 1
            final numeroAssento =
                (fileira * 4 + (coluna > 2 ? coluna - 1 : coluna)) + 1;

            // Não criar posições depois do último assento
            if (numeroAssento > quantidade) {
              return const SizedBox();
            }

            final passageiro = viewmodel.buscarPassageiroPeloAssento(
              numeroAssento,
            );

            // Botão do assento
            return TextButton(
              onPressed: () {
                _abrirDetalhesAssento(numeroAssento, passageiro);
              },
              style: TextButton.styleFrom(
                minimumSize: const Size(10, 10),
                backgroundColor: _statusAssento(passageiro),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Center(
                child: Text(
                  '$numeroAssento',
                  style: GoogleFonts.poppins(
                    color: CoresApp.branco,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
