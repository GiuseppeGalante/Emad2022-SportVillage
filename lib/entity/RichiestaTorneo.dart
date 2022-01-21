import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';

final databaseReference= FirebaseDatabase.instance.reference();


enum Sport{
  calcio,
  pallavolo,
  padel,
  tennis,
  pingpong,
}

enum Modalita{
  Andata,
  Andata_e_Ritorno,
  All_Italiana
}


class RichiestaTorneo
{
  String? id_centro_sportivo="";
  int numero_di_partecipanti=0;
  String nome="";
  String id_giocatore="";
  String id_richiesta_torneo="";
  String id_amministratore="";
  late DatabaseReference id;
  late Sport sport;
  late Modalita modalita;


  Map<String, dynamic> toJson({bool hide=false})
  {
    return {

      "nome": nome,
      "modalita": modalita.toString().split('.').last,
      "numero_di_partecipanti":numero_di_partecipanti,
      "sport": sport.toString().split('.').last,
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
  DataSnapshot dataSnapshot = await databaseReference.child('richiestetornei/').once();
  RichiestaTorneo richiestatorneo;
  List<RichiestaTorneo> richiestenuovitornei=[];
  bool found=false;
  //print("sono nelle richieste");
  if(acs != null)
  {
    if(dataSnapshot.value != null)
    {
      dataSnapshot.value.forEach((key,value) =>{
        print(value),
        if(value["id_amministratore"] == acs.id.key)
          {
            richiestatorneo = new RichiestaTorneo(),
            richiestatorneo.nome=value["nome"],
            richiestatorneo.id_centro_sportivo=value["id_centrosportivo"],
            richiestatorneo.id_richiesta_torneo=value["id_richiesta_torneo"],
            richiestatorneo.id_amministratore=value["id_amministratore"],
            richiestatorneo.id_giocatore=value["id_giocatore"],
            richiestatorneo.numero_di_partecipanti=value["numero_di_partecipanti"],
            richiestatorneo.modalita=Modalita.values.firstWhere((e) => e.toString() == 'Modalita.' + value["modalita"]),
            richiestatorneo.sport= Sport.values.firstWhere((e) => e.toString() == 'Sport.' + value["sport"]),
            richiestatorneo.id = databaseReference.child('centrisportivi/'+key),
            richiestenuovitornei.add(richiestatorneo),
            //print(richiestenuovitornei)
          }
      }
      );
    }
  }

  return richiestenuovitornei;
}