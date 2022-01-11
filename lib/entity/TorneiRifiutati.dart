import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';

final databaseReference= FirebaseDatabase.instance.reference();

class TorneoRifiutato
{
  String? id_centro_sportivo="";
  int numero_di_partecipanti=0;
  String nome="";
  String id_torneo="";
  String id_giocatore="";
  String id_amministratore="";
  String sport="";
  String modalita="";


  Map<String, dynamic> toJson({bool hide=false})
  {
    return {

      "nome": nome,
      "modalita": modalita.toString().split('.').last,
      "numero_di_partecipanti":numero_di_partecipanti,
      "sport": sport.toString().split('.').last,
      "id_centrosportivo":id_centro_sportivo,
      "id_giocatore": id_giocatore,
      "id_torneo_rifiutato":id_torneo,
      "id_amministratore": id_amministratore,
    };
  }

  @override
  String toString() {
    String m=modalita.toString().split(".").last;
    String s=sport.toString().split(".").last;
    return 'RichiestaTorneo{nome: $nome, modalita: $m, numero_partecipanti: $numero_di_partecipanti, id_centro_sportivo: $id_centro_sportivo,id_giocatore: $id_giocatore, id_amministratore: $id_amministratore, sport: $s}';
  }

}


DatabaseReference saveTorneoRifiutato(TorneoRifiutato torneo)
{
  var id = databaseReference.child("torneirifiutati/").push();
  id.set(torneo.toJson());
  return id;
}

Future<List<TorneoRifiutato>> getTorneiRifiutati({AmministstratoreCentroSportivo? acs}) async
{
  DataSnapshot dataSnapshot = await databaseReference.child('torneirifiutati/').once();
  TorneoRifiutato richiestatorneo;
  List<TorneoRifiutato> richiestenuovitornei=[];
  bool found=false;
  print("sono nelle richieste");
  if(acs != null)
  {
    if(dataSnapshot.value != null)
    {
      dataSnapshot.value.forEach((key,value) =>{
        print(value),
        if(value["id_amministratore"] == acs.id.key)
          {
            richiestatorneo = new TorneoRifiutato(),
            richiestatorneo.nome=value["nome"],
            //richiestatorneo.id=value["id"],
            richiestatorneo.id_centro_sportivo=value["id_centrosportivo"],
            richiestatorneo.id_amministratore=value["id_amministratore"],
            richiestatorneo.id_giocatore=value["id_giocatore"],
            richiestatorneo.numero_di_partecipanti=value["numero_di_partecipanti"],
            richiestatorneo.modalita=value["modalita"],
            richiestatorneo.sport= value["sport"],
            //richiestatorneo.id = databaseReference.child('centrisportivi/'+key),
            richiestenuovitornei.add(richiestatorneo),
            print(richiestenuovitornei)
          }
      }
      );
    }
  }

  return richiestenuovitornei;
}

Future<void> deleteTorneoRifiutato(String id_torneo)
{
  var id = databaseReference.child("richiestetornei/").child(id_torneo).remove();
  print(id_torneo);
  return id;
}