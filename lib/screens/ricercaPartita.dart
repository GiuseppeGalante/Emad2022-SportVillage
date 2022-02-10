import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/PartitaConfermata.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/screens/visualizzaInfoRichiestaPartita.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import 'dettaglioPartitaConfermata.dart';
import 'home.dart';



// Create a Form widget.
class VisRicercaPartita extends StatefulWidget {
  Giocatore giocatore;
  bool find=true;
  List<TorneiAccettati> partite=[];
  //CentroSportivo centroSportivo;
  VisRicercaPartita({required this.giocatore, Key? key}) : super(key: key);
  @override
  _VisRicercaPartitaState createState() => _VisRicercaPartitaState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _VisRicercaPartitaState extends State<VisRicercaPartita> {
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

  Future<List<TorneiAccettati>> getDistancePartite() async
  {
    List<TorneiAccettati>? partiteconfermate= await getPartiteConfermate();
    Giocatore giocatore=widget.giocatore;
    if(partiteconfermate != null)
    {

      for(var i=0;i<partiteconfermate.length;i++)
      for(var k=0;k<giocatore.partiteconfermate!.length;k++)
      if(partiteconfermate[i].id.key==giocatore.partiteconfermate![k].id.key)
        partiteconfermate.remove(partiteconfermate[i]);
    }
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
    return partiteconfermate;
  }

  @override
  Widget build(BuildContext context) {
    //this.amministratore=widget.amministratore;
    // Build a Form widget using the _formKey created above.



    Giocatore giocatore=widget.giocatore;

    /*
    if(giocatore.partiteconfermate== null)
      giocatore.partiteconfermate=[];
    bool find=widget.find;
    if(find)
      {
        getPartiteConfermate().then((value) =>
        {
          if(value != null)
            {
              partite=value,
              for(var i=0;i<partite.length;i++)
                for(var k=0;k<giocatore.partiteconfermate!.length;k++)
                  if(partite[i].id.key==giocatore.partiteconfermate![k].id.key)
                    partite.remove(partite[i])
            },

          setState((){widget.find=false;widget.partite=partite;})

        });
      }*/


    return Scaffold(
        appBar: AppBar(
          title: Text("Ricerca partita"),
        ),

        body: FutureBuilder(
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
                List<TorneiAccettati> partite=snapshot.data![0];
                return ListView.builder(
                    itemCount: partite.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: ListTile(
                          leading:Icon(Icons.assignment_outlined, color: Colors.black, size: 50.0,),
                          onTap:()  =>

                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      VisPartitaConfermata(partitaconfermata: partite[index],giocatore: giocatore,)

                              )),

                          title: Text(partite[index].data),
                          subtitle: Column(
                            children: [
                              Text('Numero di partecipanti:'+partite[index].numero_di_partecipanti.toString()),
                              Text('Sport:'+partite[index].sport.toString().split(".").last),
                              Text("Distanza:"+partite[index].distanza.toString()+" km")
                            ],
                          ),
                        ),
                      );
                    }
                );
              }
          },
        )


    );
  }
}





