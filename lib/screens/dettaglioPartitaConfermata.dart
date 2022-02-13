import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
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
import 'package:google_fonts/google_fonts.dart';

import '../widgets/signupContainer.dart';
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

  int selectedTool = -1;
  int selectedTool_trasf=-1;

  List<dynamic> tools = [
      {
  'image': 'https://cdn-icons-png.flaticon.com/128/732/732244.png',
  'selected_image': 'https://img.icons8.com/color/344/circled-user-male-skin-type-5--v2.gif',
  'name': 'Sketch',
  'description': 'The digital design platform.',
},];

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
              //print(k);
              //print("Giocatore:"+giocatori[k]!.id.key.toString());
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
        body:SizedBox(
          width: 1500,
          height: 2500,
          child: Stack(
            children: [
              Positioned(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 1,
                  child: SignUpContainer()),
              Container(
                height: 900,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50,),
                    FadeInDown(
                      from: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dettaglio Partita", style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    FadeInDown(
                        from: 50,
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FadeInUp(
                              delay: Duration(milliseconds: 1000),
                              duration: Duration(milliseconds: 1000),
                              child: Text(partitaconfermata.data.toString(), style: GoogleFonts.robotoSlab(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                              ),),
                            ),
                            FadeInUp(
                              delay: Duration(milliseconds: 1000),
                              duration: Duration(milliseconds: 1000),
                              child: Text(partitaconfermata.orario.toString(), style: GoogleFonts.robotoSlab(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                              ),),
                            ),
                            FadeInUp(
                              delay: Duration(milliseconds: 1000),
                              duration: Duration(milliseconds: 1000),
                              child: Text("SPORT:"+partitaconfermata.sport.sport.toString().split(".").last.toUpperCase(), style: GoogleFonts.robotoSlab(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                              ),),
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: 20,),
                    Container(
                        height: 550,
                        child:
                        Row(
                          children: [
                            Container(
                              //margin: const EdgeInsets.only(left: 30.0),
                              height: 800,
                              width: 150,
                              child: ListView.builder(
                                itemCount: casa.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTool = index;
                                        selectedTool_trasf=-1;
                                      });
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
                                    child: FadeInUp(
                                      delay: Duration(milliseconds: index * 100),
                                      child: AnimatedContainer(
                                        height: 80,
                                        width: 15,
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                                        margin: EdgeInsets.only(bottom: 20),
                                        duration: Duration(milliseconds: 1500),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                                color: selectedTool == index ? Colors.blue : Colors.white.withOpacity(0),
                                                width: 2
                                            ),
                                            boxShadow: [
                                              selectedTool == index ?
                                              BoxShadow(
                                                  color: Colors.blue.shade100,
                                                  offset: Offset(0, 3),
                                                  blurRadius: 10
                                              ) : BoxShadow(
                                                  color: Colors.grey.shade200,
                                                  offset: Offset(0, 3),
                                                  blurRadius: 10
                                              )
                                            ]
                                        ),
                                        child: Row(
                                          children: [
                                            Image.network(tools[0]['selected_image'], width: 30,),
                                            SizedBox(width: 20,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(casa[index]!.nome, style: TextStyle(
                                                      color: Colors.grey.shade800,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  Text(casa[index]!.cognome, style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontSize: 14,
                                                  ),)
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.check_circle, color: selectedTool == index ? Colors.blue : Colors.white,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 30.0),
                              height: 800,
                              width: 150,
                              child: ListView.builder(
                                itemCount: trasf.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTool_trasf = index;
                                        selectedTool=-1;
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
                                      });
                                    },
                                    child: FadeInUp(
                                      delay: Duration(milliseconds: index * 100),
                                      child: AnimatedContainer(
                                        height: 80,
                                        width: 15,
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                        margin: EdgeInsets.only(bottom: 20),
                                        duration: Duration(milliseconds: 1500),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                                color: selectedTool_trasf == index ? Colors.blue : Colors.white.withOpacity(0),
                                                width: 2
                                            ),
                                            boxShadow: [
                                              selectedTool_trasf == index ?
                                              BoxShadow(
                                                  color: Colors.blue.shade100,
                                                  offset: Offset(0, 3),
                                                  blurRadius: 10
                                              ) : BoxShadow(
                                                  color: Colors.grey.shade200,
                                                  offset: Offset(0, 3),
                                                  blurRadius: 10
                                              )
                                            ]
                                        ),
                                        child: Row(
                                          children: [
                                            Image.network(tools[0]['selected_image'], width: 30,),
                                            SizedBox(width: 20,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(trasf[index]!.nome, style: TextStyle(
                                                      color: Colors.grey.shade800,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  Text(trasf[index]!.cognome, style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontSize: 14,
                                                  ),)
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.check_circle, color: selectedTool_trasf == index ? Colors.blue : Colors.white,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )

                    )
                  ],
                ),
              ),
            ],
          )


        )


    );
  }
}





