import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Sport.dart';

final databaseReference= FirebaseDatabase.instance.reference();

enum Modalita{
  Andata,
  Andata_e_Ritorno,
  All_Italiana
}


class RichiestaTorneo
{
  String? id_centro_sportivo="";
  int numero_di_partecipanti=0;
  int squadre_confermate=0;
  String nome="";
  String id_giocatore="";
  String id_richiesta_torneo="";
  String id_amministratore="";
  late DatabaseReference id;
  late SportClass sport;
  late Modalita modalita;


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
      "id_richiesta_torneo":id.key,
      "id_amministratore": id_amministratore,
    };
  }

  @override
  String toString() {
    String m=modalita.toString().split(".").last;
    String s=sport.toString().split(".").last;
    return 'RichiestaTorneo{nome: $nome, modalita: $m, numero_partecipanti: $numero_di_partecipanti, id_centro_sportivo: $id_centro_sportivo,id_giocatore: $id_giocatore, id_amministratore: $id_amministratore, id: ${id.key}, sport: $s}';
  }

}


DatabaseReference saveRichiestaTorneo(RichiestaTorneo richiesta)
{
  var id = databaseReference.child("richiestetornei/").push();
  richiesta.id=id;
  id.set(richiesta.toJson());
  return id;
}

Future<List<RichiestaTorneo>> getRichiesteTornei({AmministstratoreCentroSportivo? acs}) async
{
  DatabaseEvent dataSnapshot = (await databaseReference.child('richiestetornei/').once()) as DatabaseEvent;
  RichiestaTorneo richiestatorneo;
  List<RichiestaTorneo> richiestenuovitornei=[];
  bool found=false;
  //print("sono nelle richieste");
  if(acs != null)
  {
    if(dataSnapshot.snapshot.value != null)
    {
      Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
      values.forEach((key,value) =>{
        print(value),
        print(acs.id.key),
        if(value["id_amministratore"] == acs.id.key)
          {
            richiestatorneo = new RichiestaTorneo(),
            richiestatorneo.nome=value["nome"],
            richiestatorneo.id_centro_sportivo=value["id_centrosportivo"],
            richiestatorneo.id_richiesta_torneo=value["id_richiesta_torneo"],
            richiestatorneo.id_amministratore=value["id_amministratore"],
            richiestatorneo.id_giocatore=value["id_giocatore"],
            richiestatorneo.numero_di_partecipanti=value["numero_di_partecipanti"],
            richiestatorneo.squadre_confermate=value["squadre_confermate"],
            richiestatorneo.modalita=Modalita.values.firstWhere((e) => e.toString() == 'Modalita.' + value["modalita"]),
            richiestatorneo.sport= new SportClass(Sport.values.firstWhere((e) => e.toString() == 'Sport.' + value["sport"])),
            richiestatorneo.id = databaseReference.child('centrisportivi/'+key),
            richiestenuovitornei.add(richiestatorneo),
            print(richiestenuovitornei)
          }
      }
      );
    }
  }

  return richiestenuovitornei;
}