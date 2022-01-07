import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';

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


  bool late=false;
  late String _idCentro="";
  String idAdmin="";
  RichiestaNuovaPartita richiestaNuovaPartita = RichiestaNuovaPartita();


  late Map<String,CentroSportivo> mapping=new Map();

  @override
  Widget build(BuildContext context) {
    //this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.



    Giocatore giocatore=widget.giocatore;
    List<CentroSportivo>centrisportivi=widget.centrisportivi;

    print("id giocatore bl:"+giocatore.toString());
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
                TextFormField(
                  decoration: InputDecoration(labelText: "Seleziona data"),
                  onChanged: (value) => richiestaNuovaPartita.data=value,
                  validator: (value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Campo Obbligatorio";
                    }
                  },
                ),Padding(
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
                  children: <Widget>[
                    Text("Centro Sprotivo"),
                    Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/1.5,
                      child: DropdownButton<String>(
                        hint: Text('Scegli un centro sportivo'),
                        value: _idCentro ,
                        onChanged: (value){
                          setState(() {
                            _idCentro=value!;
                          });
                        },
                        items: centrisportivi.map((e) {
                          mapping[e.nome]=e;
                          print(e);
                          return DropdownMenuItem<String>(
                            child: new Text(e.nome),
                            value: e.nome,

                          );

                        }
                        ).toList(),
                      ),
                    )
                  ],
                ),TextFormField(
                  decoration: InputDecoration(labelText: "Inserisci orario"),
                  onChanged: (value) => richiestaNuovaPartita.orario=value,
                  validator: (value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Campo Obbligatorio";
                    }
                  },
                ),TextFormField(
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
                        richiestaNuovaPartita.id_giocatore=giocatore.id.key;
                        richiestaNuovaPartita.id_centro_sportivo=mapping[_idCentro]!.id.key;
                        richiestaNuovaPartita.id_amministratore=mapping[_idCentro]!.id_amministratore;
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

