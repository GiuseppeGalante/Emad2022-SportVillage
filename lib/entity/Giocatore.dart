import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/Utente.dart';

final databaseReference= FirebaseDatabase.instance.reference();
var details = {'Usrname':'tom','Password':'pass@123'};
class Giocatore extends Utente
{
  String nazionalita="";
  late int partite_giocate;
  late int vittorie;
  late int pareggi;
  late int sconfitte;



  @override
  String toString() {
    return 'Giocatore{nazionalita: $nazionalita, partite_giocate: $partite_giocate, vittorie: $vittorie, pareggi: $pareggi, sconfitte: $sconfitte }'+super.toString();
  }

  Giocatore(){
    partite_giocate=0;
    vittorie=0;
    pareggi=0;
    sconfitte=0;
    bio="";
  }



  void setId(DatabaseReference id)
  {
    this.id=id;
  }

  Map<String, dynamic>toJson()
  {
    return {
      'nome':this.nome,
      'cognome':this.cognome,
      'email':this.email,
      'nome_utente':this.nome_utente,
      'password':this.password,
      'indirizzo':this.indirizzo,
      'numero_di_telefono':this.numero_di_telefono,
      'nascita':this.data_di_nascita,
      'bio':this.bio,
      'sesso':this.sesso.toString().split('.').last,
      'partite_giocate':this.partite_giocate,
      'vittorie':this.vittorie,
      'pareggi':this.pareggi,
      'sconfitte':this.sconfitte,
      'nazionalita':this.nazionalita
    };
  }

}

DatabaseReference saveGiocatore(Giocatore giocatore)
{
  var id = databaseReference.child("users/giocatori/").push();
  giocatore.id=id;
  id.set(giocatore.toJson());
  return id;
}