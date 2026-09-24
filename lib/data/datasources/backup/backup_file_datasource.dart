import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BackupFileDatasource {
  static const _nomePastaApp = 'SSPMANOViagens';
  static const _nomeArquivo = 'backup.json';

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

    final diretorio = await _resolverDiretorioBackup(pasta);
    final arquivo = File('$diretorio/$_nomeArquivo');

    await arquivo.writeAsString(conteudo);
  }

  Future<String?> lerBackup({required String pasta}) async {
    final diretorio = await _resolverDiretorioBackup(pasta);
    final arquivo = File('$diretorio/$_nomeArquivo');

    if (!await arquivo.exists()) {
      return null;
    }

    return arquivo.readAsString();
  }

  Future<String> _resolverDiretorioBackup(String pasta) async {
    final appDocumentsPath = (await getApplicationDocumentsDirectory()).path;
    final diretorios = <Directory>[
      Directory('$pasta/$_nomePastaApp'),
      Directory('/storage/emulated/0/Download/$_nomePastaApp'),
      Directory('$appDocumentsPath/$_nomePastaApp'),
    ];

    for (final diretorio in diretorios) {
      if (await _podeEscreverNoDiretorio(diretorio)) {
        return diretorio.path;
      }
    }

    final fallback = Directory('$appDocumentsPath/$_nomePastaApp');
    await fallback.create(recursive: true);
    return fallback.path;
  }

  Future<bool> _podeEscreverNoDiretorio(Directory diretorio) async {
    try {
      if (!await diretorio.exists()) {
        await diretorio.create(recursive: true);
      }

      final arquivoTeste = File('${diretorio.path}/.backup_write_test');
      await arquivoTeste.writeAsString('ok');
      await arquivoTeste.delete();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> lerArquivoBackup(String caminhoArquivo) async {
    final arquivo = File(caminhoArquivo);

    if (!await arquivo.exists()) {
      return null;
    }

    return arquivo.readAsString();
  }
}