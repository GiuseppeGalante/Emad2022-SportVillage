import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/entity/Squadre.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/DettaglioTorneiAccettati.dart';
import 'package:flutter_app_emad/screens/DettaglioTorneo.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/screens/registrazioneAmministratoreCS.dart';
import 'package:flutter_app_emad/screens/registrazioneGiocatore.dart';

import 'home.dart';



// Create a Form widget.
class SceltaRegistrazioneForm extends StatefulWidget {

  //CentroSportivo centroSportivo;

  SceltaRegistrazioneForm({ Key? key}) : super(key: key);
  @override
  _SceltaRegistrazioneFormState createState() => _SceltaRegistrazioneFormState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _SceltaRegistrazioneFormState extends State<SceltaRegistrazioneForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();


  bool late=false;



  late Map<String,String> mapping=new Map();

  @override
  Widget build(BuildContext context) {
    //this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.



    return Scaffold(
        appBar: AppBar(
          title: Text("Torneo Attivi"),
        ),

        body: Column(
            children: [

          Card(
              child: ListTile(
              leading:Icon(Icons.request_page, color: Colors.black, size: 50.0,),
              title: Text("REGISTRAZIONE GIOCATORE"),
              //subtitle:  Text("Sport: "+tornei[index].sport.sport.toString().split(".").last),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return MyCustomFormGiocatore();
                    }
                ));
              }

              ),
              ),
              Card(
                child: ListTile(
                    leading:Icon(Icons.request_page, color: Colors.black, size: 50.0,),
                    title: Text("REGISTRAZIONE AMMINISTRATORE CENTRO SPORTIVO"),
                    //subtitle:  Text("Sport: "+tornei[index].sport.sport.toString().split(".").last),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MyCustomFormAmministratoreCS();
                          }
                      ));
                    }

                ),
              ),

            ],
        )
    );
  }

}