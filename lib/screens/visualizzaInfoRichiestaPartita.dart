import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Campo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/PartitaConfermata.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../animation/FadeAnimation.dart';
import '../widgets/signupContainer.dart';
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
        backgroundColor: Colors.white,
        body:
        SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: SizedBox(
                height: 900,
                width: 1500,
                child: Stack(
                  children: [
                    Positioned(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 1,
                        child: SignUpContainer()),
                    NestedScrollView(
                        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[

                            SliverToBoxAdapter(
                                child: FadeAnimation(1, Padding(
                                  padding: EdgeInsets.only(top: 60.0, right: 20.0, left: 20.0),
                                  child: Text(
                                    'Richiesta nuova \npartita',
                                    style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.grey.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ))
                          ];
                        },
                        body:
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedContainer(
                                  height: 120,
                                  width: 1500,
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  //margin: EdgeInsets.only(bottom: 20),
                                  duration: Duration(milliseconds: 1500),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.white.withOpacity(1),
                                          width: 2
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: Offset(0, 3),
                                            blurRadius: 10
                                        )
                                      ]
                                  ),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.network("https://i.ibb.co/DVLkjyv/output-onlinegiftools-3.gif",width: 40,),

                                          //SizedBox(width: 80,),

                                          //SizedBox(width: 50,),
                                          //SizedBox(height: 35,),
                                          FadeAnimation(1.2, Text("Data", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,),textAlign: TextAlign.center,)),
                                          FadeAnimation(1.2, Text(richiestanuovapartita.data, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,),textAlign: TextAlign.center,)),



                                        ],
                                      )




                                ),
                                SizedBox(height: 30,),
                                AnimatedContainer(
                                  height: 120,
                                  width: 1500,
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  //margin: EdgeInsets.only(bottom: 20),
                                  duration: Duration(milliseconds: 1500),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.white.withOpacity(1),
                                          width: 2
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: Offset(0, 3),
                                            blurRadius: 10
                                        )
                                      ]
                                  ),
                                  child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.network("https://i.ibb.co/zSBj40J/output-onlinegiftools-6.gif",width: 40,),

                                          //SizedBox(width: 80,),

                                          //SizedBox(width: 50,),
                                          //SizedBox(height: 35,),
                                          FadeAnimation(1.2, Text("Orario", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,),textAlign: TextAlign.center,)),
                                          FadeAnimation(1.2, Text(richiestanuovapartita.orario, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,),textAlign: TextAlign.center,)),



                                        ],
                                      )




                                ),
                                SizedBox(height: 30,),
                                AnimatedContainer(
                                  height: 120,
                                  width: 1500,
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  //margin: EdgeInsets.only(bottom: 20),
                                  duration: Duration(milliseconds: 1500),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.white.withOpacity(1),
                                          width: 2
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: Offset(0, 3),
                                            blurRadius: 10
                                        )
                                      ]
                                  ),

                                  child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.network("https://media0.giphy.com/media/hVh9kYorSATXYcmcww/giphy.gif",width: 40,),

                                              //SizedBox(width: 80,),

                                              //SizedBox(width: 50,),
                                              //SizedBox(height: 35,),
                                              FadeAnimation(1.2, Text("Numero di partecipanti", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,),textAlign: TextAlign.center,)),
                                              FadeAnimation(1.2, Text(richiestanuovapartita.numero_di_partecipanti.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,),textAlign: TextAlign.center,)),



                                        ],
                                      )




                                ),

                                SizedBox(height: 30,),
                                Center(
                                  child: FadeAnimation(1.4, Text("Seleziona campo", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600,),textAlign: TextAlign.center,)),
                                ),

                                SizedBox(height: 10,),
                                Container(
                                  height: 50,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left:18),
                                    child:
                                    SizedBox(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text('Seleziona un campo',style: TextStyle(

                                          color: LightColors.kDarkBlue,
                                          fontWeight: FontWeight.w800,
                                        ),),
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

                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      height: 100,
                                      width: 120,
                                      margin: const EdgeInsets.only(bottom: 20.0),
                                      child:ElevatedButton(

                                        style: ElevatedButton.styleFrom(
                                          primary: LightColors.kLightYellow,
                                        ),
                                        onPressed: (){
                                          showDialog<String>(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context_alert) => AlertDialog(
                                                title: const Text('Richiesta partita',
                                                  style: TextStyle(
                                                    color: LightColors.kDarkBlue,
                                                    fontWeight: FontWeight.w800,
                                                  ),),
                                                content: const Text('Vuoi confermare la richiesta partita?',style: TextStyle(
                                                  color: LightColors.kDarkBlue,
                                                  fontWeight: FontWeight.w800,
                                                ),),
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

                                        }
                                        , child: Text("Accetta richiesta",
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: LightColors.kDarkBlue,
                                          fontWeight: FontWeight.w800,
                                        ),),
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      height: 100,
                                      width: 120,
                                      margin: const EdgeInsets.only(bottom: 20.0),
                                      child:ElevatedButton(

                                        style: ElevatedButton.styleFrom(

                                          primary: LightColors.kLightYellow,
                                        ),
                                        onPressed: (){
                                          showDialog<String>(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context_alert) => AlertDialog(
                                                title: const Text('Rifiuta richiesta partita',style: TextStyle(
                                                  color: LightColors.kDarkBlue,
                                                  fontWeight: FontWeight.w800,
                                                ),),
                                                content: const Text('Sei sicuro di voler rifiutare la richiesta partita?',style: TextStyle(
                                                  color: LightColors.kDarkBlue,
                                                  fontWeight: FontWeight.w800,
                                                ),),
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

                                        }
                                        , child: Text("Rifiuta richiesta",
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: LightColors.kDarkBlue,
                                          fontWeight: FontWeight.w800,
                                        ),),
                                      ),
                                    ),
                                  ],
                                )


                              ],
                            ),
                          ),
                        )
                    ),

                  ],
                )
            ),
          ),
        )

    );
  }

}

