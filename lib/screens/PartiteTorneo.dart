import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
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
import 'package:flutter_app_emad/screens/DettaglioMatchTorneo.dart';
import 'package:flutter_app_emad/screens/DettaglioSquadreTorneo.dart';
import 'package:flutter_app_emad/screens/home.dart';
//import 'package:flutter_app_emad/screens/GestioneSquadre.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestaTorneo.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestePartita.dart';

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

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }
  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    // Do some stuff.
    Navigator.pop(context);
    return true;
  }

  var title;
  final TorneoPronto torneo;
  final Giocatore giocatore;
  List<PartitaTorneo> partite;
  String _value="";
  _DettaglioPartiteTorneoState({Key? key,required this.torneo,required this.giocatore,required this.partite});
  @override
  Widget build(BuildContext context) {
    print("TORNEO:  "+torneo.id_torneo);
    print(partite.length);
    return Scaffold(
      body: SafeArea(
        child: Column(
            children: [
              Container(
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
                              color: Colors.white,
                              elevation: 5.0,
                              child:InkWell(
                                     splashColor: Colors.blue.withAlpha(30),
                                       onTap: () {
                                         getComponenti(partite[index].id_squadra1).then((value) =>
                                         {

                                           getComponenti(partite[index].id_squadra2).then((value1)=>
                                               {
                                                 Navigator.push(context,MaterialPageRoute(
                                                     builder: (context){
                                                       return DettaglioMatchTorneo(torneo: torneo, giocatore: giocatore, partita:partite[index],componenti_sq1: value, componenti_sq2: value1);
                                                     })),

                                               }
                                           )
                                         }

                                         );
                                  },
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  child:Row(
                                    children: [
                                      Icon(Icons.shield, size: 50,color: Colors.red),
                                      Expanded(
                                      flex: 6,
                                      child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(partite[index].data+" - "+partite[index].ora, style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                          )),
                                          Text(partite[index].squadra1+" vs "+partite[index].squadra2, style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          )),
                                          Text(partite[index].campo, style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold,
                                          )),
                                        ],
                                      ),
                                          ),
                                      Icon(Icons.shield, size: 50,color: Colors.blue),
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
      floatingActionButton:(){
        if(giocatore.id.key==torneo.id_giocatore)
          {
            return FloatingActionButton.extended(
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
              backgroundColor: Colors.green,
              icon: const Icon(Icons.add),
            );
          }

      }(),
    );
  }
}