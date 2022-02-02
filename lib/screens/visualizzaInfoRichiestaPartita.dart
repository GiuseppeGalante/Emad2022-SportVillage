import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Campo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/PartitaConfermata.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';

import 'home.dart';



// Create a Form widget.
class FormInfoRichiestaNuovaPartita extends StatefulWidget {
  RichiestaNuovaPartita richiestanuovapartita;
  //CentroSportivo centroSportivo;
  CentroSportivo centrosportivo;
  AmministstratoreCentroSportivo amministratore;
  FormInfoRichiestaNuovaPartita({required this.richiestanuovapartita, required this.centrosportivo, required this.amministratore, Key? key}) : super(key: key);
  @override
  _FormInfoRichiestaNuovaPartitaState createState() => _FormInfoRichiestaNuovaPartitaState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _FormInfoRichiestaNuovaPartitaState extends State<FormInfoRichiestaNuovaPartita> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();


  bool late=false;
  late String _idCentro=widget.centrosportivo.campi[0].nome;
  String idAdmin="";
  RichiestaNuovaPartita richiestaNuovaPartita = RichiestaNuovaPartita();


  late Map<String,Campo> mapping=new Map();

  @override
  Widget build(BuildContext context) {
    //this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.



    RichiestaNuovaPartita richiestanuovapartita=widget.richiestanuovapartita;
    CentroSportivo centrosportivo=widget.centrosportivo;
    AmministstratoreCentroSportivo amministratore=widget.amministratore;
    print(centrosportivo);
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrazione"),
      ),

      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[
                Wrap(
                  spacing: 20, // to apply margin in the main axis of the wrap
                  runSpacing: 20, // to apply margin in the cross axis of the wrap
                  children: <Widget>[
                    Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                            child:ListTile(
                              leading: Icon(Icons.calendar_today_rounded,size: 50,color:Colors.blueGrey),
                              title: Text("Data:",style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )),
                              subtitle: Text(richiestanuovapartita.data,style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                            )
                          ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 5.0,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                          child:ListTile(
                            leading: Icon(Icons.access_time_rounded,size: 50,color:Colors.blueGrey),
                            title: Text("Orario:",style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            )),
                            subtitle: Text(richiestanuovapartita.orario,style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          )
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 5.0,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                          child:ListTile(
                            leading: Icon(Icons.people_alt_rounded,size: 50,color:Colors.blueGrey),
                            title: Text("Numero di partecipanti:",style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            )),
                            subtitle: Text(richiestanuovapartita.numero_di_partecipanti.toString(),style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          )
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 5.0,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                          child:
                          Wrap(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.sports ,size: 50,color:Colors.blueGrey),
                                title: Text("Seleziona Campo:",style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                )),
                                subtitle: SizedBox(
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child: DropdownButton<String>(
                                    hint: Text('Seleziona un campo'),
                                    value: _idCentro ,
                                    onChanged: (value){
                                      setState(() {
                                        _idCentro=value!;
                                      });
                                    },
                                    items: centrosportivo.campi.map((e) {
                                      mapping[e.nome]=e;
                                      print(e);
                                      return DropdownMenuItem<String>(
                                        child: new Text(e.nome),
                                        value: e.nome,

                                      );

                                    }
                                    ).toList(),
                                  ),
                                ),
                              ),

                            ],
                          )

                      ),
                    ),
                  ],
                )
                ,SizedBox(
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
                                  title: const Text('Richiesta partita'),
                                  content: const Text('Vuoi confermare la richiesta partita?'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      onPressed: (){
                                        Navigator.pop(context_alert, 'Cancel');
                                        print("Salvato");
                                      },
                                      child: const Text('NO'),
                                    ),
                            ElevatedButton(
                                      onPressed: (){
                                        if(_formKey.currentState!.validate()){
                                          print("Nessun errore");
                                          _formKey.currentState?.save();
                                          PartitaConfermata pc= new PartitaConfermata();
                                          pc.id_campo = mapping[_idCentro]!.id.key!;
                                          pc.numero_di_partecipanti= richiestanuovapartita.numero_di_partecipanti;
                                          pc.orario=richiestanuovapartita.orario;
                                          pc.data=richiestanuovapartita.data;
                                          pc.id_centro_sportivo=centrosportivo.id.key;
                                          pc.id_amministratore= centrosportivo.id_amministratore!;
                                          pc.id_giocatore = richiestanuovapartita.id_giocatore;
                                          pc.metodo_di_pagamento= richiestanuovapartita.metodo_di_pagamento;
                                          pc.sport=richiestanuovapartita.sport;
                                          pc.partecipanti.add(richiestanuovapartita.id_giocatore);
                                          pc.partecipanti_trasf=[];
                                          pc.indirizzo=centrosportivo.indirizzo!;
                                          saveNuovaPartitaConfermata(pc);
                                          deleteRichiestaPartita(richiestanuovapartita.id.key!);
                                          //centrosportivo.id_amministratore=amministratore.id.key;
                                          //richiestaNuovaPartita.id_giocatore=giocatore.id.key;
                                          //richiestaNuovaPartita.id_centro_sportivo=mapping[_idCentro]!.id.key;
                                          // richiestaNuovaPartita.id_amministratore=mapping[_idCentro]!.id_amministratore;
                                          //saveRichiestaNuovaPartita(richiestaNuovaPartita);
                                          //amministratore.centrisportivi.add(centrosportivo);
                                          //updateAmministratoreCS(amministratore);
                                          //print("${this.amministratore}");
                                          //print(centrosportivo);
                                          Navigator.pop(context_alert);
                                          Navigator.pop(context);

                                        }
                                      },
                                      child: const Text('SI'),
                                    ),
                                  ],
                                )
                            );

                          },
                          child: Text("Accetta richiesta partita"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green),
                            padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                          ),
                        ),


                        Padding(
                          padding: EdgeInsets.only(left:5),
                          child: ElevatedButton(
                            onPressed: (){
                              showDialog<String>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context_alert) => AlertDialog(
                                    title: const Text('Rifiuta richiesta partita'),
                                    content: const Text('Sei sicuro di voler rifiutare la richiesta partita?'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () => Navigator.pop(context_alert, 'Cancel'),
                                        child: const Text('NO'),
                                      ),
                                      ElevatedButton(
                                      onPressed: (){
                                        deleteRichiestaPartita(richiestanuovapartita.id.key!);
                                        Navigator.pop(context_alert);
                                        Navigator.pop(context);
                                      }
                                       /* onPressed: () {
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



                                          saveTorneoRifiutato(torneorif);
                                          deleteTorneoRifiutato(torneo.id_richiesta_torneo);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: const Text('Torneo Rifiutato'),
                                              backgroundColor: Colors.green,
                                              action: SnackBarAction(textColor:Colors.white,
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
                                        }*/,
                                        child: const Text('SI'),
                                      ),
                                    ],
                                  )
                              );

                            },
                            child: Text("Rifiuta richiesta partita"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.red),
                              padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                            ),
                          ),

                        )

                      ]
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

}

