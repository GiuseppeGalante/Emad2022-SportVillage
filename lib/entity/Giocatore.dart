import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/PartitaConfermata.dart';
import 'package:flutter_app_emad/entity/Utente.dart';

final databaseReference= FirebaseDatabase.instance.reference();
var details = {'Usrname':'tom','Password':'pass@123'};
class Giocatore extends Utente
{
  String nazionalita="";
  String indirizzo="";
  late int partite_giocate;
  late int vittorie;
  late int pareggi;
  late int sconfitte;
  late List<TorneiAccettati> ?partiteconfermate=[];


  @override
  String toString() {
    return 'Giocatore{nazionalita: $nazionalita, indirizzo: $indirizzo, partite_giocate: $partite_giocate, vittorie: $vittorie, pareggi: $pareggi, sconfitte: $sconfitte, partiteconfermate: $partiteconfermate}'+super.toString();
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

Future<Giocatore?> getGiocatore(Giocatore gio) async{
  DatabaseEvent dataSnapshot = (await databaseReference.child('users/giocatori/').once()) as DatabaseEvent;
  Giocatore giocatore = new Giocatore();
  bool found=false;
  bool complete=false;
  if(dataSnapshot.snapshot.value != null)
    {
      Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
      values.forEach((key,value) =>{
        if((value["nome_utente"] == gio.nome_utente) && (value["password"] == gio.password))
          {
            found=true,
            giocatore.nome=value["nome"],
            giocatore.cognome=value["cognome"],
              giocatore.email=value["email"],
          giocatore.nome_utente=value["nome_utente"],
          giocatore.password=value["password"],
          giocatore.indirizzo=value["indirizzo"],
          giocatore.numero_di_telefono=value["numero_di_telefono"],
          giocatore.data_di_nascita=value["nascita"],
          giocatore.bio=value["bio"],
            giocatore.sesso=Sesso.values.firstWhere((e) => e.toString() == 'Sesso.' + value["sesso"]),
            giocatore.partite_giocate=value["partite_giocate"],
            giocatore.vittorie=value["vittorie"],
            giocatore.pareggi=value["pareggi"],
            giocatore.sconfitte=value["sconfitte"],
            giocatore.nazionalita=value["nazionalita"],
            giocatore.id = databaseReference.child('users/giocatori/'+key),
          }

      }
      );
      if(found)
        {
          await getPartiteConfermate(idgioca: giocatore.id.key!).then((value) =>
          {
            giocatore.partiteconfermate=value,
          }
          );
        }

    }


  if(found)
    return giocatore;
  return null;
}

Future<List<Giocatore?>> getGiocatori() async{
  DatabaseEvent dataSnapshot = (await databaseReference.child('users/giocatori/').once()) as DatabaseEvent;
  Giocatore giocatore;
  List<Giocatore> giocatori=[];
  bool found=false;
  bool complete=false;
  if(dataSnapshot.snapshot.value != null)
  {
    Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
    values.forEach((key,value) =>{
        {
        giocatore = new Giocatore(),
          giocatore.nome=value["nome"],
          giocatore.cognome=value["cognome"],
          giocatore.email=value["email"],
          giocatore.nome_utente=value["nome_utente"],
          giocatore.password=value["password"],
          giocatore.indirizzo=value["indirizzo"],
          giocatore.numero_di_telefono=value["numero_di_telefono"],
          giocatore.data_di_nascita=value["nascita"],
          giocatore.bio=value["bio"],
          giocatore.sesso=Sesso.values.firstWhere((e) => e.toString() == 'Sesso.' + value["sesso"]),
          giocatore.partite_giocate=value["partite_giocate"],
          giocatore.vittorie=value["vittorie"],
          giocatore.pareggi=value["pareggi"],
          giocatore.sconfitte=value["sconfitte"],
          giocatore.nazionalita=value["nazionalita"],
          giocatore.id = databaseReference.child('users/giocatori/'+key),
        giocatori.add(giocatore)
        }

    }
    );

    {
      for(int i=0;i<giocatori.length;i++)
        {
          await getPartiteConfermate(idgioca: giocatori[i].id.key!).then((value) =>
          {
            giocatori[i].partiteconfermate=value,
          }
          );
        }

    }

  }

  return giocatori;
}