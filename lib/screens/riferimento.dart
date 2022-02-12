import 'dart:async';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Campo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/Prenotazioni.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Sport.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';

import 'InfoCentroSportivo.dart';
import 'home.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';



// Create a Form widget.
class FormRichiestaNuovaPartita extends StatefulWidget {
  Giocatore giocatore;
  //CentroSportivo centroSportivo;
  List<CentroSportivo>centrisportivi=[];
  FormRichiestaNuovaPartita({required this.giocatore, required this.centrisportivi, Key? key}) : super(key: key);

  @override
  _FormRichiestaNuovaPartitaState createState() => _FormRichiestaNuovaPartitaState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _FormRichiestaNuovaPartitaState extends State<FormRichiestaNuovaPartita> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();


  DateTime selectedDate = DateTime.now();
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 0);


  bool late=false;
  late String _idCentro="";
  late CentroSportivo centroSportivo = getCentroSportivo(_idCentro) as CentroSportivo;
  List<CentroSportivo> filtered=[];

  String idAdmin="";
  RichiestaNuovaPartita richiestaNuovaPartita = RichiestaNuovaPartita();
  List<int> partecipanti=[];
  int? n_partecipanti=null;

  String nomeCampo="";
  late Map<String, Campo> mapping_campo = new Map();
  List<Campo> campi=[];

  String _idCampo="";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {

        selectedDate = picked;
        richiestaNuovaPartita.data=selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString();
      });
    }
  }

  /*Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      builder: (context, child) =>
          MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!,),

    );

    if (picked_s != null && picked_s != selectedTime && picked_s.minute==0) {
      setState(() {

        selectedTime = picked_s;
        richiestaNuovaPartita.orario= selectedTime.hour.toString()+":"+selectedTime.minute.toString()+"0";
      });
    }
    else
      {
        if(picked_s?.minute==0) {
          richiestaNuovaPartita.orario= selectedTime.hour.toString()+":"+selectedTime.minute.toString()+"0";
        }else
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Orario non disponibile'),
              backgroundColor: LightColors.kRed,
              action: SnackBarAction(textColor:LightColors.kLightYellow,
                label: 'OK', onPressed: () {},),
            ),
          );
        }
      }
  }*/

  void onTimeChanged(TimeOfDay newTime) {
    if (newTime != null && newTime != _time) {
      setState(() {

        _time= newTime;
        richiestaNuovaPartita.orario= _time.hour.toString()+":"+newTime.minute.toString()+"0";
      });
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Orario non disponibile'),
          backgroundColor: Colors.red,
          action: SnackBarAction(textColor:Colors.white,
            label: 'OK', onPressed: () {},),
        ),
      );
    }
  }


  late Map<String,CentroSportivo> mapping=new Map();

  @override
  Widget build(BuildContext context) {
    //this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.



    Giocatore giocatore=widget.giocatore;
    List<CentroSportivo>centrisportivi=widget.centrisportivi;

    print(filtered);
    //print("id giocatore bl:"+giocatore.toString());
    print("i filtered:"+filtered.toString());
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      appBar: AppBar(
        backgroundColor: LightColors.kDarkBlue,
        title: Text("Richiedi nuova partita"),
      ),
      body: Form(


          key: _formKey,
          child: Padding(

            padding: EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[

                SizedBox(height: 30.0,),
                //Image.asset("assets/images/logo.png"),
                /*TextFormField(
                  decoration: InputDecoration(labelText: "Seleziona data"),
                  onChanged: (value) => richiestaNuovaPartita.data=value,
                  validator: (value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Campo Obbligatorio";
                    }
                  },
                ),*/
                Center(

                  child: Row(

                    //mainAxisSize: MainAxisSize.min,
                    children: <Widget>[


                      SizedBox(width: 40.0,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white ,
                        ),
                        onPressed: () => _selectDate(context),
                        child: Icon(
                          Icons.date_range ,
                          color: LightColors.kDarkBlue,
                          size: 24.0,
                        ),
                      ),
                      SizedBox(width: 20.0,),
                      Text(selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString(),style: TextStyle(

                        color: LightColors.kDarkBlue,
                        fontWeight: FontWeight.w800,
                      ),),
                      SizedBox(width: 40.0,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () =>
                        {Navigator.of(context).push(
                          showPicker(
                            context: context,
                            value: _time,
                            onChange: onTimeChanged,
                            is24HrFormat: true,
                            disableMinute: true,
                            minHour:9,
                            maxHour:22,
                            // Optional onChange to receive value as DateTime
                            onChangeDateTime: (DateTime dateTime) {
                              print(dateTime);
                            },
                          ),
                        )
                        },
                        child: Icon(
                          Icons.access_time_rounded ,
                          color: LightColors.kDarkBlue,
                          size: 24.0,
                        ),
                      ),
                      SizedBox(width: 20.0,),
                      Text(_time.hour.toString()+":"+_time.minute.toString()+"0",style: TextStyle(

                        color: LightColors.kDarkBlue,
                        fontWeight: FontWeight.w800,
                      ),),
                    ],
                  ),
                ),
                /* Center(
                  child: Row(
                    //mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      SizedBox(width: 40.0,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () => _selectTime(context),
                        child: Icon(
                          Icons.access_time_rounded ,
                          color: Colors.blue,
                          size: 24.0,
                        ),
                      ),
                      SizedBox(width: 50.0,),
                      Text(selectedTime.hour.toString()+":"+selectedTime.minute.toString()),

                    ],
                  ),
                ),*/
                Padding(
                  padding:EdgeInsets.only(top:10),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.emoji_events, color: LightColors.kDarkBlue, size: 30.0,),
                      SizedBox(width: 10),
                      Padding(padding:EdgeInsets.only(bottom:20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width-78,
                            child:Container(
                              color: Colors.white,
                              child:Padding(
                                padding: EdgeInsets.only(left:12),
                                child:DropdownButtonFormField<Sport>(
                                  hint: Text("Scegli Sport",style: TextStyle(
                                    color: LightColors.kDarkBlue,
                                    fontWeight: FontWeight.w800,
                                  ),),
                                  onChanged: (value){
                                    setState(() {
                                      richiestaNuovaPartita.sport=new SportClass(value!);
                                      filtered=[];
                                      n_partecipanti=richiestaNuovaPartita.sport.partecipanti.first;
                                      partecipanti=richiestaNuovaPartita.sport.partecipanti;
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
                                  validator: (value){
                                    if(value==null)
                                    {
                                      return "Campo obbligatorio";
                                    }
                                  },
                                  onSaved: (value) => richiestaNuovaPartita.sport=new SportClass(value!),
                                  items: [
                                    DropdownMenuItem<Sport>(
                                      child: Text("Calcio",style: TextStyle(color:LightColors.kDarkBlue),),
                                      value: Sport.calcio,
                                    ),DropdownMenuItem<Sport>(
                                      child: Text("Pallavolo",style: TextStyle(color:LightColors.kDarkBlue),),
                                      value: Sport.pallavolo,
                                    ),DropdownMenuItem<Sport>(
                                      child: Text("Tennis",style: TextStyle(color:LightColors.kDarkBlue),),
                                      value: Sport.tennis,
                                    ),DropdownMenuItem<Sport>(
                                      child: Text("Padel",style: TextStyle(color:LightColors.kDarkBlue),),
                                      value: Sport.padel,
                                    ),DropdownMenuItem<Sport>(
                                      child: Text("Ping Pong",style: TextStyle(color:LightColors.kDarkBlue),),
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
                Row(

                  children: [
                    Icon(Icons.sports, color: LightColors.kDarkBlue, size: 30.0,),
                    SizedBox(width: 20),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: LightColors.kLightYellow,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.elliptical(5,5))
                        ),
                        margin:  const EdgeInsets.only(bottom: 20.0),
                        //color: Colors.white,
                        child:Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(width:10),
                            Text("Centro Sportivo",
                              style: TextStyle(
                                color: LightColors.kDarkBlue,
                                fontWeight: FontWeight.w800,
                              ),),
                            SizedBox(width: 11),
                            SizedBox(
                              child: DropdownButton<String>(
                                hint: Text('Seleziona centro',style: TextStyle(
                                  color: LightColors.kDarkBlue,
                                  fontWeight: FontWeight.w800,
                                ),),
                                value: _idCentro,
                                onChanged: (value) {
                                  setState(() {
                                    _idCentro=value!;
                                  });
                                  getCampiBySport(mapping[_idCentro]!.id.key.toString(), richiestaNuovaPartita.sport.sport.toString().substring(6)).then((value) => campi = value).whenComplete(() =>{
                                    setState(() {
                                      _idCampo = campi[0].nome!;
                                    })
                                  });
                                },
                                items: filtered.map((e) {
                                  mapping[e.nome!]=e;
                                  //print(e);
                                  return DropdownMenuItem<String>(
                                    child: new Text(e.nome!),
                                    value: e.nome,

                                  );

                                }
                                ).toList(),
                              ),
                            ),/*
                    ElevatedButton(

                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){

                                return InfoCentroSportivo(  centroSportivo: centroSportivo);
                              }
                          ));
                        }
                        , child: Text("Info Centro Sportivo")
                    )*/SizedBox(width: 20),
                          ],

                        )

                    )
                  ],
                ),





                Row(

                  children: [
                    Icon(Icons.sports, color: LightColors.kDarkBlue, size: 30.0,),
                    SizedBox(width: 20),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.elliptical(5,5))
                        ),
                        margin:  const EdgeInsets.only(bottom: 20.0),
                        //color: Colors.white,
                        child:Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(width: 10),
                            Text("Campo",style: TextStyle(
                              color: LightColors.kDarkBlue,
                              fontWeight: FontWeight.w800,
                            ),),
                            SizedBox(width: 30),
                            SizedBox(
                              width: 190,
                              child: DropdownButtonFormField<String>(
                                hint: Text('Scegli un campo',style: TextStyle(
                                  color: LightColors.kDarkBlue,
                                  fontWeight: FontWeight.w800,
                                ),),
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
                                  mapping_campo[e.nome!] = e;
                                  return DropdownMenuItem<String>(
                                    child: new Text(e.nome!),
                                    value: e.nome,

                                  );
                                }
                                ).toList(),
                              ),
                            ),/*
                    ElevatedButton(

                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){

                                return InfoCentroSportivo(  centroSportivo: centroSportivo);
                              }
                          ));
                        }
                        , child: Text("Info Centro Sportivo")
                    )*/SizedBox(width: 20),
                          ],

                        )

                    )
                  ],
                ),



                /*TextFormField(
                  decoration: InputDecoration(labelText: "Inserisci orario"),
                  onChanged: (value) => richiestaNuovaPartita.orario=value,
                  validator: (value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Campo Obbligatorio";
                    }
                  },
                ),*/

                DropdownButton<int>(

                  hint: Text('Seleziona numero di partecipanti',style: TextStyle(
                    color: LightColors.kDarkBlue,
                    fontWeight: FontWeight.w800,
                  ),),
                  value: n_partecipanti,
                  onChanged: (value){
                    setState(() {
                      richiestaNuovaPartita.numero_di_partecipanti=value!;
                      n_partecipanti=value;
                    });
                  },
                  items: partecipanti.map((e)
                  {
                    return DropdownMenuItem<int>(
                      child: new Text(e.toString(),style: TextStyle(
                        color: LightColors.kDarkBlue,
                        fontWeight: FontWeight.w800,
                      ),),
                      value: e,
                    );
                  }

                  ) .toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: LightColors.kLightYellow,
                  ),
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      print("Nessun errore");
                      List<String> data_divisa=[];
                      List<String> ora_divisa=[];
                      data_divisa=richiestaNuovaPartita.data.split("/");
                      print(data_divisa);
                      ora_divisa=richiestaNuovaPartita.orario.split(":");
                      DateTime d=new DateTime(int.parse(data_divisa[2]),int.parse(data_divisa[1]),int.parse(data_divisa[0]));
                      TimeOfDay t=new TimeOfDay(hour: int.parse(ora_divisa[0]), minute: int.parse(ora_divisa[1]));
                      print(d);
                      print(t);
                      getPrenotazioni(mapping_campo[nomeCampo]!.id.key!,d,t).then((value) =>
                      {
                        print(mapping_campo[nomeCampo]!.id.key!),
                        if(value==true)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Orario già occupato'),
                                backgroundColor: LightColors.kRed,
                                action: SnackBarAction(textColor:Colors.white,
                                  label: 'OK', onPressed: () {},),
                              ),
                            )
                          }else
                          {
                            _formKey.currentState?.save(),
                            richiestaNuovaPartita.id_giocatore=giocatore.id.key!,
                            richiestaNuovaPartita.id_centro_sportivo=mapping[_idCentro]!.id.key,
                            richiestaNuovaPartita.id_amministratore=mapping[_idCentro]!.id_amministratore!,
                            richiestaNuovaPartita.campo=mapping_campo[_idCampo]!.id.key!,
                            saveRichiestaNuovaPartita(richiestaNuovaPartita),
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Partita Creata'),
                                backgroundColor: LightColors.kGreen,
                                action: SnackBarAction(textColor:Colors.white,
                                  label: 'OK', onPressed: () {},),
                              ),
                            ),
                            Timer(Duration(seconds: 2), ()
                            {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context){
                                    return MyHomeGio(giocatore:giocatore);
                                  }
                              ));
                            }),
                          }
                      },
                      );

                    }

                  }
                  , child: Text("Richiedi nuova partita",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: LightColors.kDarkBlue,
                    fontWeight: FontWeight.w800,
                  ),),
                )
              ],
            ),
          )
      ),
    );
  }

}

