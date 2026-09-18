import 'dart:io';
import 'package:file_picker/file_picker.dart';

class BackupFileDatasource {
  static const _nomePastaApp = 'SSPMANOViagens';
  static const _nomeArquivo = 'backup.json';

  Future<String?> escolherPasta() async {
    return FilePicker.getDirectoryPath();
  }

  Future<void> salvarBackup({
    required String pasta,
    required String conteudo,
  }) async {
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
}