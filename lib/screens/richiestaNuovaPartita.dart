import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';

import 'InfoCentroSportivo.dart';
import 'home.dart';



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
  TimeOfDay selectedTime = TimeOfDay.now();


  bool late=false;
  late String _idCentro="";
  late CentroSportivo centroSportivo = getCentroSportivo(_idCentro) as CentroSportivo;
  List<CentroSportivo> filtered=[];

  String idAdmin="";
  RichiestaNuovaPartita richiestaNuovaPartita = RichiestaNuovaPartita();


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
        richiestaNuovaPartita.orario= selectedTime.hour.toString()+":"+selectedTime.minute.toString();
      });
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
      appBar: AppBar(
        title: Text("Registrazione"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString()),
                      SizedBox(height: 20.0,),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Seleziona una data'),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(selectedTime.hour.toString()+":"+selectedTime.minute.toString()),
                      SizedBox(height: 20.0,),
                      ElevatedButton(
                        onPressed: () => _selectTime(context),
                        child: Text('Seleziona un orario'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:EdgeInsets.only(top:10),
                  child: Row(
                    children: <Widget>[
                      Padding(padding:EdgeInsets.only(bottom:20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width-78,
                            child:Container(
                              color: Colors.white,
                              child:Padding(
                                padding: EdgeInsets.only(left:12),
                                child:DropdownButtonFormField<Sport>(
                                  hint: Text("Scegli Sport"),
                                  onChanged: (value){
                                    setState(() {
                                      richiestaNuovaPartita.sport=value!;
                                      filtered=[];
                                      for(int i=0;i<centrisportivi.length;i++)
                                        {

                                          for(int k=0; k<centrisportivi[i].campi.length;k++) {
                                            print(centrisportivi[i].campi[k].tipo.toString()+":"+value.toString());
                                            if(centrisportivi[i].campi[k].tipo.toString() == value.toString() && !filtered.contains(centrisportivi[i])) {
                                              filtered.add(centrisportivi[i]);
                                              _idCentro=filtered[0].nome!;
                                            }
                                          }
                                        }
                                    });
                                  },
                                  validator: (value){
                                    if(value?.index==null)
                                    {
                                      return "Campo obbligatorio";
                                    }
                                  },
                                  onSaved: (value) => richiestaNuovaPartita.sport=value!,
                                  items: [
                                    DropdownMenuItem<Sport>(
                                      child: Text("Calcio",style: TextStyle(color:Colors.black54),),
                                      value: Sport.calcio,
                                    ),DropdownMenuItem<Sport>(
                                      child: Text("Pallavolo",style: TextStyle(color:Colors.black54),),
                                      value: Sport.pallavolo,
                                    ),DropdownMenuItem<Sport>(
                                      child: Text("Tennis",style: TextStyle(color:Colors.black54),),
                                      value: Sport.tennis,
                                    ),DropdownMenuItem<Sport>(
                                      child: Text("Padel",style: TextStyle(color:Colors.black54),),
                                      value: Sport.padel,
                                    ),DropdownMenuItem<Sport>(
                                      child: Text("Ping Pong",style: TextStyle(color:Colors.black54),),
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
                ),Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Centro Sprotivo"),
                    Spacer(),
                    SizedBox(
                      child: DropdownButton<String>(
                        hint: Text('Seleziona sport'),
                        value: _idCentro,
                        onChanged: (value){
                          setState(() {
                            _idCentro=value!;

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
                    )*/
                  ],
                ),/*TextFormField(
                  decoration: InputDecoration(labelText: "Inserisci orario"),
                  onChanged: (value) => richiestaNuovaPartita.orario=value,
                  validator: (value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Campo Obbligatorio";
                    }
                  },
                ),*/TextFormField(
                  decoration: InputDecoration(labelText: "Inserisci numero di partecipanti"),
                  onChanged: (value) => richiestaNuovaPartita.numero_di_partecipanti=int.parse(value),
                  validator: (value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Campo Obbligatorio";
                    }
                  },
                ),ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        print("Nessun errore");
                        _formKey.currentState?.save();
                        //centrosportivo.id_amministratore=amministratore.id.key;
                        richiestaNuovaPartita.id_giocatore=giocatore.id.key!;
                        richiestaNuovaPartita.id_centro_sportivo=mapping[_idCentro]!.id.key;
                        richiestaNuovaPartita.id_amministratore=mapping[_idCentro]!.id_amministratore!;
                        saveRichiestaNuovaPartita(richiestaNuovaPartita);
                        //amministratore.centrisportivi.add(centrosportivo);
                        //updateAmministratoreCS(amministratore);
                        //print("${this.amministratore}");
                        //print(centrosportivo);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return MyHomeGio(giocatore:giocatore);
                            }
                        ));

                      }

                    }
                    , child: Text("Registra centro sportivo")
                )
              ],
            ),
          )
      ),
    );
  }

}

