import 'package:firebase_database/firebase_database.dart';
final databaseReference= FirebaseDatabase.instance.reference();

enum Sport{
  calcio,
  pallavolo,
  padel,
  tennis,
  pingpong,
}


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

  @override
  String toString() {
    return 'PartitaConfermata{data: $data, id_centro_sportivo: $id_centro_sportivo, orario: $orario, numero_di_partecipanti: $numero_di_partecipanti, metodo_di_pagamento: $metodo_di_pagamento, id_giocatore: $id_giocatore, id_amministratore: $id_amministratore, partecipanti: $partecipanti, id: ${id.key}, sport: $sport}';
  }
}