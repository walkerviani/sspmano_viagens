import 'package:sspmano_viagens/domain/entities/passageiro.dart';
import 'package:sspmano_viagens/domain/entities/pessoa.dart';

class PassageiroComPessoaDto {
  final Passageiro passageiro;
  final Pessoa pessoa;

  const PassageiroComPessoaDto({
    required this.passageiro,
    required this.pessoa,
  });
}
