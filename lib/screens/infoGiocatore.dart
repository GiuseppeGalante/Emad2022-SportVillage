import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/PartitaConfermata.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/screens/visualizzaInfoRichiestaPartita.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';
import 'package:flutter_app_emad/widgets/active_project_card.dart';


import 'dettaglioPartitaConfermata.dart';
import 'home.dart';



// Create a Form widget.
class VisInfoGiocatore extends StatefulWidget {
  Giocatore giocatore;
  bool find=true;
  List<PartitaConfermata> partite=[];
  //CentroSportivo centroSportivo;
  VisInfoGiocatore({required this.giocatore, Key? key}) : super(key: key);
  @override
  _VisInfoGiocatoreState createState() => _VisInfoGiocatoreState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _VisInfoGiocatoreState extends State<VisInfoGiocatore> {


  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();


  bool late=false;
  RichiestaNuovaPartita richiestaNuovaPartita = RichiestaNuovaPartita();



  late Map<String,String> mapping=new Map();

  @override
  Widget build(BuildContext context) {
    //this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.



    Giocatore giocatore=widget.giocatore;



    return Scaffold(
        appBar: AppBar(
          backgroundColor: LightColors.kDarkYellow,
          title: Text("Ricerca partita"),
        ),

        body: Card(
          color: Colors.white,
                child: ListTile(

                  leading:Icon(Icons.assignment_outlined, color: LightColors.kDarkBlue, size: 50.0,),

                  title: Text(giocatore.nome,
                    style: TextStyle(
                      fontSize: 40.0,
                      color: LightColors.kDarkBlue,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: Column(
                    children: [

                      Text('Cognome:'+giocatore.cognome,
                      style: TextStyle(
                        fontSize: 40.0,
                        color: LightColors.kDarkBlue,
                        fontWeight: FontWeight.w800,
                      ),
                      ),
                      Text('To String:'+giocatore.toString(),
                        style: TextStyle(
                          fontSize: 40.0,
                          color: LightColors.kDarkBlue,
                          fontWeight: FontWeight.w800,
                        ),),
                    ],
                  ),
                ),
              )


    );
  }
}





