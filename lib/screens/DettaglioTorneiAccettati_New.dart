import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/animation/FadeAnimation.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/PartitaConfermata.dart';
import 'package:flutter_app_emad/entity/Squadre.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';
import 'package:flutter_app_emad/screens/DettaglioTorneiAccettati.dart';
import 'package:flutter_app_emad/screens/dettaglioPartitaConfermata.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';
import 'package:flutter_app_emad/widgets/signupContainer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class DettaglioTorneiAccettati_New extends StatefulWidget {
  TorneoAccettato torneo;
  Giocatore giocatore;
  List<Squadra> squadre;
  DettaglioTorneiAccettati_New({required this.torneo,required this.giocatore, required this.squadre, Key? key}) : super(key: key);

  @override
  _DettaglioTorneiAccettati_New createState() => _DettaglioTorneiAccettati_New();
}

class _DettaglioTorneiAccettati_New extends State<DettaglioTorneiAccettati_New> {

  List<dynamic> tools=[];
  late List<TorneoAccettato> partite;
  bool find=true;
  bool letto=false;

  // Rooms to clean
  int selectedTool = -1;
  int _selectedRooms = -1;

  @override
  Widget build(BuildContext context) {
    Giocatore giocatore = widget.giocatore;
    TorneoAccettato torneo = widget.torneo;
    List<Squadra> squadre=widget.squadre;
    String prenotazione="";
    for(int i=0;i<torneo.numero_di_partecipanti;i++)
      {
        if(squadre[i].partecipanti<squadre[i].max_partecipanti)
          {
            prenotazione="Prenotazioni Aperte";
          }
        else
          {
            prenotazione="Prenotazioni Chiuse";
          }
        tools.add(
            {
              'image': 'https://img.icons8.com/office/344/medal2--v2.gif',
              'data': "Nome: " + squadre[i].nome,
              'partecipanti': prenotazione,
            }
        );
      }


    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: _selectedRooms >= 0 ? FloatingActionButton(
          onPressed: () async{
            /*squadre=await getSquadre(partite[_selectedRooms].id_torneo);
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    DettaglioTorneoAccettato(
                        torneo: partite[_selectedRooms],
                        giocatore: giocatore,
                        squadre: squadre)

            ));*/
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 2),
              Icon(Icons.arrow_forward_ios, size: 18,),
            ],
          ),
          backgroundColor: Colors.blue,
        ) : null,



        body:
        SizedBox(
            height: 1500,
            child: Stack(
                children: [
                  Positioned(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 1,
                      child: SignUpContainer()),
                  NestedScrollView(
                          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              SliverToBoxAdapter(
                                  child: FadeAnimation(1, Padding(
                                    padding: EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
                                    child: Text(
                                      'Squadre di '+torneo.nome,
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.grey.shade900,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ))
                            ];
                          },
                          body:
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: tools.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return FadeAnimation((1.2 + index) / 4, room(tools[index], index,squadre[index]));

                                }
                            ),
                          ),
                        ),
                ]
        )
        )
    );
  }

  room(Map<String,String> room, int index,Squadra squadra) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedRooms==index) {
            _selectedRooms = -1;
          }
          else
            _selectedRooms=index;
        });
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          margin: EdgeInsets.only(bottom: 20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: _selectedRooms==index ? Colors.blue : Colors.white.withOpacity(0),
                  width: 2
              ),
              color: _selectedRooms==index? Colors.blue.shade50.withOpacity(0.5) : Colors.white//Colors.grey.shade100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    children: [

                      SizedBox(
                        width: MediaQuery.of(context).size.width-85,
                        height: 70,
                        child:
                        Row(
                          children: [
                            Image.network(tools[index]['image'], width: 50,),
                            SizedBox(width: 20,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(tools[index]['data'], style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(height: 15,),
                                  DefaultTextStyle(
                                      style: TextStyle(
                                        color:
                                            (){
                                          if(squadra.partecipanti<squadra.max_partecipanti)
                                          {
                                            return Colors.green;
                                          }
                                          else
                                          {
                                            return Colors.red;
                                          }
                                        }(),
                                        //color: Colors.grey.shade600,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      child: AnimatedTextKit(
                                        pause: Duration(milliseconds: 10),
                                        repeatForever: true,
                                        animatedTexts: [
                                          ScaleAnimatedText(tools[index]['partecipanti']),
                                          ScaleAnimatedText(tools[index]['partecipanti']),
                                        ],
                                        onTap: () {
                                          print("Tap Event");
                                        },
                                      ),)
                                  //Text(tools[index]['partecipanti'], ,),

                                ],
                              ),
                            ),
                          ],
                        ),

                      )
                    ],
                  ),
                  SizedBox()
                ],
              ),
              SizedBox()
            ],
          )
      ),
    );
  }
}