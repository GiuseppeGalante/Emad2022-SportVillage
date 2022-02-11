import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AggiungiPartitaTorneo.dart';
import 'package:flutter_app_emad/screens/AddPartitaTorneo.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/ComponenteSquadra.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/Squadre.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';
import 'package:flutter_app_emad/entity/TorneiPronti.dart';
import 'package:flutter_app_emad/entity/TorneiRifiutati.dart';
import 'package:flutter_app_emad/screens/DettaglioSquadreTorneo.dart';
import 'package:flutter_app_emad/screens/home.dart';
//import 'package:flutter_app_emad/screens/GestioneSquadre.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestaTorneo.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestePartita.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';

class PartiteTorneo extends StatelessWidget {


  const PartiteTorneo({required this.torneo,required this.giocatore, required this.partite,Key? key,}) : super(key: key);
  final TorneoPronto torneo;
  final Giocatore giocatore;
  final List<PartitaTorneo> partite;

  static const appTitle = 'home sport village';


  @override
  Widget build(BuildContext context) {
    print(torneo);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkBlue,
        title: Text("Squadre Torneo "+torneo.nome),
      ),

      body: DettaglioPartiteTorneoState(torneo:torneo, giocatore:giocatore,partite: partite,),

    );
  }
}
class DettaglioPartiteTorneoState extends StatefulWidget
{
  var title;
  final TorneoPronto torneo;
  final Giocatore giocatore;
  List<PartitaTorneo> partite;
  DettaglioPartiteTorneoState({Key? key,required this.torneo,required this.giocatore,required this.partite}) : super(key: key);
  @override
  _DettaglioPartiteTorneoState createState() => _DettaglioPartiteTorneoState(torneo: torneo,giocatore: giocatore,partite:partite);
}

class _DettaglioPartiteTorneoState extends State<DettaglioPartiteTorneoState> {

  var title;
  final TorneoPronto torneo;
  final Giocatore giocatore;
  List<PartitaTorneo> partite;
  String _value="";
  _DettaglioPartiteTorneoState({Key? key,required this.torneo,required this.giocatore,required this.partite});
  @override
  Widget build(BuildContext context) {
    print("TORNEO:  "+torneo.id_torneo);
    return Scaffold(
      body: SafeArea(
        child: Column(
            children: [
              Container(
                color: LightColors.kLightYellow,
                width: double.infinity,
                height:MediaQuery.of(context).size.height-155,
                child: ListView.builder(
                    itemCount: (partite.length),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                          children: <Widget>
                          [
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5.0),
                              clipBehavior: Clip.antiAlias,
                              color: LightColors.kLightYellow,
                              elevation: 5.0,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  child:Row(
                                    children: [
                                      Icon(Icons.shield, size: 50,color: LightColors.kRed),
                                      Expanded(
                                      flex: 6,
                                      child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(partite[index].data+" - "+partite[index].ora, style: TextStyle(
                                            fontSize: 16.0,
                                            color: LightColors.kDarkBlue,
                                            fontWeight: FontWeight.bold,
                                          )),
                                          Text(partite[index].squadra1+" vs "+partite[index].squadra2, style: TextStyle(
                                            fontSize: 18.0,
                                            color: LightColors.kDarkBlue,
                                            fontWeight: FontWeight.bold,
                                          )),
                                          Text(partite[index].campo, style: TextStyle(
                                            fontSize: 15.0,
                                            color: LightColors.kDarkBlue,
                                            fontWeight: FontWeight.bold,
                                          )),
                                        ],
                                      ),
                                          ),
                                      Icon(Icons.shield, size: 50,color: LightColors.kBlue),
                                    ],
                                  ),



                                /*ListTile(

                                    leading:Icon(Icons.group_add, size: 40,color: Colors.blueGrey),
                                    title:Text(partite[index].squadra1+" vs "+partite[index].squadra2, style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    )),

                                    subtitle:Text(partite[index].campo),
                                    trailing: Icon(Icons.group_add, size: 40,color: Colors.blueGrey),
                      ),*/
                      ),
                            ),



                            SizedBox(
                                height: 10.0
                            ),
                          ]);
                    }
                ),
              ),
            ]
        ),

      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          getSquadre(torneo.id_torneo).then((value) =>
      {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) {
                 return AddPartitaTorneo(squadre: value, torneo:torneo,giocatore:giocatore);
      }
      )),
        setState((){getPartiteTorneo(torneo.id_torneo).then((value) =>{ setState((){widget.partite=value;})});}),
      }
      );

        },
        label: const Text('Aggiungi Partita'),
        backgroundColor: LightColors.kGreen,
        icon: const Icon(Icons.add),
      ),
    );
  }
}