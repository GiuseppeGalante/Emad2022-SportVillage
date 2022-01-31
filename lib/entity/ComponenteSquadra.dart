import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';

final databaseReference= FirebaseDatabase.instance.reference();
class Componente
{
  late DatabaseReference id;
  String nome_utente="";
  String id_squadra="";
  String id_giocatore="";


  Map<String, dynamic> toJson({bool hide=false})
  {
    return {
      "id_giocatore":id_giocatore,
      "nome_utente": nome_utente,
      "id_squadra":id_squadra,
      "id_componente":id.key,
    };
  }



}



DatabaseReference saveComponente(componente)
{

    var id = databaseReference.child("componenti/").push();
    componente.id = id;
    id.set(componente.toJson());
    return id;
}

Future<List<Componente>> getComponenti(String squadra) async
{
  DatabaseEvent dataSnapshot = (await databaseReference.child('componenti/').orderByChild('id_squadra').equalTo(squadra).once()) as DatabaseEvent ;
  Componente componente;
  List<Componente> componenti=[];
  bool found=false;
  print("sono nelle richieste");
  if(dataSnapshot.snapshot.value != null)
  {
    Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
    values.forEach((key,value) =>{
      print(value),
      componente = new Componente(),
      componente.nome_utente=value["nome_utente"],
      componente.id_giocatore=value["id_giocatore"],
      /*squadra.id_squadra=value["id_squadra"],
      squadra.nome=value["nome"],
      squadra.partecipanti=value["partecipanti"],
      squadra.max_partecipanti=value["max_partecipanti"],*/
      componenti.add(componente),
    }
    );
  }
  //squadre.sort((a, b) => a.nome.compareTo(b.nome));

  return componenti;
}