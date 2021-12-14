import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/Utente.dart';

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _MyCustomFormState extends State<MyCustomForm> {
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
        title: Text("Registrazione"),
      ),

      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                onSaved: (value) => gio.nome=value!,
                validator: (value){
                  if(value?.isEmpty ?? true)
                    {
                      return "Campo Obbligatorio";
                    }
                },
              ),TextFormField(
                decoration: InputDecoration(labelText: "Cognome"),
                onSaved: (value) => gio.cognome=value!,
                validator: (value){
                  if(value?.isEmpty ?? true)
                  {
                    return "Campo Obbligatorio";
                  }
                },
              ),TextFormField(
                decoration: InputDecoration(labelText: "e-mail"),
                onSaved: (value) => gio.email=value!,
                validator: (value){
                  if(value?.isEmpty ?? true)
                  {
                    return "Campo Obbligatorio";
                  }
                },
              ),TextFormField(
                decoration: InputDecoration(labelText: "nome_utente"),
                onSaved: (value) => gio.nome_utente=value!,
                validator: (value){
                  if(value?.isEmpty ?? true)
                  {
                    return "Campo Obbligatorio";
                  }
                },
              ),TextFormField(
                key: _pswKey,
                decoration: InputDecoration(labelText: "password"),
                onSaved: (value) => gio.password=value!,
                obscureText: true,
                validator: (value){
                  if(value?.isEmpty ?? true)
                  {
                    return "Campo Obbligatorio";
                  }
                },
              ),TextFormField(
                decoration: InputDecoration(labelText: "indirizzo"),
                onSaved: (value) => gio.indirizzo=value!,
                validator: (value){
                  if(value?.isEmpty ?? true)
                  {
                    return "Campo Obbligatorio";
                  }
                },
              ),TextFormField(
                decoration: InputDecoration(labelText: "numero di telefono"),
                onSaved: (value) => gio.numero_di_telefono=value!,
                validator: (value){
                  if(value?.isEmpty ?? true)
                  {
                    return "Campo Obbligatorio";
                  }
                },
              ),TextFormField(
                decoration: InputDecoration(labelText: "data di nascita"),
                onSaved: (value) => gio.data_di_nascita=value!,
                validator: (value){
                  if(value?.isEmpty ?? true)
                  {
                    return "Campo Obbligatorio";
                  }
                },
              ),Row(
                children: <Widget>[
                  Text("Sesso"),
                  Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    child: DropdownButtonFormField<Sesso>(
                      value: Sesso.maschio,
                      onChanged: (value){
                        setState(() {
                          gio.sesso=value!;
                        });
                      },
                      onSaved: (value) => gio.sesso=value!,
                      items: [
                        DropdownMenuItem<Sesso>(
                          child: Text("Maschio"),
                          value: Sesso.maschio,
                        ),DropdownMenuItem<Sesso>(
                          child: Text("Femmina"),
                          value: Sesso.femmina,
                        ),DropdownMenuItem<Sesso>(
                          child: Text("altro"),
                          value: Sesso.altro,
                        ),
                      ],
                    ),
                  )
                ],
              ),TextFormField(
                decoration: InputDecoration(labelText: "Nazionalità"),
                onSaved: (value) => gio.nazionalita=value!,
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


                    }
                    saveGiocatore(gio);
                    print("${gio}");
                  }
                  , child: Text("Registra")
              )
            ],
          ),
        )
      ),
    );
  }

}

