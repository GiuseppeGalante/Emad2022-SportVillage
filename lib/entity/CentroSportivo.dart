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
  CentroSportivo centrosportivo = new CentroSportivo();
  List<CentroSportivo> centrisportivi=[];
  bool found=false;
  if(dataSnapshot.value != null)
  {
    dataSnapshot.value.forEach((key,value) =>{
      if(value["id_amministratore"] == amministratore.id.key)
        {
          centrosportivo.nome=value["nome"],
          centrosportivo.id_amministratore=value["id_amministraote"],
          centrosportivo.ragione_sociale=value["ragione_sociale"],
          centrosportivo.numero_di_campi=value["numero_di_campi"],
          centrosportivo.indirizzo=value["indirizzo"],
          centrosportivo.id = databaseReference.child('centrisportivi/'),
          centrisportivi.add(centrosportivo)
        }

    }
    );
  }
    return centrisportivi;
}