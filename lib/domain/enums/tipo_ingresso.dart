enum TipoIngresso {
  inteira(1, 'Inteira'),
  meia(2, 'Meia'),
  teen(3, 'Teen'),
  kids(4, 'Kids');

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
