import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';

import 'home.dart';



// Create a Form widget.
class InfoCentroSportivo extends StatefulWidget {
  AmministstratoreCentroSportivo amministratore;
  //CentroSportivo centroSportivo;
  List<CentroSportivo>centrosportivo=[];
  InfoCentroSportivo({required this.amministratore, required this.centrosportivo, Key? key}) : super(key: key);
  @override
  _InfoCentroSportivoState createState() => _InfoCentroSportivoState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _InfoCentroSportivoState extends State<InfoCentroSportivo> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();


  bool late=false;




  late Map<String,String> mapping=new Map();

  @override
  Widget build(BuildContext context) {
    //this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.



    AmministstratoreCentroSportivo amministratore=widget.amministratore;
    List<CentroSportivo>centrosportivo=widget.centrosportivo;
    print(centrosportivo);
    return Scaffold(
        appBar: AppBar(
          title: Text("Info Centro Sportivo"),
        ),

        body: ListView.builder(
            itemCount: centrosportivo.length,
            itemBuilder: (context,index){
              return Card(
                child: ListTile(

                  title: Text(centrosportivo[index].toString()),
                ),
              );
            }
        )
    );
  }

}

