import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';

import 'home.dart';

// Create a Form widget.
class MyCustomFormGiocatore extends StatefulWidget {
  const MyCustomFormGiocatore({Key? key}) : super(key: key);

  @override
  _MyCustomFormGiocatoreState createState() => _MyCustomFormGiocatoreState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _MyCustomFormGiocatoreState extends State<MyCustomFormGiocatore> {


  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();
  Giocatore gio = Giocatore();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.kDarkBlue,
        title: Text("Registrazione"),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
      children:[
        Container(
        color: LightColors.kLightYellow,
      ),
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
                  labelText: "Nome",
                  icon: Icon(Icons.person, color: LightColors.kDarkBlue, size: 30.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
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
            padding:EdgeInsets.only(top:10,left:46),
            child: TextFormField(
                decoration: InputDecoration(labelText: "Cognome",
                  filled: true,
                  fillColor: LightColors.kBlue,
                ),
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
                decoration: InputDecoration(labelText: "e-mail",
                  icon: Icon(Icons.alternate_email,
                    color:LightColors.kBlue,
                    size: 30.0,),
                  filled: true,
                  fillColor: LightColors.kDarkBlue,
                ),
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
                decoration: InputDecoration(labelText: "nome_utente",
                  icon: Icon(Icons.account_box,
                    color: LightColors.kBlue,
                    size: 30.0,),
                  filled: true,
                  fillColor: LightColors.kDarkBlue,
                ),
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
                decoration: InputDecoration(labelText: "password",
                  icon: Icon(Icons.password,
                    color: LightColors.kBlue,
                    size: 30.0,),
                  filled: true,
                  fillColor: LightColors.kDarkBlue,
                ),
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
                decoration: InputDecoration(labelText: "indirizzo",
                  icon: Icon(Icons.home,
                    color: LightColors.kBlue,
                    size: 30.0,),
                  filled: true,
                  fillColor: LightColors.kDarkBlue,),
                onChanged: (value) => gio.indirizzo=value,
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
                decoration: InputDecoration(labelText: "numero di telefono",
                  icon: Icon(Icons.phone_iphone,
                    color: LightColors.kBlue,
                    size: 30.0,),
                  filled: true,
                  fillColor: LightColors.kDarkBlue,
                ),
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
                decoration: InputDecoration(labelText: "data di nascita",
                  icon: Icon(Icons.calendar_today,
                    color: LightColors.kBlue,
                    size: 30.0,),
                  filled: true,
                  fillColor: LightColors.kDarkBlue,
                ),
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
                  Padding(padding:EdgeInsets.only(left:46),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width-78,
                    child:Container(
                      color: LightColors.kLightYellow,
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
          Padding(
            padding:EdgeInsets.only(top:10),
            child: TextFormField(
                decoration: InputDecoration(labelText: "Nazionalità",
                  icon: Icon(Icons.flag,
                    color: LightColors.kBlue,
                    size: 30.0,),
                  filled: true,
                  fillColor: LightColors.kDarkBlue,
                ),
                onChanged: (value) => gio.nazionalita=value,
                validator: (value){
                  if(value?.isEmpty ?? true)
                  {
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
                    primary: LightColors.kLightYellow,),
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      print("Nessun errore");
                      _formKey.currentState?.save();
                      saveGiocatore(gio);
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
                                  return MyHomeGio(giocatore:gio);
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
      ]
      ),
    );
  }

}

