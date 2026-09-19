abstract class BackupRepository {
  Future<String?> escolherPasta();
  Future<String?> selecionarArquivoBackup();
  Future<String?> obterPasta();
  Future<String?> obterFrequencia();
  Future<void> salvarFrequencia(String frequencia);
  Future<void> criarBackup();
  Future<void> restaurarBackup({String? conteudoBackup});
  Future<bool> precisaFazerBackup();
  Future<bool> existeDadosLocais();
}