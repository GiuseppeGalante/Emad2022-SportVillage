import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Utente.dart';


final databaseReference= FirebaseDatabase.instance.reference();


class AmministstratoreCentroSportivo extends Utente
{

  List<CentroSportivo> centrisportivi=[];
  AmministstratoreCentroSportivo()
  {
    centrisportivi=[];
  }

  Map<String, dynamic>toJson()
  {
    return {
      'nome':this.nome,
      'cognome':this.cognome,
      'email':this.email,
      'nome_utente':this.nome_utente,
      'password':this.password,
      'indirizzo':this.indirizzo,
      'numero_di_telefono':this.numero_di_telefono,
      'nascita':this.data_di_nascita,
      'bio':this.bio,
      'sesso':this.sesso.toString().split('.').last,
      'centri_sportivi': [] //List<dynamic>.from(this.centrisportivi.map((x) => x.toJson()))
    };
  }

  @override
  String toString() {
    return 'AmministstratoreCentroSportivo{centrisportivi: $centrisportivi}';
  }
}


DatabaseReference saveAmministratoreCS(AmministstratoreCentroSportivo amministratore)
{
  var id = databaseReference.child("users/amministratorics/").push();
  amministratore.id=id;
  id.set(amministratore.toJson());
  return id;
}

