import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/ComponenteSquadra.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/Squadre.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';
import 'package:flutter_app_emad/entity/TorneiRifiutati.dart';
import 'package:flutter_app_emad/screens/home.dart';
//import 'package:flutter_app_emad/screens/GestioneSquadre.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestaTorneo.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestePartita.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';

class DettaglioSquadraTorneo extends StatelessWidget {


  const DettaglioSquadraTorneo({required this.squadra,required this.giocatore, required this.componenti,Key? key,}) : super(key: key);
  final Squadra squadra;
  final Giocatore giocatore;
  final List<Componente> componenti;
  static const appTitle = 'home sport village';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkBlue,
        title: Text("Componenti "+squadra.nome),
      ),

      body: DettaglioSquadraTorneoState(squadra:squadra, giocatore:giocatore,componenti: componenti,),

    );
  }
}
class DettaglioSquadraTorneoState extends StatefulWidget
{
  var title;
  final Squadra squadra;
  final Giocatore giocatore;
  final List<Componente> componenti;
  DettaglioSquadraTorneoState({Key? key,required this.squadra,required this.giocatore,required this.componenti}) : super(key: key);
  @override
  _DettaglioSquadraTorneoState createState() => _DettaglioSquadraTorneoState(squadra: squadra,giocatore: giocatore,componenti: componenti);
}

class _DettaglioSquadraTorneoState extends State<DettaglioSquadraTorneoState> {

  var title;
  final Squadra squadra;
  final Giocatore giocatore;
  final List<Componente> componenti;
  String _value="";
  _DettaglioSquadraTorneoState({Key? key,required this.squadra,required this.giocatore,required this.componenti});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
          child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height:MediaQuery.of(context).size.height-155,
                  child: ListView.builder(
                      itemCount: (squadra.partecipanti).toInt(),
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
                                    child: ListTile(

                                        leading:Icon(Icons.group_add, size: 50,color: LightColors.kDarkBlue),
                                        title:Text(componenti[index].nome_utente, style: TextStyle(
                                          fontSize: 22.0,
                                          color: LightColors.kBlue,
                                          fontWeight: FontWeight.bold,
                                        )),
                                        /*subtitle: (){
                                          if(squadre[index].partecipanti<squadre[index].max_partecipanti)
                                          {
                                            return Text("Prenotazioni Aperte",style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),);
                                          }else
                                          {
                                            return Text("Prenotazioni Chiuse",style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),);
                                          }
                                        }(),
                                        trailing: PopupMenuButton(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 20
                                              ),
                                              child:Icon(Icons.more_vert, size: 30,color: Colors.blueGrey),
                                            ),
                                            onSelected: (value) {
                                              setState(() {
                                                _value=value.toString();
                                                if(_value=="1")
                                                {
                                                  if(squadre[index].partecipanti<squadre[index].max_partecipanti) {
                                                    showDialog<String>(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (
                                                            BuildContext context_alert) =>
                                                            AlertDialog(
                                                              title: const Text(
                                                                  'Aggiunta alla squadra'),
                                                              content: const Text(
                                                                  'Vuoi entrare in questa squadra?'),
                                                              actions: <Widget>[
                                                                ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                        context_alert,
                                                                        'Cancel');
                                                                  },
                                                                  child: const Text('NO'),
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                        context_alert, 'OK');
                                                                    if (squadre[index].partecipanti < squadre[index].max_partecipanti) {
                                                                      Squadra s = new Squadra();
                                                                      s.aggiungiComponente(squadre[index].id_squadra.toString(), squadre[index].partecipanti + 1);
                                                                      Componente componente=new Componente();
                                                                      componente.id_squadra=squadre[index].id_squadra;
                                                                      componente.nome_utente=giocatore.nome_utente;
                                                                      componente.id_giocatore=giocatore.id.key!;
                                                                      saveComponente(componente);


                                                                      ScaffoldMessenger.of(
                                                                          context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content: const Text(
                                                                              'Aggiunta Effettuata'),
                                                                          backgroundColor: Colors
                                                                              .green,
                                                                          action: SnackBarAction(
                                                                            textColor: Colors
                                                                                .white,
                                                                            label: 'OK',
                                                                            onPressed: () {},),
                                                                        ),
                                                                      );
                                                                      getSquadre(torneo.id_torneo).then((value) =>
                                                                      {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (
                                                                                    context) {
                                                                                  return DettaglioTorneoAccettato(
                                                                                      torneo: torneo,
                                                                                      giocatore: giocatore,
                                                                                      squadre: value);
                                                                                }
                                                                            ))
                                                                      }
                                                                      );
                                                                    }
                                                                  },
                                                                  child: const Text('SI'),
                                                                ),

                                                              ],
                                                            )
                                                    );
                                                  }
                                                  else
                                                  {
                                                    showDialog<String>(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (
                                                            BuildContext context_alert) =>
                                                            AlertDialog(
                                                              title: Icon(Icons.error, size: 70,color: Colors.red),
                                                              content: const Text(
                                                                  'La squadra è al completo',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                                              actions: <Widget>[
                                                                ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                        context_alert,
                                                                        'Cancel');
                                                                  },
                                                                  child: const Text('OK'),
                                                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),),
                                                                ),
                                                              ],
                                                            )
                                                    );
                                                  }
                                                }
                                                else if(_value=="2")
                                                {
                                                  getComponenti(squadre[index].id_squadra).then((value) =>
                                                  {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) {
                                                              return DettaglioSquadraTorneo(
                                                                  squadra: squadre[index],
                                                                  giocatore: giocatore,
                                                                  squadre: value);
                                                            }
                                                        ))
                                                  }
                                                  );
                                                }
                                              });
                                            },
                                            itemBuilder: (context) =>[
                                              PopupMenuItem(
                                                child: ListTile(
                                                  leading: Icon(Icons.add),
                                                  title: Text('Aggiungiti'),
                                                ),
                                                value: "1",
                                              ),
                                              const PopupMenuItem(
                                                child: ListTile(
                                                  leading: Icon(Icons.info),
                                                  title: Text('Visualizza'),
                                                ),
                                                value:"2",
                                              ),
                                            ]
                                        ),*/


                                        /*Text((){
                                      if(squadre[index].partecipanti<squadre[index].max_partecipanti)
                                      {
                                        return squadre[index].partecipanti.toString()+"/"+squadre[index].max_partecipanti.toString();
                                      }
                                      else
                                        {
                                          return "Esauriti";
                                        }
                                    }())*/
                                        onTap: ()
                                        {
                                        }
                                    )
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
          )
      ),
    );
  }
}
