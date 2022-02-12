import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_emad/animation/FadeAnimation.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/PartitaConfermata.dart';
import 'package:flutter_app_emad/screens/dettaglioPartitaConfermata.dart';
import 'package:flutter_app_emad/widgets/signupContainer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class VisualizzaPartiteConfermate_New extends StatefulWidget {
  Giocatore giocatore;
  VisualizzaPartiteConfermate_New({required this.giocatore, Key? key}) : super(key: key);

  @override
  _VisualizzaPartiteConfermate_New createState() => _VisualizzaPartiteConfermate_New();
}

class _VisualizzaPartiteConfermate_New extends State<VisualizzaPartiteConfermate_New> {

  List<dynamic> tools=[];
  late List<PartitaConfermata> partite;

  Future<List<dynamic>> getDistancePartite() async
  {
    Giocatore giocatore=widget.giocatore;
    List<PartitaConfermata>? partiteconfermate= giocatore.partiteconfermate;
    try{



      Position posizione= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      for(int i=0;i<partiteconfermate!.length;i++)
      {


        if(partiteconfermate[i].indirizzo != "")
        {
          /*
        try{

          http.Response response = await http.get(Uri.parse("https://atlas.microsoft.com/route/directions/json?subscription-key=noX2Gr6mqcV3NOG1OL7qwih3u2ZNsmYC19X6RbHKmCs&api-version=1.0&query=52.50931,13.42936:52.50274,13.43872"));
          print(jsonDecode(response.body)["routes"][0]["summary"]["lengthInMeters"]);
        }
        catch (error)
        {
          //print(partiteconfermate[i].indirizzo);
          print(error);
        }*/

          http.Response response= await http.get(Uri.parse('https://atlas.microsoft.com/search/address/json?&limit=1&subscription-key=noX2Gr6mqcV3NOG1OL7qwih3u2ZNsmYC19X6RbHKmCs&api-version=1.0&language=it&query='+partiteconfermate[i].indirizzo));
          //print(jsonDecode(response.body)["results"][0]["position"]["lat"]);
          double lat=jsonDecode(response.body)["results"][0]["position"]["lat"];
          double long=jsonDecode(response.body)["results"][0]["position"]["lon"];
          //List<Address> locations = await Geocoder.local.findAddressesFromQuery(partiteconfermate[i].indirizzo);
          //print(locations.first);
          print(lat);
          print(long);
          if(!lat.isNaN && !long.isNaN)
          {
            http.Response response = await http.get(Uri.parse("https://atlas.microsoft.com/route/directions/json?subscription-key=noX2Gr6mqcV3NOG1OL7qwih3u2ZNsmYC19X6RbHKmCs&api-version=1.0&query="+posizione.latitude.toString()+","+posizione.longitude.toString()+":"+lat.toString()+","+long.toString()));
            //print(jsonDecode(response.body)["routes"][0]["summary"]["lengthInMeters"]);
            //partiteconfermate[i].distanza= await Geolocator.distanceBetween(posizione.latitude, posizione.longitude, lat, long)/1000;
            partiteconfermate[i].distanza= jsonDecode(response.body)["routes"][0]["summary"]["lengthInMeters"]/1000;
            partiteconfermate[i].distanza=num.parse(partiteconfermate[i].distanza.toStringAsFixed(2)).toDouble();
          }

        }

      }
      partiteconfermate.sort((a, b) => a.distanza.compareTo(b.distanza));
    }
    catch (error)
    {
      //print(partiteconfermate[i].indirizzo);
      print(error);
    }

    for(int i=0;i<partiteconfermate!.length;i++)
      {
        tools.add(
            {
              'image': 'https://img.icons8.com/office/344/medal2--v2.gif',
              'data': "Data: "+partiteconfermate[i].data,
              'partecipanti': "Partecipanti: "+partiteconfermate[i].numero_di_partecipanti.toString(),
              'sport': 'Sport: '+partiteconfermate[i].sport.sport.toString().split(".").last,
              'distanza': 'Distanza: '+partiteconfermate[i].distanza.toString()+" km",
            }
        );
      }
    return partiteconfermate;
  }




  // Rooms to clean
  int selectedTool = -1;
  int _selectedRooms = -1;

  @override
  Widget build(BuildContext context) {
    Giocatore giocatore=widget.giocatore;

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: _selectedRooms >= 0 ? FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VisPartitaConfermata(partitaconfermata: partite[_selectedRooms],giocatore: giocatore,)
              ),
            );
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
        FutureBuilder(
        future: Future.wait([getDistancePartite()]),
    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
            // while data is loading:
             return Center(
               child: CircularProgressIndicator(),
             );
        }
        else
        {
          partite=snapshot.data![0];
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: FadeAnimation(1, Padding(
                      padding: EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
                      child: Text(
                        'Partite Confermate',
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
          );
        }
        },
        )
        ]
    )
        )
    );
  }

  room(Map<String,String> room, int index) {
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
                                  Text(tools[index]['partecipanti'], style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),),
                                  Text(tools[index]['sport'], style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),),
                                  Text(tools[index]['distanza'], style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),)
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