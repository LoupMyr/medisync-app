enum MomentJournee {
  matin(1),
  midi(2),
  soir(3);

  final int valeur;

  const MomentJournee(this.valeur);

  static MomentJournee? fromValue(int valeur) {
    return MomentJournee.values.firstWhere((moment) => moment.valeur == valeur);
  }
}
