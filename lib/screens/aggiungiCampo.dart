import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Campo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Sport.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';


//TODO: passare il riferimento amministratore anzichè centro sportivo.
// Create a Form widget.
class FormCampo extends StatefulWidget {
  AmministstratoreCentroSportivo amministratore;
  FormCampo({required this.amministratore,Key? key}) : super(key: key);
  @override
  _FormCampoState createState() => _FormCampoState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _FormCampoState extends State<FormCampo> {



  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  late AmministstratoreCentroSportivo amministratore;
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();
  Campo campo= Campo();
  List<CentroSportivo>centrisportivi=[];
  late CentroSportivo centrosportivo;
  late String _idCentro=centrisportivi[0].nome!;
  late Map<String,String> mapping=new Map();

  @override
  Widget build(BuildContext context) {
    this.amministratore=widget.amministratore;
    this.centrisportivi=amministratore.centrisportivi;
    //centrosportivo=this.centrisportivi[0];
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkBlue,
        title: Text("Registrazione"),
      ),

      body: Form(


          key: _formKey,
          child: Padding(

            padding: EdgeInsets.all(16),
            child: ListView(
              children: <Widget>[
                TextFormField(

                  decoration: InputDecoration(labelText: "Nome campo",
                  focusColor: LightColors.kDarkBlue),
                  onChanged: (value) => campo.nome=value,
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
                              color: LightColors.kLightYellow,
                              child:Padding(
                                padding: EdgeInsets.only(left:12),
                                child:DropdownButtonFormField<Sport>(
                                  hint: Text("Scegli Sport",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: LightColors.kDarkBlue,
                                      fontWeight: FontWeight.w800,
                                    ),),
                                  onChanged: (value){
                                    setState(() {
                                      campo.tipo=SportClass(value!);
                                    });
                                  },
                                  validator: (value){
                                    if(value?.index==null)
                                    {
                                      return "Campo obbligatorio";
                                    }
                                  },
                                  onSaved: (value) => campo.tipo=new SportClass(value!),
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
                ),Row(
                  children: <Widget>[
                    Text("Centro Sprotivo",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: LightColors.kDarkBlue,
                        fontWeight: FontWeight.w800,
                      ),),
                    Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2,
                      child: DropdownButton<String>(
                        hint: Text('Scegli un centro sportivo',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: LightColors.kDarkBlue,
                            fontWeight: FontWeight.w800,
                          ),),
                        value: _idCentro ,
                        onChanged: (value){
                          setState(() {
                            _idCentro=value!;
                          });
                        },
                        items: centrisportivi.map((e) {
                          mapping[e.nome!]=e.id.key!;
                          return DropdownMenuItem<String>(
                              child: new Text(e.nome!),
                              value: e.nome,

                          );

                        }
                        ).toList(),
                      ),
                    )
                  ],
                ),ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        print("Nessun errore");
                        _formKey.currentState?.save();
                        campo.id_centro_sportivo=mapping[_idCentro];
                        saveCampoSportivo(campo);
                        getCentroSportivo(mapping[_idCentro]).then((value) => {
                          centrosportivo=value,
                        centrosportivo.campi.add(campo),
                            centrosportivo.numero_di_campi++,
                            updateCentroSportivo(centrosportivo),
                        //print("${this.amministratore}");
                        //print(centrosportivo);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return MyHomeACS(amministratore:amministratore);
                            }
                        ))
                        });


                      }

                    }
                    , child: Text("Registra centro sportivo",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: LightColors.kDarkBlue,
                    fontWeight: FontWeight.w800,
                  ),)
                )
              ],
            ),
          )
      ),
    );
  }

}

