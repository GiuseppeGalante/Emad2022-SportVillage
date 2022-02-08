import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/Sport.dart';

import 'RichiestaNuovaPartita.dart';
final databaseReference= FirebaseDatabase.instance.reference();

class Prenotazione
{
  late DatabaseReference id;
  String data="";
  String ora="";
  String id_campo="";


  Map<String, dynamic> toJson()
  {
    return {

      "data": data,
      "orario": ora,
      "campo":id_campo,
    };
  }

  @override
  String toString() {
    return 'Prenotazione{id: ${id.key}, data: $data, ora: $ora, id_campo: $id_campo}';
  }
}

Future<bool> getPrenotazioni(String id,DateTime data,TimeOfDay ora) async
{
  DatabaseEvent dataSnapshot = (await databaseReference.child('partitetorneo/').orderByChild("campo").equalTo(id).once()) as DatabaseEvent;
  DatabaseEvent dataSnapshot1 = (await databaseReference.child('partiteconfermate/').orderByChild("campo").equalTo(id).once()) as DatabaseEvent;
  TimeOfDay time;
  DateTime d;
  List<String>ora_divisa=[];
  List<String>data_divisa=[];
  bool found=false;
  if(dataSnapshot.snapshot.value != null)
  {
    Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
    values.forEach((key,value) =>{
      data_divisa=value["data"].split("/"),
      d=new DateTime(int.parse(data_divisa[2]),int.parse(data_divisa[1]),int.parse(data_divisa[0])),
      if(data == d)
        {
          ora_divisa=value["ora"].split(":"),
          time=new TimeOfDay(hour:int.parse(ora_divisa[0]),minute:int.parse(ora_divisa[1])),
          print("Time"),
          print(time),
          if(ora==time)
            {
              found=true
            }
        }
    }
    );
  }
  print(found);
  if(dataSnapshot1.snapshot.value != null)
  {
    Map<dynamic, dynamic> valuesp=dataSnapshot1.snapshot.value as Map;
    valuesp.forEach((key,value) =>{
      data_divisa=value["data"].split("/"),
      d=new DateTime(int.parse(data_divisa[2]),int.parse(data_divisa[1]),int.parse(data_divisa[0])),

      if(data == d)
        {
          ora_divisa=value["orario"].split(":"),
          time=new TimeOfDay(hour:int.parse(ora_divisa[0]),minute:int.parse(ora_divisa[1])),
          print("Time"),
          print(time),
          if(ora==time)
            {
              found=true
            }
        }
    }
    );
  }
  print(found);
  return found;
}



