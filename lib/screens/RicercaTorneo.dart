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

import 'home.dart';



// Create a Form widget.
class VisualizzaTorneo extends StatefulWidget {
  Giocatore giocatore;
  //CentroSportivo centroSportivo;
  List<TorneoAccettato>tornei=[];

  VisualizzaTorneo({required this.tornei, required this.giocatore, Key? key}) : super(key: key);
  @override
  _VisualizzaTorneoState createState() => _VisualizzaTorneoState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _VisualizzaTorneoState extends State<VisualizzaTorneo> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();


  bool late=false;
  TorneoAccettato torneo = TorneoAccettato();



  late Map<String,String> mapping=new Map();

  @override
  Widget build(BuildContext context) {
    //this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.



    List<TorneoAccettato>tornei=widget.tornei;
    Giocatore giocatore=widget.giocatore;
    print(tornei);
    return Scaffold(
        appBar: AppBar(
          title: Text("Torneo Attivi"),
        ),

        body: ListView.builder(
            itemCount: tornei.length,
            itemBuilder: (context,index){
              return Card(
                child: ListTile(
                  leading:Icon(Icons.request_page, color: Colors.black, size: 50.0,),
                  title: Text("Nome Torneo: "+tornei[index].nome),
                  subtitle:  Text("Sport: "+tornei[index].sport.sport.toString().split(".").last),
                  onTap: (){
                    getSquadre(tornei[index].id_torneo).then((value) async =>
                    {
                      await Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return DettaglioTorneoAccettato(torneo: tornei[index],giocatore:giocatore,squadre:value);
                          }
                      ))
                    }
                    );

                  },
                ),
              );
            }
        )
    );
  }

}