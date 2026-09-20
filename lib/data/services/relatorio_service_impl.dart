import 'package:sspmano_viagens/data/dto/excursao_relatorio_dto.dart';
import 'package:sspmano_viagens/domain/repositories/excursao_repository.dart';
import 'package:sspmano_viagens/domain/repositories/passageiro_repository.dart';
import 'package:sspmano_viagens/presentation/services/relatorio_service.dart';

class RelatorioServiceImpl implements RelatorioService {
  final ExcursaoRepository _excursaoRepository;
  final PassageiroRepository _passageiroRepository;

  RelatorioServiceImpl(this._excursaoRepository, this._passageiroRepository);

  Future<ExcursaoRelatorioDto> montarRelatorio(int idExcursao) async {
    final excursao = await _excursaoRepository.listarPorId(idExcursao);
    if (excursao == null) {
      throw ArgumentError('Excursão não encontrada');
    }

    final veiculos = await _passageiroRepository.listarAgrupadoPorVeiculo(
      idExcursao,
    );

    return ExcursaoRelatorioDto(excursao: excursao, veiculos: veiculos);
  }
}
