import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';

import 'home.dart';



// Create a Form widget.
class InfoCentriSportivi extends StatefulWidget {

  //CentroSportivo centroSportivo;
  List<CentroSportivo>centrosportivo=[];
  InfoCentriSportivi({ required this.centrosportivo, Key? key}) : super(key: key);
  @override
  _InfoCentriSportiviState createState() => _InfoCentriSportiviState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _InfoCentriSportiviState extends State<InfoCentriSportivi> {
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



    List<CentroSportivo>centrosportivo = widget.centrosportivo;
    CentroSportivo centroSportivo;
    centroSportivo= getCentroSportivo(centrosportivo.removeLast().toString()) as CentroSportivo;

    return Scaffold(
      appBar: AppBar(
        title: Text("Info Centri Sportivi"),
      ),
      body:
          Row(

          children: <Widget>[
          Text("Nome centro Sportivo: "+ centroSportivo.nome.toString() + "/"+ "Numero di Campi Centro Sportivo:"+centroSportivo.campi.toString()+ "/"+ "Indirizzo:"+centroSportivo.indirizzo.toString() ),
    SizedBox(height: 20.0,),
            ]
          )

    );



  }

}

