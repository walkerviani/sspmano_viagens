import 'package:flutter/material.dart';
import 'package:sspmano_viagens/domain/entities/excursao.dart';
import 'package:sspmano_viagens/domain/repositories/excursao_repository.dart';

class ExcursoesFormViewmodel extends ChangeNotifier {
  final ExcursaoRepository _repository;

  ExcursoesFormViewmodel(this._repository);
  bool estaCarregando = false;
  String? mensagemErro;
  Excursao? excursao;

  Future<void> carregarExcursao(int id) async {
    mensagemErro = null;
    estaCarregando = true;
    notifyListeners();

    try {
      excursao = await _repository.listarPorId(id);
    } catch (e) {
      mensagemErro = 'Erro ao carregar a excursão';
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }

  Future<bool> salvarExcursao({
    int? id,
    required String nome,
    required DateTime data,
    required TimeOfDay hora,
    required int qntAssentos,
    required int idStatus,
  }) async {
    mensagemErro = null;

    if (nome.trim().isEmpty) {
      mensagemErro = 'O nome não pode estar vazio';
      return false;
    }
    if (nome.length > 100) {
      mensagemErro = 'O Nome precisa ser menor que 100 caracteres';
      return false;
    }

    if (qntAssentos == 0) {
      mensagemErro = 'É preciso adicionar pelo menos um veículo';
      return false;
    }
    DateTime dataHora = DateTime(
      data.day,
      data.month,
      data.year,
      hora.minute,
      hora.hour,
    );

    estaCarregando = true;
    notifyListeners();

    try {
      Excursao excursao = Excursao(id, nome, dataHora, qntAssentos);
      if (id != null) {
        await _repository.atualizar(excursao);
      } else {
        await _repository.criar(excursao);
      }
      return true;
    } catch (e) {
      mensagemErro = 'Houve um erro ao salvar a excursão';
      return false;
    } finally {
      estaCarregando = false;
      notifyListeners();
    }
  }
}
