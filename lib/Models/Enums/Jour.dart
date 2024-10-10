enum Jour {
  lundi(1),
  mardi(2),
  mercredi(3),
  jeudi(4),
  vendredi(5),
  samedi(6),
  dimanche(7);

  final int valeur;

  const Jour(this.valeur);

  static Jour? fromValue(int valeur) {
    return Jour.values.firstWhere((jour) => jour.valeur == valeur);
  }
}
