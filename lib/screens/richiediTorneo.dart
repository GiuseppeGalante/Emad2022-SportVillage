import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/screens/login.dart';

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
    Future<List> dati=getCentriSportivi().then((value) => centrisportivi = value).whenComplete(() => _idCentro = centrisportivi[0].nome);


    Giocatore giocatore = widget.giocatore;
    return Scaffold(
        appBar: AppBar(
          title: Text("Richiesta Torneo"),
        ),

        body: Stack(
          children:[
          Container(
          color: Colors.blue,
        ),
        FutureBuilder<List>(
            future: dati,
            builder:(BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData) {
                return



                  Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding:EdgeInsets.only(top:10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.emoji_events, color: Colors.white, size: 30.0,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey,style: BorderStyle.solid,width: 1.0),
                            ),
                            /*focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid,width: 1.0),
                            ),*/
                            labelText: "Nome Torneo",
                            filled: true,
                            fillColor: Colors.white,
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

                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.sports, color: Colors.white, size: 30.0,),
                              Padding(padding: EdgeInsets.only(left: 16),
                                  child: SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 78,
                                    child: Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: DropdownButtonFormField<Sport>(
                                          hint: Text("Scegli Sport"),
                                          onChanged: (value) {
                                            setState(() {
                                              richiestaTorneo.sport =
                                              value!;
                                              filtered=[];
                                              for(int i=0;i<centrisportivi.length;i++)
                                              {

                                                for(int k=0; k<centrisportivi[i].campi.length;k++) {
                                                  print(centrisportivi[i].campi[k].tipo.toString()+":"+value.toString());
                                                  if(centrisportivi[i].campi[k].tipo.toString() == value.toString() && !filtered.contains(centrisportivi[i])) {
                                                    filtered.add(centrisportivi[i]);
                                                    _idCentro=filtered[0].nome;
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
                                          richiestaTorneo.sport = value!,
                                          items: [
                                            DropdownMenuItem<Sport>(
                                              child: Text(
                                                "Calcio", style: TextStyle(
                                                  color: Colors.black54),),
                                              value: Sport.calcio,
                                            ), DropdownMenuItem<Sport>(
                                              child: Text("Pallavolo",
                                                style: TextStyle(
                                                    color: Colors.black54),),
                                              value: Sport.pallavolo,
                                            ), DropdownMenuItem<Sport>(
                                              child: Text(
                                                "Tennis", style: TextStyle(
                                                  color: Colors.black54),),
                                              value: Sport.tennis,
                                            ), DropdownMenuItem<Sport>(
                                              child: Text(
                                                "Padel", style: TextStyle(
                                                  color: Colors.black54),),
                                              value: Sport.padel,
                                            ), DropdownMenuItem<Sport>(
                                              child: Text("Ping Pong",
                                                style: TextStyle(
                                                    color: Colors.black54),),
                                              value: Sport.pingpong,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                       Padding(
                         padding:EdgeInsets.only(top:10),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.fitness_center, color: Colors.white, size: 30.0,),
                            Padding(padding:EdgeInsets.only(left: 16),
                            child: SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width-78,
                              child:Container(
                                color: Colors.white,
                                child:Padding(
                                  padding: EdgeInsets.only(left:12),
                                  child: DropdownButtonFormField<String>(
                                   hint: Text('Scegli un centro sportivo'),
                                   onChanged: (value) {
                                     setState(() {
                                    nomeCentro = value!;
                                    idAdmin=mapping[value]!.id_amministratore;
                                  });
                                },
                                items: filtered.map((e) {
                                  mapping[e.nome] = e;
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
                            )
                          ],
                        ),
                  ),

                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.sports, color: Colors.white, size: 30.0,),
                              Padding(padding: EdgeInsets.only(left: 16),
                                  child: SizedBox(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 78,
                                    child: Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: DropdownButtonFormField<Modalita>(
                                          hint: Text("Scegli Modalità"),
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
                                                  color: Colors.black54),),
                                              value: Modalita.Andata,
                                            ),DropdownMenuItem<Modalita>(
                                              child: Text(
                                                "Andata e Ritorno", style: TextStyle(
                                                  color: Colors.black54),),
                                              value: Modalita.Andata_e_Ritorno,
                                            ),DropdownMenuItem<Modalita>(
                                              child: Text(
                                                "All' Italiana", style: TextStyle(
                                                  color: Colors.black54),),
                                              value: Modalita.All_Italiana,
                                            ),

                                          ],

                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ],

                          ),
                        ),
                    Padding(
                      padding:EdgeInsets.only(top:10),
                      child:
                      TextFormField(
                        keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            icon: Icon(Icons.groups, color: Colors.white, size: 30.0,
                            ),
                              labelText: "Inserisci numero di partecipanti",
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          onChanged: (value) =>
                          richiestaTorneo.numero_di_partecipanti =
                              int.parse(value),

                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Campo Obbligatorio";
                            }
                          },
                        ),
                    ),
                    Center(
                      child: Padding(
                        padding:EdgeInsets.only(top:10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print("Nessun errore");
                                _formKey.currentState?.save();
                                richiestaTorneo.id_amministratore=idAdmin;
                                richiestaTorneo.id_giocatore = giocatore.id.key;
                                richiestaTorneo.id_centro_sportivo =mapping[nomeCentro]!.id.key;
                                saveRichiestaTorneo(richiestaTorneo);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Richiesta Inoltrata'),
                                    backgroundColor: Colors.green,
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
                            , child: Text("Richiedi Torneo",style: TextStyle(
                          color:Colors.black54))
                        )
                      ),
                    ),
                      ],
                    ),
                  ),
                );





              }else if(snapshot.hasError)
              {
                return Text('Error: ${snapshot.error}');
              } else {
                return
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  );
              }
            })
        ]),
    );
  }
}