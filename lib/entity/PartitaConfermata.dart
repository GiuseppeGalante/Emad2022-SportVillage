import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';


import 'Campo.dart';
import 'RichiestaNuovaPartita.dart';
final databaseReference= FirebaseDatabase.instance.reference();



class PartitaConfermata{

  String data="";
  String? id_centro_sportivo="";
  String orario="";
  int numero_di_partecipanti=0;
  String metodo_di_pagamento="";
  String id_giocatore="";
  String id_amministratore="";
  List<String> partecipanti=[];
  late DatabaseReference id;
  late Sport sport;
  late String id_campo;

  @override
  String toString() {
    return 'PartitaConfermata{data: $data, id_centro_sportivo: $id_centro_sportivo, orario: $orario, numero_di_partecipanti: $numero_di_partecipanti, metodo_di_pagamento: $metodo_di_pagamento, id_giocatore: $id_giocatore, id_amministratore: $id_amministratore, partecipanti: $partecipanti, id: ${id.key}, sport: $sport}';
  }

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
      "id_amministratore": id_amministratore,
        "partecipanti": List<dynamic>.from(this.partecipanti.map((x) => x)),
      "metodo_di_pagamento": metodo_di_pagamento,
      "campo": id_campo
    };
  }


}

DatabaseReference saveNuovaPartitaConfermata(PartitaConfermata richiesta)
{
  var id = databaseReference.child("partiteconfermate/").push();
  richiesta.id=id;
  id.set(richiesta.toJson());
  return id;
}


Future<List<PartitaConfermata>?> getPartiteConfermate({String idgioca=""}) async{
  DataSnapshot dataSnapshot = await databaseReference.child('partiteconfermate/').once();
  List<PartitaConfermata> partiteConfermate = [];
  List<PartitaConfermata> allpartiteconfermate=[];
  PartitaConfermata pc;
  bool found=false;
  if(dataSnapshot.value != null)
  {

        String dajson;
        List<dynamic> tomap;
        dataSnapshot.value.forEach((key,value) =>{
          pc= new PartitaConfermata(),
          pc.id_campo=value["id_campo"],
          pc.data=value["data"],
          pc.id=databaseReference.child('partiteconfermate/'+key),
          pc.sport= Sport.values.firstWhere((e) => e.toString() == 'Sport.' + value["sport"]),
          pc.metodo_di_pagamento = value["metodo_di_pagamento"],
          pc.id_giocatore=value["id_giocatore"],
          pc.id_amministratore=value["id_amministratore"],
          pc.id_centro_sportivo=value["id_centrosportivo"],
          pc.orario=value["orario"],
          pc.numero_di_partecipanti=value["numero_di_partecipanti"],
          dajson= jsonEncode(value["partecipanti"]),
          tomap=jsonDecode(dajson),
          print(value["partecipanti"]),
          tomap.forEach((element) {
          String prova= element;
            pc.partecipanti.add(prova);
          }),
          if(value["id_giocatore"] == idgioca)
            {
              found=true,
              print("Partita confermata da classe:"+pc.toString()),
              partiteConfermate.add(pc),
            },
          allpartiteconfermate.add(pc),
      }

    );

  }
  if(idgioca!= "")
    {
      if(found)
        return partiteConfermate;
      else
        return null;
    }

  return allpartiteconfermate;
}