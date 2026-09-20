import 'package:sspmano_viagens/data/dto/excursao_relatorio_dto.dart';

abstract class RelatorioService {
  Future<ExcursaoRelatorioDto> montarRelatorio(int idExcursao);
}
