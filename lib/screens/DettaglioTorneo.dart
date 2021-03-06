import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/entity/Squadre.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';
import 'package:flutter_app_emad/entity/TorneiRifiutati.dart';
//import 'package:flutter_app_emad/screens/GestioneSquadre.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestaTorneo.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestePartita.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';

class DettaglioTorneo extends StatelessWidget {

  const DettaglioTorneo({required this.torneo,required this.amministratore,Key? key}) : super(key: key);
  final RichiestaTorneo torneo;
  final AmministstratoreCentroSportivo amministratore;
  static const appTitle = 'home sport village';


  @override
  Widget build(BuildContext context) {
    print(torneo);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkBlue,
        title: Text("Dettaglio "+torneo.nome),
      ),
      body: DettaglioTorneoState(torneo:torneo, amministratore: amministratore,),
    );
  }
}
class DettaglioTorneoState extends StatefulWidget
{
  var title;
  final RichiestaTorneo torneo;
  final AmministstratoreCentroSportivo amministratore;

  DettaglioTorneoState({Key? key,required this.torneo,required this.amministratore}) : super(key: key);
  @override
  _DettaglioTorneoState createState() => _DettaglioTorneoState(torneo: torneo,amministratore: amministratore);
}

class _DettaglioTorneoState extends State<DettaglioTorneoState> {



  int _selectedIndex = 2;
  var title;
  final RichiestaTorneo torneo;
  final AmministstratoreCentroSportivo amministratore;
  _DettaglioTorneoState({Key? key,required this.torneo,required this.amministratore});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            children: [
              Container(
                color: LightColors.kLightYellow,
                width: double.infinity,
                height:MediaQuery.of(context).size.height-106,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding:EdgeInsets.only(top:10),
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: LightColors.kLightYellow,
                        elevation: 5.0,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                            child:ListTile(
                              leading: Icon(Icons.emoji_events,size: 50,color:LightColors.kBlue),
                              title: Text("Nome:",style: TextStyle(
                                fontSize: 18.0,
                                color: LightColors.kDarkBlue,
                                fontWeight: FontWeight.bold,
                              )),
                              subtitle: Text(torneo.nome,style: TextStyle(
                                fontSize: 22.0,
                                color: LightColors.kBlue,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color:LightColors.kLightYellow,
                      elevation: 5.0,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                          child:ListTile(
                            leading: Icon(Icons.sports,size: 50,color:LightColors.kBlue),
                            title: Text("Sport:",style: TextStyle(
                              fontSize: 18.0,
                              color:LightColors.kDarkBlue,
                              fontWeight: FontWeight.bold,
                            )),
                            subtitle: Text(torneo.sport.sport.toString().split(".").last,style: TextStyle(
                              fontSize: 22.0,
                              color:LightColors.kBlue,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          )
                      ),
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color:LightColors.kLightYellow,
                      elevation: 5.0,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                          child:ListTile(
                            leading: Icon(Icons.phone,size: 50,color:LightColors.kBlue),
                            title: Text("Modalit??:",style: TextStyle(
                              fontSize: 18.0,
                              color: LightColors.kDarkBlue,
                              fontWeight: FontWeight.bold,
                            )),
                            subtitle: Text(torneo.modalita.toString().split(".").last.replaceAll("_", " "),style: TextStyle(
                              fontSize: 22.0,
                              color: LightColors.kBlue,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          )
                      ),
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color: LightColors.kLightYellow,
                      elevation: 5.0,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                          child:ListTile(
                            leading: Icon(Icons.group,size: 50,color:LightColors.kBlue),
                            title: Text("Numero di Squadre:",style: TextStyle(
                              fontSize: 18.0,
                              color: LightColors.kDarkBlue,
                              fontWeight: FontWeight.bold,
                            )),
                            subtitle: Text(torneo.numero_di_partecipanti.toString(),style: TextStyle(
                              fontSize: 22.0,
                              color: LightColors.kBlue,
                              fontWeight: FontWeight.bold,
                            ),
                            ),

                          )
                      ),
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                            Center(
                              child:Row(
                                mainAxisAlignment:MainAxisAlignment.center,
                                  children:
                                  [
                                    ElevatedButton(

                                      onPressed: (){
                                        showDialog<String>(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context_alert) => AlertDialog(
                                          title: const Text('Conferma Torneo',style: TextStyle(
                                            fontSize: 15.0,
                                            color: LightColors.kBlue,
                                            fontWeight: FontWeight.w800,
                                          ),),
                                          content: const Text('Sei sicuro di voler accettare il torneo?',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: LightColors.kBlue,
                                              fontWeight: FontWeight.w800,
                                            ),),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              onPressed: (){
                                                Navigator.pop(context_alert, 'Cancel');
                                              },
                                              child: const Text('NO'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                Navigator.pop(context_alert, 'OK');
                                                TorneoAccettato torneoaccettato=new TorneoAccettato();
                                                Squadra s=new Squadra();
                                                torneoaccettato.id_torneo=torneo.id_richiesta_torneo;
                                                torneoaccettato.id_centro_sportivo=torneo.id_centro_sportivo;
                                                torneoaccettato.id_amministratore=torneo.id_amministratore;
                                                torneoaccettato.numero_di_partecipanti=torneo.numero_di_partecipanti;
                                                torneoaccettato.nome=torneo.nome;
                                                torneoaccettato.sport=torneo.sport;
                                                torneoaccettato.modalita=torneo.modalita.toString();
                                                CentroSportivo cs= await getCentroSportivo(torneoaccettato.id_centro_sportivo);
                                                torneoaccettato.indirizzo=cs.indirizzo!;
                                                torneoaccettato.id_giocatore=torneo.id_giocatore;



                                                saveTorneoAccettato(torneoaccettato);
                                                deleteRichiestaAccettata(torneo.id_richiesta_torneo);
                                                s.creaSquadre(torneoaccettato.numero_di_partecipanti, torneoaccettato.sport,torneoaccettato.id_torneo);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: const Text('Torneo Accettato'),
                                                    backgroundColor: LightColors.kGreen,
                                                    action: SnackBarAction(textColor:LightColors.kLightYellow,
                                                      label: 'OK', onPressed: () {},),
                                                  ),
                                                );

                                                Timer(Duration(seconds: 2), ()
                                                {
                                                  getRichiesteTornei(acs:amministratore).then((value) =>
                                                  {
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context){
                                                          return VisualizzaRichiesteTorneo(amministratore:amministratore,richiestetornei: value,);
                                                        }
                                                    ))
                                                  }
                                                  );
                                                });
                                              },
                                              child: const Text('SI'),
                                            ),

                                          ],

                                        )
                                        );

                                      },
                                      child: Text("Accetta Torneo"),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(LightColors.kGreen),
                                        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                                      ),
                                    ),


                                    Padding(
                                      padding: EdgeInsets.only(left:10),
                                      child: ElevatedButton(
                                          onPressed: (){
                                            showDialog<String>(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (BuildContext context_alert) => AlertDialog(
                                                  title: const Text('Rifiuta Torneo',style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: LightColors.kBlue,
                                                    fontWeight: FontWeight.w800,
                                                  ),),
                                                  content: const Text('Sei sicuro di voler rifiutare il torneo?',
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: LightColors.kBlue,
                                                      fontWeight: FontWeight.w800,
                                                    ),),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      onPressed: () => Navigator.pop(context_alert, 'Cancel'),
                                                      child: const Text('NO'),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context_alert, 'OK');
                                                        TorneoRifiutato torneorif=new TorneoRifiutato();
                                                        torneorif.id_torneo=torneo.id_richiesta_torneo;
                                                        torneorif.id_centro_sportivo=torneo.id_centro_sportivo;
                                                        torneorif.id_amministratore=torneo.id_amministratore;
                                                        torneorif.numero_di_partecipanti=torneo.numero_di_partecipanti;
                                                        torneorif.nome=torneo.nome;
                                                        torneorif.sport=torneo.sport.toString();
                                                        torneorif.modalita=torneo.modalita.toString();
                                                        torneorif.id_giocatore=torneo.id_giocatore;



                                                        //saveTorneoRifiutato(torneorif);
                                                        deleteTorneoRifiutato(torneo.id_richiesta_torneo);
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: const Text('Torneo Rifiutato'),
                                                            backgroundColor: LightColors.kGreen,
                                                            action: SnackBarAction(textColor:LightColors.kLightYellow,
                                                              label: 'OK', onPressed: () {},),
                                                          ),
                                                        );

                                                        Timer(Duration(seconds: 2), ()
                                                        {
                                                          getRichiesteTornei(acs:amministratore).then((value) =>
                                                          {
                                                            Navigator.push(context, MaterialPageRoute(
                                                                builder: (context){
                                                                  return VisualizzaRichiesteTorneo(amministratore:amministratore,richiestetornei: value,);
                                                                }
                                                            ))
                                                          }
                                                          );
                                                        });
                                                      },
                                                      child: const Text('SI'),
                                                    ),
                                                  ],
                                                )
                                            );

                                      },
                                          child: Text("Rifiuta Torneo"),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(LightColors.kRed),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                                        ),
                                      ),

                                    )

                                  ]
                              ),
                            )



                  ],
                ),
              ),
    ]
          ),
    );
  }
}
