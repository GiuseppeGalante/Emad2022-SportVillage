import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/PartitaConfermata.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/ProfiloGiocatore.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/screens/infoGiocatore.dart';
import 'package:flutter_app_emad/screens/visualizzaInfoRichiestaPartita.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';

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
  bool disable=false;

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
            title: Text("Aggiungiti al match",
              style: TextStyle(
                fontSize: 15.0,
                color: LightColors.kDarkBlue,
                fontWeight: FontWeight.w800,
              ),),
            content: Text("Vuoi aggiungerti al match?",style: TextStyle(
              fontSize: 15.0,
              color: LightColors.kDarkBlue,
              fontWeight: FontWeight.w800,
            ),),
            actions: [
                    TextButton(
                      child: Text("No",style: TextStyle(
                        fontSize: 15.0,
                        color: LightColors.kDarkBlue,
                        fontWeight: FontWeight.w800,
                      ),),
                      onPressed:  () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                    TextButton(
                      child: Text("Si",style: TextStyle(
                        fontSize: 15.0,
                        color: LightColors.kDarkBlue,
                        fontWeight: FontWeight.w800,
                      ),),
                      onPressed:  () {
                        setState(() {
                          widget.partitaconfermata.partecipanti.add(giocatore.id.key!);
                          updatePartitaConfermata(widget.partitaconfermata);
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
              title: Text("Aggiungiti al match",style: TextStyle(
                fontSize: 15.0,
                color: LightColors.kDarkBlue,
                fontWeight: FontWeight.w800,
              ),),
              content: Text("Vuoi aggiungerti al match?",style: TextStyle(
                fontSize: 15.0,
                color: LightColors.kDarkBlue,
                fontWeight: FontWeight.w800,
              ),),
              actions: [
                TextButton(
                  child: Text("No",style: TextStyle(
                    fontSize: 15.0,
                    color: LightColors.kDarkBlue,
                    fontWeight: FontWeight.w800,
                  ),),
                  onPressed:  () {
                    Navigator.of(ctx).pop();
                  },
                ),
                TextButton(
                  child: Text("Si",style: TextStyle(
                    fontSize: 15.0,
                    color: LightColors.kDarkBlue,
                    fontWeight: FontWeight.w800,
                  ),),
                  onPressed:  () {
                    setState(() {
                      widget.partitaconfermata.partecipanti_trasf.add(giocatore.id.key!);
                      updatePartitaConfermata(widget.partitaconfermata);
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
              if(partitaconfermata.partecipanti[i] == giocatori[k]?.id.key) {
                casa.add(giocatori[k]);
                if(giocatori[k]?.nome == giocatore.nome)
                  disable=true;
              }

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
                {
                  trasf.add(giocatori[k]);
                  if(giocatori[k]?.nome == giocatore.nome)
                    disable=true;
                }


            }
          }
        }
      }


    return Scaffold(
        appBar: AppBar(
          backgroundColor: LightColors.kDarkBlue,
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

                                   if(casa[index]!.bio == null && !disable)
                                      {

                                          return showAlertDialogHome(context);

                                      }
                                   else if(casa[index]!.bio != null)
                                      {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                ProfiloGio(giocatore: casa[index]!, title: 'Info Giocatore',)

                                        ));
                                      }
                              },
                              child: Card(
                                color: LightColors.kLightYellow,

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
                                if(trasf[index]!.bio == null && !disable)
                                {

                                  return showAlertDialogTrasf(context);

                                }
                                else if(trasf[index]!.bio != null)
                                {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          VisInfoGiocatore(giocatore: trasf[index]!,)

                                  ));
                                }
                              },
                              child: Card(

                                child: Text(trasf[index]!.nome) ,
                                color: LightColors.kLightYellow,
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





