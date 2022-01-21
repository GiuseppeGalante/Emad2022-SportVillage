import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/PartitaConfermata.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/screens/visualizzaInfoRichiestaPartita.dart';

import 'home.dart';



// Create a Form widget.
class VisPartitaConfermata extends StatefulWidget {
  PartitaConfermata partitaconfermata;
  bool find=true;
  List<PartitaConfermata> partite=[];
  //CentroSportivo centroSportivo;
  VisPartitaConfermata({required this.partitaconfermata, Key? key}) : super(key: key);
  @override
  _VisPartitaConfermataState createState() => _VisPartitaConfermataState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _VisPartitaConfermataState extends State<VisPartitaConfermata> {
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



    PartitaConfermata partitaconfermata=widget.partitaconfermata;


    return Scaffold(
        appBar: AppBar(
          title: Text("Ricerca partita"),
        ),

        body: Column(
          children: <Widget>[

              Text(partitaconfermata.data),
              Text(partitaconfermata.orario),
            Text(partitaconfermata.sport.toString()),

            Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                  Column(
                    children:<Widget> [
                      //Text("Team 1"),
                      Expanded(
                          child:ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:partitaconfermata.partecipanti.length,
                              itemBuilder: (context,index){
                                return Text(partitaconfermata.partecipanti[index]);
                              }

                          )
                      ),

                    ],
                  ),

                //Text("Team 2"),
              ],
            )
          ],
        )
    );
  }
}





