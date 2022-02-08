import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Sport.dart';

final databaseReference= FirebaseDatabase.instance.reference();




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
  late SportClass sport;
  String campo="";


  Map<String, dynamic> toJson({bool hide=false})
  {
    return {

      "data": data,
      "orario": orario,
      "numero_di_partecipanti":numero_di_partecipanti,
      "sport": sport.sport.toString().split('.').last,
      "id_centrosportivo":id_centro_sportivo,
      "id_giocatore": id_giocatore,
      "id_richiesta_partita":id.key,
      "id_amministratore": id_amministratore,
      "campo":campo,
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
  DatabaseEvent dataSnapshot = (await databaseReference.child('richiestenuovepartite/').once()) as DatabaseEvent;
  RichiestaNuovaPartita richiestanuovapartita;
  List<RichiestaNuovaPartita> richiestenuovepartite=[];
  bool found=false;
  print("sono nelle richieste");
  if(acs != null)
    {
      if(dataSnapshot.snapshot.value != null)
      {
        Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
        values.forEach((key,value) =>{
          if(value["id_amministratore"] == acs.id.key)
            {
              richiestanuovapartita = RichiestaNuovaPartita(),
              richiestanuovapartita.data=value["data"],
              richiestanuovapartita.id_centro_sportivo=value["id_centrosportivo"],
              richiestanuovapartita.id_amministratore=value["id_amministratore"],
              richiestanuovapartita.id_giocatore=value["id_giocatore"],
              richiestanuovapartita.numero_di_partecipanti=value["numero_di_partecipanti"],
              richiestanuovapartita.orario=value["orario"],
              richiestanuovapartita.sport= new SportClass(Sport.values.firstWhere((e) => e.toString() == 'Sport.' + value["sport"])),
              richiestanuovapartita.id = databaseReference.child('centrisportivi/'+key),
              richiestanuovapartita.campo=value["campo"],
              richiestenuovepartite.add(richiestanuovapartita),
              print(richiestanuovapartita)
            }
        }
        );
      }
    }

  return richiestenuovepartite;
}


Future<void> deleteRichiestaPartita(String id_richiesta)
{
  var id = databaseReference.child("richiestenuovepartite/").child(id_richiesta).remove();
  //print(id_torneo);
  return id;
}

