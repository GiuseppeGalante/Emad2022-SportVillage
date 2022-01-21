import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';

import 'home.dart';



// Create a Form widget.
class InfoCentroSportivo extends StatefulWidget {

  final CentroSportivo centroSportivo;

  InfoCentroSportivo({ required this.centroSportivo, Key? key}) : super(key: key);
  @override
  _InfoCentroSportivoState createState() => _InfoCentroSportivoState(centroSportivo);

}

// Create a corresponding State class.
// This class holds data related to the form.
class _InfoCentroSportivoState extends State<InfoCentroSportivo> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();
  final CentroSportivo centroSportivo;


  bool late=false;




  late Map<String,String> mapping=new Map();

  _InfoCentroSportivoState(this.centroSportivo);

  @override
  Widget build(BuildContext context) {
    int nc = centroSportivo.numero_di_campi;
    int i=0;

    return Scaffold(
        appBar: AppBar(
          title: Text("Info Centro Sportivo"+ centroSportivo.nome.toString()),
        ),
        body:
        Row(

            children: <Widget>[
              Text("Nome centro Sportivo: "+ centroSportivo.nome.toString() + "/"+ "Indirizzo:"+centroSportivo.indirizzo.toString()+"/"+
                  "Ragione Sociale:"+centroSportivo.ragione_sociale!+"/"+
                  "Numero di Campi:"+ centroSportivo.numero_di_campi.toString()+"/"+
                  "Campi:"+ centroSportivo.campi.toString()+"/"),
              SizedBox(height: 20.0,),
            ]
        )

    );



  }

}

