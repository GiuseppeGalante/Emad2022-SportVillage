import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_emad/entity/Squadre.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';

final databaseReference= FirebaseDatabase.instance.reference();
class PartitaTorneo
{
  late DatabaseReference id;
  String id_squadra1="";
  String id_squadra2="";
  String squadra1="";
  String squadra2="";
  String id_torneo="";
  String data="";
  String ora="";
  String campo="";


  Map<String, dynamic> toJson({bool hide=false})
  {
    return {
      "squadra1":squadra1,
      "squadra2":squadra2,
      "id_squadra1":id_squadra1,
      "id_squadra2":id_squadra2,
      "id_torneo": id_torneo,
      "data":data,
      "ora":ora,
      "campo":campo,
      "id":id.key,
    };
  }



}



DatabaseReference savePartita(partita)
{

  var id = databaseReference.child("partitetorneo/").push();
  partita.id = id;
  id.set(partita.toJson());
  return id;
}

Future<List<PartitaTorneo>> getPartiteTorneo(String torneo) async
{
  DatabaseEvent dataSnapshot = (await databaseReference.child('partitetorneo/').orderByChild('id_torneo').equalTo(torneo).once()) as DatabaseEvent ;
  PartitaTorneo partita;
  List<PartitaTorneo> partite=[];
  bool found=false;
  print("sono nelle richieste");
  if(dataSnapshot.snapshot.value != null)
  {
    Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
    values.forEach((key,values) async =>{
      print(values),
      partita = new PartitaTorneo(),
      partita.squadra1=values["squadra1"],
      partita.squadra2=values["squadra2"],
      partita.id_squadra1=values["id_squadra1"],
      partita.id_squadra2=values["id_squadra2"],
      partita.id_torneo=values["id_torneo"],
      partita.data=values["data"],
      partita.ora=values["ora"],
      partita.campo=values["campo"],
      partite.add(partita),
    }
    );
  }
  /*print(partite[0].squadra1);
  print(partite[0].squadra2);
  print(partite[0].campo);
  print(partite[0].data);
  print(partite[0].ora);*/
  return partite;
}