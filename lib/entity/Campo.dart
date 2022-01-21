import 'package:firebase_database/firebase_database.dart';

import 'RichiestaNuovaPartita.dart';
final databaseReference= FirebaseDatabase.instance.reference();

class Campo
{
  late DatabaseReference id;
  String nome="";
  late Sport tipo;
  String? id_centro_sportivo="";


  Map<String, dynamic> toJson()
  {
    return {

      "nome": nome,
      "tipo": tipo.toString().split('.').last,
        "id_campo":id.key,
        "id_centrosportivo": id_centro_sportivo
    };
  }

  @override
  String toString() {
    return 'Campo{id: ${id.key}, nome: $nome, tipo: $tipo, id_centro_sportivo: $id_centro_sportivo}';
  }
}


DatabaseReference saveCampoSportivo(Campo campo)
{
  var id =databaseReference.child("campi/").push();
  campo.id=id;
  id.set(campo.toJson());
  return id;
}

Future<List<Campo>> getCampi(String id) async
{
  DatabaseEvent dataSnapshot = (await databaseReference.child('campi/').once()) as DatabaseEvent;
  Campo campo;
  List<Campo> campi=[];
  bool found=false;
  if(dataSnapshot.snapshot.value != null)
  {
    Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
    values.forEach((key,value) =>{
      print("eccomi:"+id+":"+value["id_centrosportivo"]),
      if(id == value["id_centrosportivo"])
        {

          campo = new Campo(),
          campo.nome=value["nome"],
          campo.id_centro_sportivo=value["id_centrosportivo"],
          campo.tipo= Sport.values.firstWhere((e) => e.toString() == 'Sport.' + value["tipo"]),
          campo.id = databaseReference.child('campi/'+key),
          print(campo),
          campi.add(campo)
        }
    }
    );
  }
  return campi;
}



