import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/animation/FadeAnimation.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/PartitaConfermata.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/screens/dettaglioPartitaConfermata.dart';
import 'package:flutter_app_emad/screens/visualizzaInfoRichiestaPartita.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';
import 'package:flutter_app_emad/widgets/signupContainer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;


class VisualizzaRichiestePartita_New extends StatefulWidget {
  AmministstratoreCentroSportivo amministratore;
  //CentroSportivo centroSportivo;
  List<RichiestaNuovaPartita>richiestepartite=[];
  VisualizzaRichiestePartita_New({required this.amministratore, required this.richiestepartite, Key? key}) : super(key: key);
  @override
  _VisualizzaRichiestePartitaState_New createState() => _VisualizzaRichiestePartitaState_New();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _VisualizzaRichiestePartitaState_New extends State<VisualizzaRichiestePartita_New> {

  List<dynamic> tools=[];
  bool late=false;
  RichiestaNuovaPartita richiestaNuovaPartita = RichiestaNuovaPartita();
  int selectedTool = -1;
  int _selectedRooms = -1;


  late Map<String,String> mapping=new Map();
  List<RichiestaNuovaPartita>richiestepartite=[];
  AmministstratoreCentroSportivo amministratore=new AmministstratoreCentroSportivo();
  @override
  Widget build(BuildContext context) {
    amministratore = widget.amministratore;
    richiestepartite = widget.richiestepartite;
    for (int i = 0; i < richiestepartite!.length; i++) {
      tools.add(
          {
            //'image': 'https://img.icons8.com/office/344/medal2--v2.gif',
            'image': 'https://i.ibb.co/ydMD7d9/output-onlinegiftools-4.gif',
            'data': "Data: " + richiestepartite[i].data,
            'partecipanti': "Partecipanti: " +
                richiestepartite[i].numero_di_partecipanti.toString(),
            'sport': 'Sport: ' + richiestepartite[i].sport.sport
                .toString()
                .split(".")
                .last,
          }
      );
    }
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: _selectedRooms >= 0 ? FloatingActionButton(
          onPressed: () {

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
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled)
    {
      return <Widget>[
        SliverToBoxAdapter(
            child: FadeAnimation(1, Padding(
              padding: EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
              child: Text(
                'Richieste partite',
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
                    return FadeAnimation((1.2 + index) / 4, room(tools[index], index));

                    }
                 ),
             ),
          ),
        ])
        )
       );
      }
  room(Map<String,String> room, int index) {
    return GestureDetector(
      onTap: () {
        getCentroSportivo(richiestepartite[index].id_centro_sportivo).then((value) async =>
        {
          await Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                  FormInfoRichiestaNuovaPartita(
                      richiestanuovapartita: richiestepartite[index],
                      centrosportivo: value,
                      amministratore: amministratore)

          )),
          setState((){getRichiestePartite(acs:amministratore).then((value) =>{ setState((){widget.richiestepartite=value;})});})
        }
        );

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
                        height: 80,
                        child: Row(
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
                                  Text(tools[index]['partecipanti'], style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),),
                                  Text(tools[index]['sport'], style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),),
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
