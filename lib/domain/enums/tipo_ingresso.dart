enum TipoIngresso {
  inteira(1, 'INTEIRA'),
  meia(2, 'MEIA');

  final int id;
  final String tipoIngresso;

  const TipoIngresso(this.id, this.tipoIngresso);

  static TipoIngresso? deId(int? id) {
    for (final tipo in values) {
      if (tipo.id == id) return tipo;
    }
    return null;
  }
}
