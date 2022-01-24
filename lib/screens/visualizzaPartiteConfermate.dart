import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/screens/visualizzaInfoRichiestaPartita.dart';

import 'home.dart';



// Create a Form widget.
class VisualizzaPartiteConfermate extends StatefulWidget {
  Giocatore giocatore;
  //CentroSportivo centroSportivo;
  VisualizzaPartiteConfermate({required this.giocatore, Key? key}) : super(key: key);
  @override
  _VisualizzaPartiteConfermateState createState() => _VisualizzaPartiteConfermateState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _VisualizzaPartiteConfermateState extends State<VisualizzaPartiteConfermate> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();


  bool late=false;
  RichiestaNuovaPartita richiestaNuovaPartita = RichiestaNuovaPartita();



  late Map<String,String> mapping=new Map();

  @override
  Widget build(BuildContext context) {
    //this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.



    Giocatore giocatore=widget.giocatore;
    if(giocatore.partiteconfermate== null)
        giocatore.partiteconfermate=[];
    return Scaffold(
        appBar: AppBar(
          title: Text("Partite confermate"),
        ),

        body: ListView.builder(

            itemCount: giocatore.partiteconfermate!.length,
            itemBuilder: (context,index){
              return Card(
                child: ListTile(
                  leading:Icon(Icons.assignment_outlined, color: Colors.black, size: 50.0,),
                  /*onTap:()  =>

                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              VisPartitaConfermata(partitaconfermata: partite[index],)

                      ))*/

                  title: Text(giocatore.partiteconfermate![index].data),
                  subtitle: Column(
                    children: [
                      Text('Numero di partecipanti:'+giocatore.partiteconfermate![index].numero_di_partecipanti.toString()),
                      Text('Sport:'+giocatore.partiteconfermate![index].sport.toString().split(".").last),
                    ],
                  ),
                ),
              );
            }
        )
    );
  }

}

