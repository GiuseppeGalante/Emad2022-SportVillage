import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/PartitaConfermata.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/screens/infoGiocatore.dart';
import 'package:flutter_app_emad/screens/visualizzaInfoRichiestaPartita.dart';

import 'home.dart';



// Create a Form widget.
class VisPartitaConfermata extends StatefulWidget {
  PartitaConfermata partitaconfermata;
  bool find=true;
  List<PartitaConfermata> partite=[];
  Giocatore giocatore;
  late List<Giocatore?> giocatori;
  //CentroSportivo centroSportivo;
  VisPartitaConfermata({required this.partitaconfermata, required this.giocatore, Key? key}) : super(key: key);
  @override
  _VisPartitaConfermataState createState() => _VisPartitaConfermataState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _VisPartitaConfermataState extends State<VisPartitaConfermata> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();


  bool late=false;
  RichiestaNuovaPartita richiestaNuovaPartita = RichiestaNuovaPartita();

  List<Giocatore?> giocatori=[];


  late Map<String,String> mapping=new Map();
  bool complete=true;

  @override
  Widget build(BuildContext context) {
    //this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.
    Giocatore giocatore=widget.giocatore;
    PartitaConfermata partitaconfermata=widget.partitaconfermata;
    if(partitaconfermata.partecipanti_trasf == null)
      partitaconfermata.partecipanti_trasf=[];
    List<Giocatore?> casa=[];
    List<Giocatore?> trasf=[];

    showAlertDialogHome(BuildContext context) {
      showDialog(
        context: context,
        builder:  (BuildContext ctx) {
          return AlertDialog(
            title: Text("Aggiungiti al match"),
            content: Text("Vuoi aggiungerti al match?"),
            actions: [
                    TextButton(
                      child: Text("No"),
                      onPressed:  () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                    TextButton(
                      child: Text("Si"),
                      onPressed:  () {
                        setState(() {
                          widget.partitaconfermata.partecipanti.add(giocatore.id.key!);
                          Navigator.of(ctx).pop();
                        });
                      },
                    )
            ],

          );
        }
      );

    }

    showAlertDialogTrasf(BuildContext context) {
      showDialog(
          context: context,
          builder:  (BuildContext ctx) {
            return AlertDialog(
              title: Text("Aggiungiti al match"),
              content: Text("Vuoi aggiungerti al match?"),
              actions: [
                TextButton(
                  child: Text("No"),
                  onPressed:  () {
                    Navigator.of(ctx).pop();
                  },
                ),
                TextButton(
                  child: Text("Si"),
                  onPressed:  () {
                    setState(() {
                      widget.partitaconfermata.partecipanti_trasf.add(giocatore.id.key!);
                      Navigator.of(ctx).pop();
                    });
                  },
                )
              ],

            );
          }
      );

    }

    if(complete)
      {
        getGiocatori().then((value) => {giocatori=value,
          setState((){giocatori=value;complete=false;
          })
        });
      }

    if(!complete)
      {

        for(int i=0;i<partitaconfermata.numero_di_partecipanti/2;i++)
        {
          if(i >= partitaconfermata.partecipanti.length )
          {
            Giocatore gio=new Giocatore();
            gio.nome="Posto Libero";
            gio.bio=null;
            casa.add(gio);
          }
          else
          {
            for(int k =0;k<giocatori.length;k++)
            {
              print(k);
              print("Giocatore:"+giocatori[k]!.id.key.toString());
              if(partitaconfermata.partecipanti[i] == giocatori[k]?.id.key)
                casa.add(giocatori[k]);

            }
          }

          if(i >= partitaconfermata.partecipanti_trasf.length)
          {
            Giocatore gio=new Giocatore();
            gio.nome="Posto Libero";
            gio.bio=null;
            trasf.add(gio);
          }
          else
          {
            for(int k =0;k<giocatori.length;k++)
            {
              if(partitaconfermata.partecipanti_trasf[i] == giocatori[k]?.id.key)
                trasf.add(giocatori[k]);

            }
          }
        }
      }


    return Scaffold(
        appBar: AppBar(
          title: Text("Info Partita Confermata"),
        ),

        body: Column(
          children: <Widget>[

              Text(partitaconfermata.data),
              Text(partitaconfermata.orario),
            Text(partitaconfermata.sport.sport.toString()),
            Row(
              children: [
                Expanded(
                    child:SizedBox(
                      height: 200.0,
                      child:  ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:casa.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                    if(casa[index]!.bio == null)
                                      {

                                          return showAlertDialogHome(context);

                                      }
                                    else
                                      {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                VisInfoGiocatore(giocatore: casa[index]!,)

                                        ));
                                      }
                              },
                              child: Card(

                                    child: Text(casa[index]!.nome) ,
                                  )
                              ,
                            );

                          }

                      ),
                    )


                ),
                Expanded(
                    child:SizedBox(
                      height: 200.0,
                      child:  ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:trasf.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                if(trasf[index]!.bio == null)
                                {

                                  return showAlertDialogTrasf(context);

                                }
                                else
                                {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          VisInfoGiocatore(giocatore: trasf[index]!,)

                                  ));
                                }
                              },
                              child: Card(

                                child: Text(trasf[index]!.nome) ,
                              )
                              ,
                            );

                          }

                      ),
                    )


                ),
              ],
            ),


            Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                  Column(
                    children:<Widget> [
                      //Text("Team 1"),


                    ],
                  ),

                //Text("Team 2"),
              ],
            )
          ],
        )
    );
  }
}





