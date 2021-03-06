import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/screens/visualizzaInfoRichiestaPartita.dart';

import 'home.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';



// Create a Form widget.
class VisualizzaRichiestePartita extends StatefulWidget {
  AmministstratoreCentroSportivo amministratore;
  //CentroSportivo centroSportivo;
  List<RichiestaNuovaPartita>richiestepartite=[];
  VisualizzaRichiestePartita({required this.amministratore, required this.richiestepartite, Key? key}) : super(key: key);
  @override
  _VisualizzaRichiestePartitaState createState() => _VisualizzaRichiestePartitaState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _VisualizzaRichiestePartitaState extends State<VisualizzaRichiestePartita> {

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



    AmministstratoreCentroSportivo amministratore=widget.amministratore;
    List<RichiestaNuovaPartita>richiestepartite=widget.richiestepartite;
    CentroSportivo centrosportivo;
    print(richiestepartite);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkBlue,
        title: Text("Richieste nuova partita"),
      ),

      body: ListView.builder(
          itemCount: richiestepartite.length,
          itemBuilder: (context,index){
        return Card(
          color: LightColors.kLightYellow,
          child: ListTile(
            leading:Icon(Icons.assignment_outlined, color: LightColors.kDarkBlue, size: 50.0,),
              onTap:() async =>

                  getCentroSportivo(richiestepartite[index].id_centro_sportivo).then((value) async =>
                  {
                    await Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            FormInfoRichiestaNuovaPartita(
                                richiestanuovapartita: richiestepartite[index],
                                centrosportivo: value,
                                amministratore: amministratore)

                    )),
                    setState((){getRichiestePartite(acs:amministratore).then((value) =>{ setState((){widget.richiestepartite=value;})});})
                  }
                  ),

            title: Text(richiestepartite[index].data,style: TextStyle(
              color: LightColors.kDarkBlue,
              fontWeight: FontWeight.w800,
            ),),
            subtitle: Column(
              children: [
                Text('Numero di partecipanti:'+richiestepartite[index].numero_di_partecipanti.toString(),style: TextStyle(
                  color: LightColors.kDarkBlue,
                  fontWeight: FontWeight.w800,
                ),),
                Text('Sport:'+richiestepartite[index].sport.toString().split(".").last,style: TextStyle(
                  color: LightColors.kDarkBlue,
                  fontWeight: FontWeight.w800,
                ),),
              ],
            ),
          ),
        );
      }
      )
    );
  }
}





