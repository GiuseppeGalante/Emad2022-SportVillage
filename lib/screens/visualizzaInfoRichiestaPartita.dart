import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Campo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';

import 'home.dart';



// Create a Form widget.
class FormInfoRichiestaNuovaPartita extends StatefulWidget {
  RichiestaNuovaPartita richiestanuovapartita;
  //CentroSportivo centroSportivo;
  CentroSportivo centrosportivo;
  FormInfoRichiestaNuovaPartita({required this.richiestanuovapartita, required this.centrosportivo, Key? key}) : super(key: key);
  @override
  _FormInfoRichiestaNuovaPartitaState createState() => _FormInfoRichiestaNuovaPartitaState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _FormInfoRichiestaNuovaPartitaState extends State<FormInfoRichiestaNuovaPartita> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();


  bool late=false;
  late String _idCentro=widget.centrosportivo.campi[0].nome;
  String idAdmin="";
  RichiestaNuovaPartita richiestaNuovaPartita = RichiestaNuovaPartita();


  late Map<String,Campo> mapping=new Map();

  @override
  Widget build(BuildContext context) {
    //this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.



    RichiestaNuovaPartita richiestanuovapartita=widget.richiestanuovapartita;
    CentroSportivo centrosportivo=widget.centrosportivo;
    print(centrosportivo);
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrazione"),
      ),

      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[
                Wrap(
                  spacing: 20, // to apply margin in the main axis of the wrap
                  runSpacing: 20, // to apply margin in the cross axis of the wrap
                  children: <Widget>[
                    Row(

                      children: <Widget>[

                        Text("Data: "),
                        Text(richiestanuovapartita.data)

                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Ora: "),
                        Text(richiestanuovapartita.orario)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Numero di partecipanti: "),
                        Text(richiestanuovapartita.numero_di_partecipanti.toString())
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("campo"),
                        Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/1.5,
                          child: DropdownButton<String>(
                            hint: Text('Seleziona un campo'),
                            value: _idCentro ,
                            onChanged: (value){
                              setState(() {
                                _idCentro=value!;
                              });
                            },
                            items: centrosportivo.campi.map((e) {
                              mapping[e.nome]=e;
                              print(e);
                              return DropdownMenuItem<String>(
                                child: new Text(e.nome),
                                value: e.nome,

                              );

                            }
                            ).toList(),
                          ),
                        )
                      ],
                    )

                  ],
                )
                ,
                ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        print("Nessun errore");
                        _formKey.currentState?.save();
                        //centrosportivo.id_amministratore=amministratore.id.key;
                        //richiestaNuovaPartita.id_giocatore=giocatore.id.key;
                        //richiestaNuovaPartita.id_centro_sportivo=mapping[_idCentro]!.id.key;
                        // richiestaNuovaPartita.id_amministratore=mapping[_idCentro]!.id_amministratore;
                        saveRichiestaNuovaPartita(richiestaNuovaPartita);
                        //amministratore.centrisportivi.add(centrosportivo);
                        //updateAmministratoreCS(amministratore);
                        //print("${this.amministratore}");
                        //print(centrosportivo);
                        /*Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return MyHomeGio(giocatore:giocatore);
                            }
                        ));*/

                      }

                    }
                    , child: Text("Registra partita")
                )
              ],
            ),
          )
      ),
    );
  }

}

