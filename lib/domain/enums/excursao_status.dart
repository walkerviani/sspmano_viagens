enum ExcursaoStatus {
  emAberto(1, 'EM ABERTO'),
  finalizado(2, 'FINALIZADO');

  final int id;
  final String excursaoStatus;

  const ExcursaoStatus(this.id, this.excursaoStatus);
}