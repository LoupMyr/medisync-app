class Medicament {
  int id; 
  String nom; 
  String description;
  String date_expiration;
  int stock_dispo;
  String forme_pharmacotique;
  int dosage;
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
    id =  int.parse(tab['id'].toString()),
    nom = tab['nom'],
    description = tab['description'],
    date_expiration = tab['date_expiration'].toString(),
    stock_dispo =  int.parse(tab['id'].toString()),
    forme_pharmacotique = tab['forme_pharmacotique'],
    dosage =  int.parse(tab['id'].toString()),
    avecOrdonnance = bool.parse(tab['avecOrdonnance'].toString()),
    limite =  int.parse(tab['id'].toString());

    void minusStock(){
      stock_dispo--;
    }
    void plusStock(){
      stock_dispo++;
    }
}