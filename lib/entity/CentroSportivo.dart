import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/Campo.dart';


final databaseReference= FirebaseDatabase.instance.reference();

class CentroSportivo{
  late DatabaseReference id;
  int numero_di_campi=0;
  String nome="";
  String ragione_sociale="";
  List<Campo> campi=[];



  @override
  String toString() {
    return 'CentroSportivo{id: ${id.toString()}, numero_di_campi: $numero_di_campi, nome: $nome, ragione_sociale: $ragione_sociale, campi: $campi}';
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "numero_di_campi":numero_di_campi,
    "nome":nome,
    "ragione_sociale":ragione_sociale
  };

}


DatabaseReference saveCentroSportivo(CentroSportivo centrosportivo)
{
  var id =databaseReference.child("centrosportivo/").push();
  centrosportivo.id=id;
  id.set(centrosportivo.toJson());
  return id;
}