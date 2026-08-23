enum PagamentoStatus {
  pendente(1, 'PENDENTE'),
  pago(2, 'PAGO');

  final int id;
  final String pagamentoStatus;

  const PagamentoStatus(this.id, this.pagamentoStatus);
}