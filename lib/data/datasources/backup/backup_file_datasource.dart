import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class BackupFileDatasource {
  static const _nomePastaApp = 'SSPMANOViagens';
  static const _nomeArquivo = 'backup.json';

  Future<void> solicitarPermissaoBackup() async {
    if (!Platform.isAndroid) {
      return;
    }

    final statusStorage = await Permission.storage.status;
    if (statusStorage.isGranted) {
      return;
    }

    final statusSolicitado = await Permission.storage.request();
    if (statusSolicitado.isGranted) {
      return;
    }

    if (await Permission.manageExternalStorage.status.isGranted) {
      return;
    }

    final statusGerenciamento = await Permission.manageExternalStorage.request();
    if (!statusGerenciamento.isGranted && !statusSolicitado.isGranted) {
      throw StateError('Permissão de acesso ao armazenamento foi negada.');
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
  }) async {
    await solicitarPermissaoBackup();

    final diretorio = Directory('$pasta/$_nomePastaApp');

    if (!await diretorio.exists()) {
      await diretorio.create(recursive: true);
    }

    final arquivo = File('${diretorio.path}/$_nomeArquivo');
    await arquivo.writeAsString(conteudo);
  }

  Future<String?> lerBackup({required String pasta}) async {
    final arquivo = File('$pasta/$_nomePastaApp/$_nomeArquivo');

    if (!await arquivo.exists()) {
      return null;
    }

    return arquivo.readAsString();
  }

  Future<String?> lerArquivoBackup(String caminhoArquivo) async {
    final arquivo = File(caminhoArquivo);

    if (!await arquivo.exists()) {
      return null;
    }

    return arquivo.readAsString();
  }
}