import 'package:firebase_database/firebase_database.dart';

final databaseReference= FirebaseDatabase.instance.reference();


enum Sport{
  calcio,
  pallavolo,
  padel,
  tennis,
  pingpong,
}


class RichiestaTorneo
{
  String? id_centro_sportivo="";
  int numero_di_partecipanti=0;
  String nome="";
  String modalita="";
  String id_giocatore="";
  late DatabaseReference id;
  late Sport sport;


  Map<String, dynamic> toJson({bool hide=false})
  {
    return {

      "nome": nome,
      "modalita": modalita,
      "numero_di_partecipantii":numero_di_partecipanti,
      "sport": sport.toString().split('.').last,
      "id_centrosportivo":id_centro_sportivo,
      "id_giocatore": id_giocatore,
      "id_richiesta_torneo":id.key,
    };
  }

}


DatabaseReference saveRichiestaTorneo(RichiestaTorneo richiesta)
{
  var id = databaseReference.child("richiestetornei/").push();
  richiesta.id=id;
  id.set(richiesta.toJson());
  return id;
}