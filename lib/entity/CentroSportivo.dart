import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Campo.dart';


final databaseReference= FirebaseDatabase.instance.reference();

class CentroSportivo{
  late DatabaseReference id;
  int numero_di_campi=0;
  String nome="";
  String ragione_sociale="";
  String indirizzo="";
  String id_amministratore="";
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
  DataSnapshot dataSnapshot = await databaseReference.child('centrisportivi/').once();
  CentroSportivo centrosportivo;
  List<CentroSportivo> centrisportivi=[];
  bool found=false;
  if(dataSnapshot.value != null)
  {
    dataSnapshot.value.forEach((key,value) =>{
      if(value["id_amministratore"] == amministratore.id.key)
        {
          centrosportivo = new CentroSportivo(),
          centrosportivo.nome=value["nome"],
          centrosportivo.id_amministratore=amministratore.id.key,
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
      DataSnapshot dataSnapshot = await databaseReference.child('centrisportivi/'+key).once();
      centrosportivo.id = databaseReference.child("centrisportivi/"+key);
      centrosportivo.nome = dataSnapshot.value["nome"];
      centrosportivo.numero_di_campi= dataSnapshot.value["numero_di_campi"];
      centrosportivo.ragione_sociale= dataSnapshot.value["ragione_sociale"];
      centrosportivo.id_amministratore= dataSnapshot.value["id_amministratore"];
      centrosportivo.indirizzo=dataSnapshot.value["indirizzo"];
    }
  return centrosportivo;
}