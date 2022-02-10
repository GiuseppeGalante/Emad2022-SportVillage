import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';




// Create a Form widget.
class FormCentroSportivo extends StatefulWidget {
  AmministstratoreCentroSportivo amministratore;
  FormCentroSportivo({required this.amministratore,Key? key}) : super(key: key);
  @override
  _FormCentroSportivoState createState() => _FormCentroSportivoState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _FormCentroSportivoState extends State<FormCentroSportivo> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  late AmministstratoreCentroSportivo amministratore;
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();
  CentroSportivo centrosportivo = CentroSportivo();

  @override
  Widget build(BuildContext context) {
    this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      backgroundColor: LightColors.kDarkBlue,
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
                  decoration: InputDecoration(labelText: "Nome centro sportivo",),
                  onChanged: (value) => centrosportivo.nome=value,
                  validator: (value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Campo Obbligatorio";
                    }
                  },
                ),TextFormField(
                  decoration: InputDecoration(labelText: "Ragione sociale"),
                  onChanged: (value) => centrosportivo.ragione_sociale=value,
                  validator: (value){
                    if(value?.isEmpty ?? true)
                    {
                      return "Campo Obbligatorio";
                    }
                  },
                ),TextFormField(
                  decoration: InputDecoration(labelText: "Indirizzo"),
                  onChanged: (value) => centrosportivo.indirizzo=value,
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
                        centrosportivo.id_amministratore=amministratore.id.key;
                        saveCentroSportivo(centrosportivo);
                        amministratore.centrisportivi.add(centrosportivo);
                        updateAmministratoreCS(amministratore);
                        //print("${this.amministratore}");
                        //print(centrosportivo);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return MyHomeACS(amministratore:amministratore);
                            }
                        ));

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

