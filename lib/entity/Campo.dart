import 'package:firebase_database/firebase_database.dart';
final databaseReference= FirebaseDatabase.instance.reference();

class Campo
{
  late DatabaseReference id;
  String nome="";
  String tipo="";
  String? id_centro_sportivo="";


  Map<String, dynamic> toJson()
  {
    return {

      "nome": nome,
      "tipo": tipo,
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
  DataSnapshot dataSnapshot = await databaseReference.child('centrisportivi/').once();
  Campo campo;
  List<Campo> campi=[];
  bool found=false;
  if(dataSnapshot.value != null)
  {
    dataSnapshot.value.forEach((key,value) =>{
      if(id == value["id_centrosportivo"])
        {
          campo = new Campo(),
          campo.nome=value["nome"],
          campo.id_centro_sportivo=value["id_centrosportivo"],
          campo.tipo= value["tipo"],
          campo.id = databaseReference.child('campi/'+key),
          campi.add(campo)
        }
    }
    );
  }
  return campi;
}



