import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';


// Create a Form widget.
class MyCustomFormAmministratoreCS extends StatefulWidget {
  const MyCustomFormAmministratoreCS({Key? key}) : super(key: key);

  @override
  _MyCustomFormAmministratoreCSState createState() => _MyCustomFormAmministratoreCSState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _MyCustomFormAmministratoreCSState extends State<MyCustomFormAmministratoreCS> {




  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();
  AmministstratoreCentroSportivo gio = new AmministstratoreCentroSportivo();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkBlue,
        title: Text("Registrazione"),
      ),
      resizeToAvoidBottomInset: false,
      body:
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xffF5F1ED),
                  Color(0xffDAD2BC),
                  Color(0xffA29381),
                ]
            )
        ),
        child:Column(
          children: [
            Container(
                padding: const EdgeInsets.only(top:30, bottom: 30, right: 20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('Registrati', style: TextStyle(color: Colors.white, fontSize: 40),),
                  ],
                )
            ),Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding:EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    hintText: "Nome",
                                    hintStyle: TextStyle(color: Colors.grey)),
                                onChanged: (value) => gio.nome=value,
                                validator: (value){
                                  if(value?.isEmpty ?? true)
                                  {
                                    return "Campo Obbligatorio";
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding:EdgeInsets.only(),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    hintText: "Cognome",
                                    hintStyle: TextStyle(color: Colors.grey)),
                                onChanged: (value) => gio.cognome=value,
                                validator: (value){
                                  if(value?.isEmpty ?? true)
                                  {
                                    return "Campo Obbligatorio";
                                  }
                                },
                              ),
                            ),
                            Padding(
                                padding:EdgeInsets.only(top:10),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                      border: InputBorder.none,
                                      hintText: "e-mail",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  onChanged: (value) => gio.email=value,
                                  validator: (value){
                                    if(value?.isEmpty ?? true)
                                    {
                                      return "Campo Obbligatorio";
                                    }
                                  },
                                )
                            ),
                            Padding(
                                padding:EdgeInsets.only(top:10),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                      border: InputBorder.none,
                                      hintText: "Nome Utente",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                  onChanged: (value) => gio.nome_utente=value,
                                  validator: (value){
                                    if(value?.isEmpty ?? true)
                                    {
                                      return "Campo Obbligatorio";
                                    }
                                  },
                                )
                            ),
                            Padding(
                              padding:EdgeInsets.only(top:10),
                              child: TextFormField(
                                key: _pswKey,
                                decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey)),
                                onChanged: (value) => gio.password=value,
                                obscureText: true,
                                validator: (value){
                                  if(value?.isEmpty ?? true)
                                  {
                                    return "Campo Obbligatorio";
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding:EdgeInsets.only(top:10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    hintText: "Numero di telefono",
                                    hintStyle: TextStyle(color: Colors.grey)),
                                onChanged: (value) => gio.numero_di_telefono=value,
                                validator: (value){
                                  if(value?.isEmpty ?? true)
                                  {
                                    return "Campo Obbligatorio";
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding:EdgeInsets.only(top:10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none,
                                    hintText: "Data di nascita",
                                    hintStyle: TextStyle(color: Colors.grey)),
                                onChanged: (value) => gio.data_di_nascita=value,
                                validator: (value){
                                  if(value?.isEmpty ?? true)
                                  {
                                    return "Campo Obbligatorio";
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding:EdgeInsets.only(top:10),
                              child: Row(
                                children: <Widget>[
                                  Padding(padding:EdgeInsets.only(),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width-78,
                                        child:Container(
                                          child:Padding(
                                            padding: EdgeInsets.only(left:12),
                                            child:DropdownButtonFormField<Sesso>(
                                              hint: Text("Scegli Sesso"),
                                              onChanged: (value){
                                                setState(() {
                                                  gio.sesso=value!;
                                                });
                                              },
                                              validator: (value){
                                                if(value?.index==null)
                                                {
                                                  return "Campo obbligatorio";
                                                }
                                              },
                                              onSaved: (value) => gio.sesso=value!,
                                              items: [
                                                DropdownMenuItem<Sesso>(
                                                  child: Text("Maschio",style: TextStyle(color:LightColors.kDarkBlue),),
                                                  value: Sesso.maschio,
                                                ),DropdownMenuItem<Sesso>(
                                                  child: Text("Femmina",style: TextStyle(color:LightColors.kDarkBlue),),
                                                  value: Sesso.femmina,
                                                ),DropdownMenuItem<Sesso>(
                                                  child: Text("Altro",style: TextStyle(color:LightColors.kDarkBlue),),
                                                  value: Sesso.altro,
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
                            Center(
                              child: Padding(
                                  padding:EdgeInsets.only(top:10),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: LightColors.kLightYellow,),
                                      onPressed: (){
                                        if(_formKey.currentState!.validate()){
                                          print("Nessun errore");
                                          _formKey.currentState?.save();
                                          saveAmministratoreCS(gio);
                                          print("${gio}");
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: const Text('Registrazione Effettuata'),
                                              backgroundColor: LightColors.kGreen,
                                              action: SnackBarAction(textColor:LightColors.kLightYellow,
                                                label: 'OK', onPressed: () {},),
                                            ),
                                          );
                                          Timer(Duration(seconds: 2), ()
                                          {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context){
                                                  return MyHomeACS(amministratore:gio);
                                                }
                                            ));
                                          });
                                        }

                                      }
                                      , child: Text("Registra",style: TextStyle(
                                    color:LightColors.kDarkBlue,
                                  ),
                                  )
                                  )
                              ),
                            ),
                          ],
                        ),
                      )
                  ),



                )




            ),
          ],

        ),


      ),



    );
  }

}

