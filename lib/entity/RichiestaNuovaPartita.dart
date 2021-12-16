import 'package:firebase_database/firebase_database.dart';

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
  late DatabaseReference id;
  late Sport sport;


  Map<String, dynamic> toJson({bool hide=false})
  {
    return {

      "data": data,
      "orario": orario,
      "numero_di_partecipantii":numero_di_partecipanti,
      "sport": sport.toString().split('.').last,
      "id_centrosportivo":id_centro_sportivo,
      "id_giocatore": id_giocatore,
      "id_richiesta_partita":id.key,
    };
  }

}


DatabaseReference saveRichiestaNuovaPartita(RichiestaNuovaPartita richiesta)
{
  var id = databaseReference.child("richiestenuovepartite/").push();
  richiesta.id=id;
  id.set(richiesta.toJson());
  return id;
}