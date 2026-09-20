import 'package:sspmano_viagens/data/dto/excursao_relatorio_dto.dart';
import 'package:sspmano_viagens/domain/entities/excursao.dart';

abstract class RelatorioService {
  Future<ExcursaoRelatorioDto> montarRelatorioExcursao(int idExcursao);
  Future<Excursao> buscarExcursao(int idExcursao);
}
