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
import 'package:flutter_app_emad/screens/DettaglioSquadreTorneo.dart';
import 'package:flutter_app_emad/screens/ProfiloGiocatore.dart';
import 'package:flutter_app_emad/screens/home.dart';
//import 'package:flutter_app_emad/screens/GestioneSquadre.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestaTorneo.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestePartita.dart';
class DettaglioMatchTorneo extends StatelessWidget {


  const DettaglioMatchTorneo({required this.torneo,required this.giocatore, required this.partita,required this.componenti_sq1,required this.componenti_sq2,Key? key,}) : super(key: key);
  final TorneoPronto torneo;
  final Giocatore giocatore;
  final List<Componente> componenti_sq1;
  final List<Componente> componenti_sq2;
  final PartitaTorneo partita;

  static const appTitle = 'home sport village';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Componenti Partita"),
      ),

      body: DettaglioMatchTorneoState(torneo:torneo, giocatore:giocatore,partita: partita,componenti_sq1:componenti_sq1,componenti_sq2:componenti_sq2),

    );
  }
}
class DettaglioMatchTorneoState extends StatefulWidget
{
  var title;
  final TorneoPronto torneo;
  final Giocatore giocatore;
  final List<Componente> componenti_sq1;
  final List<Componente> componenti_sq2;
  final PartitaTorneo partita;
  DettaglioMatchTorneoState({Key? key,required this.torneo,required this.giocatore,required this.partita,required this.componenti_sq1,required this.componenti_sq2}) : super(key: key);
  @override
  _DettaglioMatchTorneoState createState() => _DettaglioMatchTorneoState(torneo: torneo,giocatore: giocatore,partita: partita,componenti_sq1:componenti_sq1,componenti_sq2:componenti_sq2);
}

class _DettaglioMatchTorneoState extends State<DettaglioMatchTorneoState> {






  var title;
  final TorneoPronto torneo;
  final Giocatore giocatore;
  final List<Componente> componenti_sq1;
  final List<Componente> componenti_sq2;
  final PartitaTorneo partita;
  String _value="";
  _DettaglioMatchTorneoState({Key? key,required this.torneo,required this.giocatore,required this.partita,required this.componenti_sq1,required this.componenti_sq2});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                    clipBehavior: Clip.antiAlias,
                    color: Colors.white,
                    elevation: 5.0,
                    child:Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child:
                            Container(
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(partita.data+" - "+partita.ora,style: TextStyle(
                                        fontSize: 15
                                    ),),
                                ],
                              ),
                            ),
                      ),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                    clipBehavior: Clip.antiAlias,
                    color: Colors.white,
                    elevation: 5.0,
                    child:Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child:
                      Container(
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(partita.squadra1,style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),),
                                Text(" vs ",style: TextStyle(
                                    fontSize: 20
                                ),),
                                Text(partita.squadra2,style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              )
            ),
            Container(
              height:MediaQuery.of(context).size.height/2,
              child:ListView.builder(
            itemCount: (componenti_sq1.length),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                  children: <Widget>
                  [
                    Row(
                      children: [
                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                          child:InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: ()
                            async {
                                await getGiocatoreByUser(componenti_sq1[index].nome_utente).then((value) =>
                                {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context){
                                          return ProfiloGio(giocatore:value, title: title,);
                                        }
                                       ))

                                }

                                );

                              },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child:Row(
                                children: [
                                  Icon(Icons.shield, size: 40,color: Colors.red),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width/4,
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(componenti_sq1[index].nome_utente, style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                      ],
                                    ),
                                  ),
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

                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                          child:InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: ()
                            async {
                              await getGiocatoreByUser(componenti_sq2[index].nome_utente).then((value) =>
                              {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context){
                                      return ProfiloGio(giocatore:value, title: title,);
                                    }
                                ))

                              }

                              );

                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child:Row(
                                children: [
                                 SizedBox(
                                   width: MediaQuery.of(context).size.width/4,
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(componenti_sq2[index].nome_utente, style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        )),
                                      ],
                                    ),
                                  ),




                                  Icon(Icons.shield, size: 40,color: Colors.blue),
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
                      ],
                    ),
                    SizedBox(
                        height: 10.0
                    ),
                  ]);
            }
              /*return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                  child:Column(
                        children: <Widget>[
                            Text(componenti_sq1[index].nome_utente,style: TextStyle(
                                fontSize: 20
                            )),
                        ],
                      ),
                  ),
                  Container(
                 child:Column(
                    children: [
                        Text(componenti_sq2[index].nome_utente,style: TextStyle(
                            fontSize: 20
                        )),
                    ],
                  )
                  ),
                ],
              );

            }*/
              ),

            )
          ],
        ),

      ),
    );
  }
}

