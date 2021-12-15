import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Campo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';



//TODO: passare il riferimento amministratore anzichè centro sportivo.
// Create a Form widget.
class FormCampo extends StatefulWidget {
  CentroSportivo centrosportivo;
  FormCampo({required this.centrosportivo,Key? key}) : super(key: key);
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
  late CentroSportivo centrosportivo;
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();
  Campo campo= Campo();

  @override
  Widget build(BuildContext context) {
    this.centrosportivo=widget.centrosportivo;
    // Build a Form widget using the _formKey created above.
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
                  decoration: InputDecoration(labelText: "Nome campo"),
                  onChanged: (value) => campo.nome=value,
                  validator: (value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Campo Obbligatorio";
                    }
                  },
                ),TextFormField(
                  decoration: InputDecoration(labelText: "Tipo"),
                  onChanged: (value) => campo.tipo=value,
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
                        campo.id_centro_sportivo=centrosportivo.id.key;
                        saveCampoSportivo(campo);
                        centrosportivo.campi.add(campo);
                        updateCentroSportivo(centrosportivo);
                        //print("${this.amministratore}");
                        print(centrosportivo);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              //return MyHomeACS(amministratore:amministratore);
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

