import 'package:sspmano_viagens/data/dto/passageiros_por_veiculo_dto.dart';
import 'package:sspmano_viagens/domain/entities/excursao.dart';

class ExcursaoRelatorioDto {
  final Excursao excursao;
  final List<PassageirosPorVeiculoDto> veiculos;

  const ExcursaoRelatorioDto({required this.excursao, required this.veiculos});
}
