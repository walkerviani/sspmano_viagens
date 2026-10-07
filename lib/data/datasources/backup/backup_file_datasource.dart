import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class BackupFileDatasource {
  static const _prefixoArquivo = 'SSPMANO_Viagens_backup_';

  Future<void> solicitarPermissaoBackup({bool permitirSolicitar = true}) async {
    if (!Platform.isAndroid) {
      return;
    }

    final statusStorage = await Permission.storage.status;
    if (statusStorage.isGranted) {
      return;
    }

    if (!permitirSolicitar) {
      return;
    }

    try {
      final statusSolicitado = await Permission.storage.request();
      if (statusSolicitado.isPermanentlyDenied) {
        throw StateError('Permissão de armazenamento negada permanentemente.');
      }
      if (!statusSolicitado.isGranted) {
        throw StateError('Permissão de acesso ao armazenamento foi negada.');
      }
    } catch (e) {
      if (e.toString().contains('Unable to detect current Android Activity')) {
        throw StateError('Não foi possível solicitar permissão. Conceda a permissão na app antes de executar o backup.');
      }
      rethrow;
    }
  }

  Future<String?> escolherPasta() async {
    return FilePicker.getDirectoryPath();
  }

  Future<String?> escolherArquivoBackup() async {
    final arquivos = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (arquivos.isEmpty) {
      return null;
    }

    final arquivo = arquivos.first;
    final bytes = await arquivo.readAsBytes();

    if (bytes.isEmpty) {
      return null;
    }

    return utf8.decode(bytes, allowMalformed: true);
  }

  Future<void> salvarBackup({
    required String pasta,
    required String conteudo,
    bool solicitarPermissao = true,
  }) async {
    await solicitarPermissaoBackup(permitirSolicitar: solicitarPermissao);

    final diretorio = Directory(pasta);
    await diretorio.create(recursive: true);
    final dataHora = DateTime.now();
    final dataHoraFormatada =
        '${dataHora.year.toString().padLeft(4, '0')}'
        '${dataHora.month.toString().padLeft(2, '0')}'
        '${dataHora.day.toString().padLeft(2, '0')}'
        '${dataHora.hour.toString().padLeft(2, '0')}'
        '${dataHora.minute.toString().padLeft(2, '0')}'
        '${dataHora.second.toString().padLeft(2, '0')}';
    final nomeArquivo = '$_prefixoArquivo$dataHoraFormatada.json';
    final arquivo = File(path.join(diretorio.path, nomeArquivo));

    await arquivo.writeAsString(conteudo);
  }

  Future<String?> lerBackup({required String pasta}) async {
    final arquivos = await Directory(pasta)
        .list(followLinks: false)
        .where(
          (entidade) =>
              entidade is File &&
              path.basename(entidade.path).startsWith(_prefixoArquivo),
        )
        .map((entidade) => entidade as File)
        .toList();

    if (arquivos.isEmpty) {
      return null;
    }

    final arquivoMaisRecente = arquivos.reduce(
      (maisRecente, arquivo) => arquivo
              .lastModifiedSync()
              .compareTo(maisRecente.lastModifiedSync()) >
          0
          ? arquivo
          : maisRecente,
    );

    return arquivoMaisRecente.readAsString();
  }

  Future<String?> lerArquivoBackup(String caminhoArquivo) async {
    final arquivo = File(caminhoArquivo);

    if (!await arquivo.exists()) {
      return null;
    }

    return arquivo.readAsString();
  }
}