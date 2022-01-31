import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';

final databaseReference= FirebaseDatabase.instance.reference();

class TorneoPronto
{
  String? id_centro_sportivo="";
  int numero_di_partecipanti=0;
  int squadre_confermate=0;
  String nome="";
  String id_torneo="";
  String id_giocatore="";
  String id_amministratore="";
  String sport="";
  String modalita="";

  late DatabaseReference id;


  Map<String, dynamic> toJson({bool hide=false})
  {
    return {

      "nome": nome,
      "modalita": modalita.toString().split('.').last,
      "numero_di_partecipanti":numero_di_partecipanti,
      "squadre_confermate":squadre_confermate,
      "sport": sport.toString().split('.').last,
      "id_centrosportivo":id_centro_sportivo,
      "id_giocatore": id_giocatore,
      "id_torneo":id_torneo,
      "id_amministratore": id_amministratore,
    };
  }

  @override
  String toString() {
    String m=modalita.toString().split(".").last;
    String s=sport.toString().split(".").last;
    return 'RichiestaTorneo{nome: $nome, modalita: $m, numero_partecipanti: $numero_di_partecipanti,squadre_confermate: $squadre_confermate, id_centro_sportivo: $id_centro_sportivo,id_giocatore: $id_giocatore, id_amministratore: $id_amministratore, sport: $s}';
  }

}


DatabaseReference saveTorneoAccettato(TorneoPronto torneo)
{
  var id = databaseReference.child("torneiaccettati/").push();
  id.set(torneo.toJson());
  return id;
}

Future<void> deleteRichiestaAccettata(String id_torneo)
{
  var id = databaseReference.child("richiestetornei/").child(id_torneo).remove();
  print(id_torneo);
  return id;
}

Future<List<TorneoPronto>> getTorneiPronti(String giocatore) async
{
  DatabaseEvent dataSnapshot = await databaseReference.child('torneiaccettati/').orderByChild('id_giocatore').equalTo(giocatore).once() as DatabaseEvent;
  TorneoPronto torneo;
  List<TorneoPronto> tornei=[];
  bool found=false;
  print("sono nelle richieste");

  if(dataSnapshot.snapshot.value != null)
  {
    Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
    values.forEach((key,value) =>
    {
      print(value),

      torneo = new TorneoPronto(),
      torneo.nome = value["nome"],
      torneo.id_torneo = value["id_torneo"],
      torneo.id_centro_sportivo = value["id_centrosportivo"],
      torneo.id_amministratore = value["id_amministratore"],
      torneo.id_giocatore = value["id_giocatore"],
      torneo.numero_di_partecipanti =
      value["numero_di_partecipanti"],
      torneo.squadre_confermate=value["squadre_confermate"],
      torneo.modalita = value["modalita"],
      torneo.sport = value["sport"],
      torneo.id = databaseReference.child('torneiaccettati/'+key),
      tornei.add(torneo),
      print(tornei)
    }
    );
  }
  return tornei;
}
