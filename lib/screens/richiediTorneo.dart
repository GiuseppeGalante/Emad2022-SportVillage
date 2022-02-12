import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/entity/Sport.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/screens/login.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';

import '../animation/FadeAnimation.dart';
import '../widgets/signupContainer.dart';
import 'home.dart';



// Create a Form widget.
class FormRichiestaTorneo extends StatefulWidget {
  Giocatore giocatore;
  FormRichiestaTorneo({required this.giocatore,Key? key}) : super(key: key);
  @override
  _FormRichiestaTorneoState createState() => _FormRichiestaTorneoState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _FormRichiestaTorneoState extends State<FormRichiestaTorneo> {


  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();
  List<CentroSportivo>centrisportivi = [];

  bool late = false;
   String _idCentro="";
   String nomeCentro="";
   String idAdmin="";
  RichiestaTorneo richiestaTorneo = RichiestaTorneo();
  List<CentroSportivo> filtered=[];

  late Map<String, CentroSportivo> mapping = new Map();
  @override
  Widget build(BuildContext context) {
    //this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.

    //print(centrisportivi);
    Future<List> dati=getCentriSportivi().then((value) => centrisportivi = value).whenComplete(() => _idCentro = centrisportivi[0].nome!);


    Giocatore giocatore = widget.giocatore;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: SizedBox(
                height: 2500,
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
                                    'Richiesta nuovo \ntorneo',
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
                                FadeAnimation(1.2, Text("Scegli sport", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                                SizedBox(height: 10,),
                                Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: LightColors.kLightYellow,style: BorderStyle.solid,width: 1.0),
                                        ),
                                        /*focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid,width: 1.0),
                            ),*/
                                        labelText: "Inserisci Nome Torneo",
                                        filled: true,
                                        fillColor: LightColors.kLightYellow,
                                      ),
                                      onChanged: (value) =>
                                      richiestaTorneo.nome = value,
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return "Campo Obbligatorio";
                                        }
                                      },
                                    ),
                                ),
                                SizedBox(height: 20,),
                                SizedBox(height: 10,),
                                FadeAnimation(1.2, Text("Scegli sport", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                                SizedBox(height: 10,),
                                Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left:12),
                                      child:DropdownButtonFormField<Sport>(
                                        hint: Text("Scegli Sport",style: TextStyle(
                                          color: LightColors.kDarkBlue,
                                          fontWeight: FontWeight.w800,
                                        ),),
                                        onChanged: (value) {
                                          setState(() {
                                            richiestaTorneo.sport = new SportClass(value!);
                                            filtered=[];
                                            for(int i=0;i<centrisportivi.length;i++)
                                            {

                                              for(int k=0; k<centrisportivi[i].campi.length;k++) {
                                                print(centrisportivi[i].campi[k].tipo.sport.toString()+":"+value.toString());
                                                if(centrisportivi[i].campi[k].tipo.sport.toString() == value.toString() && !filtered.contains(centrisportivi[i])) {
                                                  filtered.add(centrisportivi[i]);
                                                  _idCentro=filtered[0].nome!;
                                                }
                                              }
                                            }
                                          });
                                        },
                                        validator: (value) {
                                          if (value?.index == null) {
                                            return "Campo obbligatorio";
                                          }
                                        },
                                        onSaved: (value) =>
                                        richiestaTorneo.sport = new SportClass(value!),
                                        items: [
                                          DropdownMenuItem<Sport>(
                                            child: Text(
                                              "Calcio", style: TextStyle(
                                              color: LightColors.kDarkBlue,
                                              fontWeight: FontWeight.w800,
                                            ),),
                                            value: Sport.calcio,
                                          ), DropdownMenuItem<Sport>(
                                            child: Text("Pallavolo",
                                              style: TextStyle(
                                                color: LightColors.kDarkBlue,
                                                fontWeight: FontWeight.w800,
                                              ),),
                                            value: Sport.pallavolo,
                                          ), DropdownMenuItem<Sport>(
                                            child: Text(
                                              "Tennis", style: TextStyle(
                                              color: LightColors.kDarkBlue,
                                              fontWeight: FontWeight.w800,
                                            ),),
                                            value: Sport.tennis,
                                          ), DropdownMenuItem<Sport>(
                                            child: Text(
                                              "Padel", style: TextStyle(
                                              color: LightColors.kDarkBlue,
                                              fontWeight: FontWeight.w800,
                                            ),),
                                            value: Sport.padel,
                                          ), DropdownMenuItem<Sport>(
                                            child: Text("Ping Pong",
                                              style:TextStyle(
                                                color: LightColors.kDarkBlue,
                                                fontWeight: FontWeight.w800,
                                              ),),
                                            value: Sport.pingpong,
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                                SizedBox(height: 40,),
                                FadeAnimation(1.2, Text("Scegli centro sportivo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                                SizedBox(height: 10,),
                                Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left:12),
                                      child:DropdownButtonFormField<String>(
                                        hint: Text('Scegli un centro sportivo',
                                          style:TextStyle(
                                            color: LightColors.kDarkBlue,
                                            fontWeight: FontWeight.w800,
                                          ),),
                                        onChanged: (value) {
                                          setState(() {
                                            nomeCentro = value!;
                                            idAdmin=mapping[value]!.id_amministratore!;
                                          });
                                        },
                                        items: filtered.map((e) {
                                          mapping[e.nome!] = e;
                                          return DropdownMenuItem<String>(
                                            child: new Text(e.nome!),
                                            value: e.nome,

                                          );
                                        }
                                        ).toList(),
                                      ),
                                    )
                                ),
                                SizedBox(height: 40,),
                                FadeAnimation(1.4, Text("Scegli modalità", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                                SizedBox(height: 10,),
                                Container(
                                  height: 50,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child:
                                  Padding(
                                    padding: EdgeInsets.only(left:18),
                                    child:
                                    SizedBox(
                                      child:  DropdownButtonFormField<Modalita>(
                                        hint: Text("Scegli Modalità",style:TextStyle(
                                          color: LightColors.kDarkBlue,
                                          fontWeight: FontWeight.w800,
                                        ),),
                                        onChanged: (value) {
                                          setState(() {
                                            richiestaTorneo.modalita = value!;
                                          });
                                        },
                                        validator: (value) {
                                          if (value?.index == null) {
                                            return "Campo obbligatorio";
                                          }
                                        },
                                        onSaved: (value) =>
                                        richiestaTorneo.modalita = value!,
                                        items: [
                                          DropdownMenuItem<Modalita>(
                                            child: Text(
                                              "Solo Andata", style: TextStyle(
                                              color: LightColors.kDarkBlue,
                                              fontWeight: FontWeight.w800,
                                            ),),
                                            value: Modalita.Andata,
                                          ),DropdownMenuItem<Modalita>(
                                            child: Text(
                                              "Andata e Ritorno", style: TextStyle(
                                              color: LightColors.kDarkBlue,
                                              fontWeight: FontWeight.w800,
                                            ),),
                                            value: Modalita.Andata_e_Ritorno,
                                          ),DropdownMenuItem<Modalita>(
                                            child: Text(
                                              "All' Italiana", style: TextStyle(
                                              color: LightColors.kDarkBlue,
                                              fontWeight: FontWeight.w800,
                                            ),),
                                            value: Modalita.All_Italiana,
                                          ),

                                        ],

                                      ),


                                    ),
                                  ),

                                ),
                                SizedBox(height: 20,),
                                FadeAnimation(1.4, Text("Inserisci numero di squadre", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                                SizedBox(height: 10,),
                                Container(
                                  height: 50,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child:
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "Inserisci numero di squadre",
                                      filled: true,
                                      fillColor:LightColors.kLightYellow,
                                    ),
                                    onChanged: (value) =>
                                    richiestaTorneo.numero_di_partecipanti =
                                        int.parse(value),

                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return "Campo Obbligatorio";
                                      }
                                    },
                                  )

                                ),
                                SizedBox(height: 30),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  height: 50,
                                  margin: const EdgeInsets.only(bottom: 20.0),
                                  child:ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: LightColors.kLightYellow,
                                    ),
                                    onPressed: (){
                                      if (_formKey.currentState!.validate()) {
                                        print("Nessun errore");
                                        _formKey.currentState?.save();
                                        richiestaTorneo.id_amministratore=idAdmin;
                                        richiestaTorneo.id_giocatore = giocatore.id.key!;
                                        richiestaTorneo.id_centro_sportivo =mapping[nomeCentro]!.id.key;
                                        saveRichiestaTorneo(richiestaTorneo);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: const Text('Richiesta Inoltrata'),
                                            backgroundColor: LightColors.kGreen,
                                            action: SnackBarAction(textColor:Colors.white,
                                              label: 'OK', onPressed: () {},),
                                          ),
                                        );
                                        //amministratore.centrisportivi.add(centrosportivo);
                                        //updateAmministratoreCS(amministratore);
                                        //print("${this.amministratore}");
                                        //print(centrosportivo);
                                        Timer(Duration(seconds: 2), ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) {
                                                return MyHomeGio(giocatore: giocatore);
                                              }
                                          ));
                                        });
                                      }

                                    }
                                    , child: Text("Richiedi nuovo torneo",
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: LightColors.kDarkBlue,
                                      fontWeight: FontWeight.w800,
                                    ),),
                                  ) ,
                                ),

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