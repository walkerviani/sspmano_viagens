enum AssentoStatus {
  livre(1, 'LIVRE'),
  ocupado(2, 'OCUPADO');

  final int id;
  final String assentoStatus;

  const AssentoStatus(this.id, this.assentoStatus);
}