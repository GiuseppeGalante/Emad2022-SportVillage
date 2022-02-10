import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/DettaglioTorneo.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';

import 'home.dart';



// Create a Form widget.
class VisualizzaRichiesteTorneo extends StatefulWidget {
  AmministstratoreCentroSportivo amministratore;
  //CentroSportivo centroSportivo;
  List<RichiestaTorneo>richiestetornei=[];

  VisualizzaRichiesteTorneo({required this.amministratore, required this.richiestetornei, Key? key}) : super(key: key);
  @override
  _VisualizzaRichiesteTorneoState createState() => _VisualizzaRichiesteTorneoState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _VisualizzaRichiesteTorneoState extends State<VisualizzaRichiesteTorneo> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();


  bool late=false;
  RichiestaTorneo richiestaTorneo = RichiestaTorneo();



  late Map<String,String> mapping=new Map();

  @override
  Widget build(BuildContext context) {
    //this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.



    AmministstratoreCentroSportivo amministratore=widget.amministratore;
    List<RichiestaTorneo>richiestetornei=widget.richiestetornei;
    print(richiestetornei);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: LightColors.kDarkBlue,
          title: Text("Richieste Torneo"),
        ),

        body: ListView.builder(
            itemCount: richiestetornei.length,
            itemBuilder: (context,index){
              return Card(
                color: LightColors.kLightYellow,
                child: ListTile(
                  leading:Icon(Icons.request_page, color: LightColors.kDarkBlue, size: 50.0,),
                  title: Text("Nome Torneo: "+richiestetornei[index].nome,style: TextStyle(
                    color: LightColors.kDarkBlue,
                    fontWeight: FontWeight.w800,
                  ),),
                  subtitle:  Text("Sport: "+richiestetornei[index].sport.sport.toString().split(".").last,style: TextStyle(
                    color: LightColors.kDarkBlue,
                    fontWeight: FontWeight.w800,
                  ),),
                  onTap: () async {
                    await Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return DettaglioTorneo(torneo: richiestetornei[index],amministratore:amministratore);
                        }
                    ));
                    setState((){getRichiesteTornei(acs:amministratore).then((value) =>{ setState((){widget.richiestetornei=value;})});});
                  },
                ),
              );
            }
        )
    );
  }

}