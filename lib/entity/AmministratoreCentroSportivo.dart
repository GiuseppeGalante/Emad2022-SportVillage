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
      'numero_di_telefono':this.numero_di_telefono,
      'nascita':this.data_di_nascita,
      'bio':this.bio,
      'sesso':this.sesso.toString().split('.').last,
      'centri_sportivi': List<dynamic>.from(this.centrisportivi.map((x) => x.toJson()))
    };
  }

  @override
  String toString() {
    return 'AmministstratoreCentroSportivo{centrisportivi: $centrisportivi}' + super.toString();
  }
}


DatabaseReference saveAmministratoreCS(AmministstratoreCentroSportivo amministratore)
{
  var id = databaseReference.child("users/amministratorics/").push();
  amministratore.id=id;
  id.set(amministratore.toJson());
  return id;
}

void updateAmministratoreCS(AmministstratoreCentroSportivo amministratore)
{
  print(amministratore.id.key);
  amministratore.id.update(amministratore.toJson());
}


Future<AmministstratoreCentroSportivo?> getAmministratoreCS(AmministstratoreCentroSportivo amm) async{
  DatabaseEvent dataSnapshot = (await databaseReference.child('users/amministratorics/').once()) as DatabaseEvent;
  AmministstratoreCentroSportivo amministratore = new AmministstratoreCentroSportivo();
  bool found=false;
  if(dataSnapshot.snapshot.value != null)
  {
    Map<dynamic, dynamic> values=dataSnapshot.snapshot.value as Map;
    values.forEach((key,value) =>{
      if((value["nome_utente"] == amm.nome_utente) && (value["password"] == amm.password))
        {

          found=true,
          amministratore.nome=value["nome"],
          amministratore.cognome=value["cognome"],
          amministratore.email=value["email"],
          amministratore.nome_utente=value["nome_utente"],
          amministratore.password=value["password"],
          amministratore.numero_di_telefono=value["numero_di_telefono"],
          amministratore.data_di_nascita=value["nascita"],
          amministratore.bio=value["bio"],
          amministratore.sesso=Sesso.values.firstWhere((e) => e.toString() == 'Sesso.' + value["sesso"]),
          amministratore.id = databaseReference.child('users/amministratorics/'+key),
          getCentroSportivoAmm(amministratore).then((centrisportivi)=>
          {
            amministratore.centrisportivi=centrisportivi
          })
        }

    }
    );
  }
  if(found)
    return amministratore;
  return null;
}



