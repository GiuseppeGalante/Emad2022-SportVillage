import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AggiungiPartitaTorneo.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Campo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/ComponenteSquadra.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/Squadre.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';
import 'package:flutter_app_emad/entity/TorneiPronti.dart';
import 'package:flutter_app_emad/entity/TorneiRifiutati.dart';
import 'package:flutter_app_emad/screens/PartiteTorneo.dart';
import 'package:flutter_app_emad/screens/home.dart';
//import 'package:flutter_app_emad/screens/GestioneSquadre.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestaTorneo.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestePartita.dart';

class AddPartitaTorneo extends StatelessWidget {


  const AddPartitaTorneo({required this.squadre,required this.torneo,required this.giocatore,Key? key,}) : super(key: key);
  final List<Squadra> squadre;
  final TorneoPronto torneo;
  final Giocatore giocatore;
  static const appTitle = 'home sport village';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crea Partita"),
      ),

      body: AddPartitaTorneoState(squadre:squadre,torneo:torneo,giocatore:giocatore),

    );
  }
}
class AddPartitaTorneoState extends StatefulWidget
{
  var title;
  final List<Squadra> squadre;
  final Giocatore giocatore;
  TorneoPronto torneo;
  AddPartitaTorneoState({Key? key,required this.squadre,required this.torneo,required this.giocatore}) : super(key: key);
  @override
  _AddPartitaTorneoState createState() => _AddPartitaTorneoState(squadre: squadre,torneo:torneo,giocatore:giocatore);
}

class _AddPartitaTorneoState extends State<AddPartitaTorneoState> {

  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  var title;
  final List<Squadra> squadre;
  TorneoPronto torneo;
  Giocatore giocatore;
  String nomeCampo="";
  String squadra1="";
  String squadra2="";
  List<Campo> campi=[];
  PartitaTorneo partita=new PartitaTorneo();
  late Map<String, Campo> mapping = new Map();
  late Map<String, Squadra> mapping1 = new Map();
  late Map<String, Squadra> mapping2 = new Map();





  String _idCampo="";

  _AddPartitaTorneoState({Key? key,required this.squadre,required this.torneo,required this.giocatore});

  @override
  Widget build(BuildContext first_context) {
    Future<List> dati=getCampiBySport(torneo.id_centro_sportivo.toString(),torneo.sport).then((value) => campi = value).whenComplete(() => _idCampo = campi[0].nome!);
    return Scaffold(
      body: SafeArea(
        child:Column(
              children: [
        FutureBuilder<List>(
        future: dati,
        builder:(BuildContext context, AsyncSnapshot<List> snapshot) {
          Future<void> _selectDate(BuildContext context) async {
            final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2015, 8),
                lastDate: DateTime(2101));
            if (picked != null && picked != selectedDate) {
              setState(() {

                selectedDate = picked;
                partita.data=selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString();
              });
            }
          }

          Future<void> _selectTime(BuildContext context) async {
            final TimeOfDay? picked_s = await showTimePicker(
              context: context,
              initialTime: selectedTime,
              builder: (context, child) =>
                  MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!,),

            );

            if (picked_s != null && picked_s != selectedTime ) {
              setState(() {

                selectedTime = picked_s;
                partita.ora= selectedTime.hour.toString()+":"+selectedTime.minute.toString();
              });
            }
            else
              {
                partita.ora= selectedTime.hour.toString()+":"+selectedTime.minute.toString();
              }
          }
          if (snapshot.hasData) {
            return
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.5,
                child: Form(
                  key: _formKey,
                  child:ListView(
                    children: [
                      Column(
                          children: <Widget>
                          [
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5.0),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white,
                              elevation: 5.0,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  child: ListTile(

                                      leading: Icon(Icons.group_add, size: 50,
                                          color: Colors.blueGrey),
                                      title: Container(
                                        color: Colors.white,

                                          child: DropdownButtonFormField<String>(
                                            hint: Text('Scegli una squadra'),
                                            onChanged: (value) {
                                              setState(() {
                                                squadra1= value!;
                                              });
                                            },
                                            validator: (value) {
                                              if (value == null) {
                                                return "Campo obbligatorio";
                                              }
                                            },
                                            items: squadre.map((e) {
                                              mapping1[e.nome!] = e;
                                              return DropdownMenuItem<String>(
                                                child: new Text(e.nome!),
                                                value: e.nome,

                                              );
                                            }
                                            ).toList(),
                                        ),
                                      ),
                                      onTap: () {}
                                  )
                              ),
                            ),
                            SizedBox(
                                height: 10.0
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5.0),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white,
                              elevation: 5.0,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  child: ListTile(

                                      leading: Icon(Icons.group_add, size: 50,
                                          color: Colors.blueGrey),
                                      title: DropdownButtonFormField<String>(
                                        hint: Text('Scegli una squadra'),
                                        onChanged: (value) {

                                          setState(() {
                                            squadra2 = value!;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return "Campo obbligatorio";
                                          }
                                        },
                                        items: squadre.map((e) {
                                          mapping2[e.nome!] = e;
                                          return DropdownMenuItem<String>(
                                            child: new Text(e.nome!),
                                            value: e.nome,

                                          );
                                        }
                                        ).toList(),
                                      ),
                                      onTap: () {}
                                  )
                              ),
                            ),
                            SizedBox(
                                height: 10.0
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5.0),
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white,
                              elevation: 5.0,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  child: ListTile(

                                      leading: Icon(Icons.location_on, size: 50,
                                          color: Colors.blueGrey),
                                      title:DropdownButtonFormField<String>(
                                        hint: Text('Scegli un campo'),
                                        onChanged: (value) {
                                          setState(() {
                                            nomeCampo = value!;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return "Campo obbligatorio";
                                          }
                                        },
                                        items: campi.map((e) {
                                          mapping[e.nome!] = e;
                                          return DropdownMenuItem<String>(
                                            child: new Text(e.nome!),
                                            value: e.nome,

                                          );
                                        }
                                        ).toList(),
                                      ),
                                      onTap: () {}
                                  )
                              ),
                            ),
                            SizedBox(
                                height: 10.0
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: ListTile(

                                        leading: Icon(
                                            Icons.calendar_today, size: 50,
                                            color: Colors.blueGrey),
                                        title:ElevatedButton(
                                          onPressed: () => _selectDate(context),
                                          child: Text('Data'),
                                        ),
                                    )
                                ),
                                Expanded(
                                    child: ListTile(

                                        leading: Icon(Icons.schedule, size: 50,
                                            color: Colors.blueGrey),
                                        title: ElevatedButton(
                                          onPressed: () => _selectTime(context),
                                          child: Text('Ora'),
                                        ),
                                    )
                                )

                              ],
                            ),
                            SizedBox(
                                height: 10.0
                            ),
                            ElevatedButton(onPressed: () {
                              if(_formKey.currentState!.validate()){
                                if(partita.data!="")
                                  {
                                    if(partita.ora!="")
                                    {
                                      _formKey.currentState?.save();
                                      partita.id_torneo=torneo.id_torneo;
                                      partita.squadra1=mapping1[squadra1]!.nome;
                                      partita.squadra2=mapping2[squadra2]!.nome;
                                      partita.id_squadra1=mapping1[squadra1]!.id_squadra;
                                      partita.id_squadra2=mapping2[squadra2]!.id_squadra;
                                      partita.campo=mapping[nomeCampo]!.nome;
                                      savePartita(partita);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Partita Creata'),
                                          backgroundColor: Colors.green,
                                          action: SnackBarAction(textColor:Colors.white,
                                            label: 'OK', onPressed: () {},),
                                        ),
                                      );
                                      Timer(Duration(seconds: 2), ()
                                      {
                                        getPartiteTorneo(torneo.id_torneo).then((value) =>
                                        {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context){
                                                return PartiteTorneo(torneo: torneo,giocatore:giocatore,partite:value);
                                              }
                                          )),
                                        });
                                      });
                                    }
                                  }



                              }
                            }, child:
                            Text("Aggiungi"))


                          ])
                    ]
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
        }
  ),
              ]
          )
          ),
    );
  }
}