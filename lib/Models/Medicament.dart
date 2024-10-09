class Medicament {
  int id; 
  String nom; 
  String description;
  DateTime date_expiration;
  int stock_dispo;
  String forme_pharmacotique;
  double dosage;
  bool avecOrdonnance;
  int limite;

    Medicament(
    this.id,
    this.nom,
    this.description,
    this.date_expiration,
    this.stock_dispo,
    this.forme_pharmacotique,
    this.dosage,
    this.avecOrdonnance,
    this.limite
    );

  Medicament.fromJson(Map tab) :
    id = tab['id'],
    nom = tab['nom'],
    description = tab['description'],
    date_expiration = tab['date_expiration'],
    stock_dispo = tab['stock_dispo'],
    forme_pharmacotique = tab['forme_pharmacotique'],
    dosage = tab['dosage'],
    avecOrdonnance = tab['avecOrdonnance'],
    limite = tab['limite'];

    void minusStock(){
      stock_dispo--;
    }
    void plusStock(){
      stock_dispo++;
    }
}