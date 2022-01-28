import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Campo.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Sport.dart';


final databaseReference= FirebaseDatabase.instance.reference();

class CentroSportivo{
  late DatabaseReference id;
  int numero_di_campi=0;
  String? nome="";
  String? ragione_sociale="";
  String? indirizzo="";
  String? id_amministratore="";
  List<Campo> campi=[];




  @override
  String toString() {
    return 'CentroSportivo{id: ${id.key}, numero_di_campi: $numero_di_campi, nome: $nome, ragione_sociale: $ragione_sociale, indirizzo: $indirizzo, id_amministratore: $id_amministratore, campi: $campi}';
  }

  Map<String, dynamic> toJson({bool hide=false})
  {
    return {

      "numero_di_campi": numero_di_campi,
      "nome": nome,
      "ragione_sociale": ragione_sociale,
      "indirizzo": indirizzo,
      "id_centrosportivo":id.key,
      "id_amministratore": id_amministratore,
      "campi": List<dynamic>.from(this.campi.map((x) => x.toJson()))
    };
  }

}


DatabaseReference saveCentroSportivo(CentroSportivo centrosportivo)
{
  var id =databaseReference.child("centrisportivi/").push();
  centrosportivo.id=id;
  id.set(centrosportivo.toJson());
  return id;
}


void updateCentroSportivo(CentroSportivo centrosportivo)
{
  centrosportivo.id.update(centrosportivo.toJson());
}

Future<List<CentroSportivo>> getCentroSportivoAmm(AmministstratoreCentroSportivo amministratore) async
{
  DatabaseEvent dataSnapshot = (await databaseReference.child('centrisportivi/').once()) as DatabaseEvent;
  CentroSportivo centrosportivo;
  List<CentroSportivo> centrisportivi=[];
  bool found=false;
  if(dataSnapshot.snapshot.value != null)
  {
    Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
    values.forEach((key,value) =>{
      if(value["id_amministratore"] == amministratore.id.key)
        {
          centrosportivo = new CentroSportivo(),
          centrosportivo.nome=value["nome"],
          centrosportivo.id_amministratore=amministratore.id.key!,
          centrosportivo.ragione_sociale=value["ragione_sociale"],
          centrosportivo.numero_di_campi=value["numero_di_campi"],
          centrosportivo.indirizzo=value["indirizzo"],
          centrosportivo.id = databaseReference.child('centrisportivi/'+key),
          centrisportivi.add(centrosportivo)
        }

    }
    );
  }
    return centrisportivi;
}

Future<CentroSportivo> getCentroSportivo(String? key) async
{
  CentroSportivo centrosportivo=CentroSportivo();
  if(key != null)
    {
      DatabaseEvent dataSnapshot = (await databaseReference.child('centrisportivi/'+key).once()) as DatabaseEvent;
      Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
      centrosportivo.id = databaseReference.child("centrisportivi/"+key);
      centrosportivo.nome = values["nome"];
      centrosportivo.numero_di_campi= values["numero_di_campi"];
      centrosportivo.ragione_sociale= values["ragione_sociale"];
      centrosportivo.id_amministratore= values["id_amministratore"];
      centrosportivo.indirizzo=values["indirizzo"];
      String dajson= jsonEncode(values["campi"]);
      List<dynamic> tomap=jsonDecode(dajson);
      if(tomap != null)
        {
          tomap.forEach((element) {
            Map<String, dynamic> prova= element;
            Campo campo=new Campo();
            campo.tipo= new SportClass(Sport.values.firstWhere((e) => e.toString() == 'Sport.' + prova["tipo"]));
            campo.id_centro_sportivo=prova["id_centrosportivo"];
            campo.id = databaseReference.child("campi/"+prova["id_campo"]);
            campo.nome = prova["nome"];
            centrosportivo.campi.add(campo);
          });
        }

    }
  return centrosportivo;
}

Future<List<CentroSportivo>> getCentriSportivi() async
{
  DatabaseEvent dataSnapshot = (await databaseReference.child('centrisportivi/').once()) as DatabaseEvent;
 late CentroSportivo centrosportivo;
  List<CentroSportivo> centrisportivi=[];
  bool found=false;
  if(dataSnapshot.snapshot.value != null)
  {
    Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
    values.forEach((key,value) =>{
            centrosportivo=new CentroSportivo(),
          centrosportivo.nome=value["nome"],
          centrosportivo.id_amministratore=value["id_amministratore"],
          centrosportivo.ragione_sociale=value["ragione_sociale"],
          centrosportivo.numero_di_campi=value["numero_di_campi"],
          centrosportivo.indirizzo=value["indirizzo"],
          centrosportivo.id = databaseReference.child('centrisportivi/'+key),
      centrisportivi.add(centrosportivo)


    },


    );
    for(int i=0;i<centrisportivi.length;i++)
      {
        await getCampi(centrisportivi[i].id.key!).then((value) =>
        {
          for(int k=0;k<centrisportivi.length;k++)
            {
              if(centrisportivi[k].id==centrisportivi[i].id)
                {

                  centrisportivi[k].campi=value
                }
            }
        }

        );
      }

  }
  return centrisportivi;
}
