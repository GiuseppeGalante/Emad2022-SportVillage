import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/entity/Sport.dart';

final databaseReference= FirebaseDatabase.instance.reference();

class TorneoAccettato
{
  late DatabaseReference id;
  String? id_centro_sportivo="";
  int numero_di_partecipanti=0;
  int squadre_confermate=0;
  String nome="";
  String id_torneo="";
  String id_giocatore="";
  String id_amministratore="";
  String indirizzo="";
  late SportClass sport;
  String modalita="";
  late double distanza;


  Map<String, dynamic> toJson({bool hide=false})
  {
    return {

      "nome": nome,
      "modalita": modalita.toString().split('.').last,
      "numero_di_partecipanti":numero_di_partecipanti,
      "squadre_confermate":squadre_confermate,
      "sport": sport.sport.toString().split('.').last,
      "id_centrosportivo":id_centro_sportivo,
      "id_giocatore": id_giocatore,
      "id_torneo":id_torneo,
      "id_amministratore": id_amministratore,
      "indirizzo": indirizzo
    };
  }

  @override
  String toString() {
    String m=modalita.toString().split(".").last;
    String s=sport.sport.toString().split(".").last;
    return 'RichiestaTorneo{nome: $nome, modalita: $m, numero_partecipanti: $numero_di_partecipanti, id_centro_sportivo: $id_centro_sportivo,id_giocatore: $id_giocatore, id_amministratore: $id_amministratore, sport: $s}';
  }

  Future<void> aggiungiSquadraCompletata(String id_torneo)
  {
    var id=databaseReference.child("torneiaccettati/").child(id_torneo).child("squadre_confermate").set(ServerValue.increment(1));
    return id;
  }

}


DatabaseReference saveTorneoAccettato(TorneoAccettato torneo)
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

Future<List<TorneoAccettato>> getTorneiAccettati() async
{
  DatabaseEvent dataSnapshot = await databaseReference.child('torneiaccettati/').once() as DatabaseEvent;
  TorneoAccettato richiestatorneo;
  List<TorneoAccettato> tornei=[];
  bool found=false;
  print("sono nelle richieste");

    if(dataSnapshot.snapshot.value != null)
    {
      Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
      values.forEach((key,value) =>
      {
        print(value),

        richiestatorneo = new TorneoAccettato(),
        richiestatorneo.nome = value["nome"],
        richiestatorneo.id_torneo = value["id_torneo"],
        richiestatorneo.id_centro_sportivo = value["id_centrosportivo"],
        richiestatorneo.id_amministratore = value["id_amministratore"],
        richiestatorneo.id_giocatore = value["id_giocatore"],
        richiestatorneo.numero_di_partecipanti = value["numero_di_partecipanti"],
        richiestatorneo.squadre_confermate=value["squadre_confermate"],
        richiestatorneo.modalita = value["modalita"],
        richiestatorneo.indirizzo = value["indirizzo"],
        richiestatorneo.sport =new SportClass(Sport.values.firstWhere((e) => e.toString() == 'Sport.' + value["sport"])),
        richiestatorneo.id = databaseReference.child('torneiaccettati/'+key),
        tornei.add(richiestatorneo),
        print(tornei)
      }
          );
      }
  return tornei;
    }


