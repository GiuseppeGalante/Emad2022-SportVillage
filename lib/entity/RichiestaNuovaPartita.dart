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


class RichiestaNuovaPartita
{
  String data="";
  String? id_centro_sportivo="";
  String orario="";
  int numero_di_partecipanti=0;
  String metodo_di_pagamento="";
  String id_giocatore="";
  String id_amministratore="";
  late DatabaseReference id;
  late Sport sport;


  Map<String, dynamic> toJson({bool hide=false})
  {
    return {

      "data": data,
      "orario": orario,
      "numero_di_partecipanti":numero_di_partecipanti,
      "sport": sport.toString().split('.').last,
      "id_centrosportivo":id_centro_sportivo,
      "id_giocatore": id_giocatore,
      "id_richiesta_partita":id.key,
      "id_amministratore": id_amministratore
    };
  }

  @override
  String toString() {
    return 'RichiestaNuovaPartita{data: $data, id_centro_sportivo: $id_centro_sportivo, orario: $orario, numero_di_partecipanti: $numero_di_partecipanti, metodo_di_pagamento: $metodo_di_pagamento, id_giocatore: $id_giocatore, id_amministratore: $id_amministratore, id: ${id.key}, sport: $sport}';
  }
}


DatabaseReference saveRichiestaNuovaPartita(RichiestaNuovaPartita richiesta)
{
  var id = databaseReference.child("richiestenuovepartite/").push();
  richiesta.id=id;
  id.set(richiesta.toJson());
  return id;
}

Future<List<RichiestaNuovaPartita>> getRichiestePartite({AmministstratoreCentroSportivo? acs}) async
{
  DataSnapshot dataSnapshot = await databaseReference.child('richiestenuovepartite/').once();
  RichiestaNuovaPartita richiestanuovapartita;
  List<RichiestaNuovaPartita> richiestenuovepartite=[];
  bool found=false;
  print("sono nelle richieste");
  if(acs != null)
    {
      if(dataSnapshot.value != null)
      {
        dataSnapshot.value.forEach((key,value) =>{
          if(value["id_amministratore"] == acs.id.key)
            {
              richiestanuovapartita = new RichiestaNuovaPartita(),
              richiestanuovapartita.data=value["data"],
              richiestanuovapartita.id_centro_sportivo=value["id_centrosportivo"],
              richiestanuovapartita.id_amministratore=value["id_amministratore"],
              richiestanuovapartita.id_giocatore=value["id_giocatore"],
              richiestanuovapartita.numero_di_partecipanti=value["numero_di_partecipanti"],
              richiestanuovapartita.orario=value["orario"],
              richiestanuovapartita.sport= Sport.values.firstWhere((e) => e.toString() == 'Sport.' + value["sport"]),
              richiestanuovapartita.id = databaseReference.child('centrisportivi/'+key),
              richiestenuovepartite.add(richiestanuovapartita),
              print(richiestanuovapartita)
            }
        }
        );
      }
    }

  return richiestenuovepartite;
}

