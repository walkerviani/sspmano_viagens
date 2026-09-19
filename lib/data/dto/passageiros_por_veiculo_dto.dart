import 'package:sspmano_viagens/data/dto/passageiro_com_pessoa_dto.dart';
import 'package:sspmano_viagens/domain/entities/veiculo.dart';

class PassageirosPorVeiculoDto {
  final Veiculo veiculo;
  final List<PassageiroComPessoaDto> passageiros;

  const PassageirosPorVeiculoDto({
    required this.veiculo,
    required this.passageiros,
  });
}
