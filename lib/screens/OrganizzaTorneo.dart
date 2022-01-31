import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AggiungiPartitaTorneo.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/entity/Squadre.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';
import 'package:flutter_app_emad/entity/TorneiPronti.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/DettaglioTorneiAccettati.dart';
import 'package:flutter_app_emad/screens/DettaglioTorneo.dart';
import 'package:flutter_app_emad/screens/DettaglioTorneoPronto.dart';
import 'package:flutter_app_emad/screens/PartiteTorneo.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';

import 'home.dart';



// Create a Form widget.
class OrganizzaTorneo extends StatefulWidget {
  Giocatore giocatore;
  //CentroSportivo centroSportivo;
  List<TorneoPronto>tornei=[];

  OrganizzaTorneo({required this.tornei, required this.giocatore, Key? key}) : super(key: key);
  @override
  _OrganizzaTorneoState createState() => _OrganizzaTorneoState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _OrganizzaTorneoState extends State<OrganizzaTorneo> {
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



    List<TorneoPronto>tornei=widget.tornei;
    Giocatore giocatore=widget.giocatore;
    print(tornei);
    return Scaffold(
        appBar: AppBar(
          title: Text("Torneo Pronti"),
        ),

        body: ListView.builder(
            itemCount: tornei.length,
            itemBuilder: (context,index){
              return Card(
                child: ListTile(
                  leading:Icon(Icons.request_page, color: Colors.black, size: 50.0,),
                  title: Text("Nome Torneo: "+tornei[index].nome),
                  subtitle:  Text("Sport: "+tornei[index].sport.toString().split(".").last),
                  onTap: (){
                    getPartiteTorneo(tornei[index].id_torneo).then((value) =>
                    {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return PartiteTorneo(torneo: tornei[index],giocatore:giocatore,partite:value);
                          }
                      )),
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