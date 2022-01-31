import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/Sport.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';

final databaseReference= FirebaseDatabase.instance.reference();
class Squadra
{
  late DatabaseReference id;
  String nome="";
  int partecipanti=0;
  int max_partecipanti=0;
  String id_torneo="";
  String id_squadra="";


  Map<String, dynamic> toJson({bool hide=false})
  {
    return {

      "nome": nome,
      "partecipanti":partecipanti,
      "max_partecipanti":max_partecipanti,
      "id_squadra":id.key,
      "id_torneo":id_torneo,
    };
  }

  void creaSquadre(int p,SportClass sp,String id)
  {
    Squadra s=Squadra();
    String sport=sp.toString().split('.').last;
    for(int i=0;i<p;i++)
    {
      if(i<9)
        s.nome="Squadra 0"+(i+1).toString();
      else
        s.nome="Squadra "+(i+1).toString();
      s.partecipanti=0;
      s.id_torneo=id;
      s.max_partecipanti=sp.partecipanti[0] as int;
      /*switch(sport)
      {
        case "calcio":
          s.max_partecipanti=11;
          break;
        case "tennis":
          s.max_partecipanti=2;
          break;
      }*/
      saveSquadre(s);
    }
  }

  Future<void> aggiungiComponente(String id_squadra,int partecipanti)
  {
    var id=databaseReference.child("squadre/").child(id_squadra).child('partecipanti').set(ServerValue.increment(1));
    return id;
  }


}



DatabaseReference saveSquadre(squadra)
{
  var id = databaseReference.child("squadre/").push();
  squadra.id=id;
  id.set(squadra.toJson());
  return id;
}

Future<List<Squadra>> getSquadre(String torneo) async
{
  DatabaseEvent dataSnapshot = (await databaseReference.child('squadre/').orderByChild('id_torneo').equalTo(torneo).once()) as DatabaseEvent ;
  Squadra squadra;
  List<Squadra> squadre=[];
  bool found=false;
  print("sono nelle richieste");
  if(dataSnapshot.snapshot.value != null)
  {
    Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
    values.forEach((key,value) =>{
      print(value),
      squadra = new Squadra(),
      squadra.id_squadra=value["id_squadra"],
      squadra.nome=value["nome"],
      squadra.partecipanti=value["partecipanti"],
      squadra.max_partecipanti=value["max_partecipanti"],
      squadre.add(squadra),
      //print("Squadre "+squadre[0].nome),
    }
    );
  }
  squadre.sort((a, b) => a.nome.compareTo(b.nome));

  return squadre;
}

