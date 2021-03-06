import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/PartitaConfermata.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Squadre.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/screens/visualizzaInfoRichiestaPartita.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../theme/colors/light_colors.dart';
import 'DettaglioTorneiAccettati.dart';
import 'dettaglioPartitaConfermata.dart';
import 'home.dart';



// Create a Form widget.
class VisualizzaTorneo extends StatefulWidget {
  Giocatore giocatore;
  bool find=true;
  List<PartitaConfermata> partite=[];
  //CentroSportivo centroSportivo;
  VisualizzaTorneo({required this.giocatore, Key? key}) : super(key: key);
  @override
  _VisualizzaTorneoState createState() => _VisualizzaTorneoState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _VisualizzaTorneoState extends State<VisualizzaTorneo> {
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

  Future<List<TorneoAccettato>> getDistancePartite() async
  {
    List<TorneoAccettato>? partiteconfermate= await getTorneiAccettati();
    Giocatore giocatore=widget.giocatore;
    int lenght=partiteconfermate.length;
    List<TorneoAccettato> partiteconfermatedarim=[];
    for(int i=0;i<lenght;i++)
      partiteconfermatedarim.add(partiteconfermate[i]);
    if(partiteconfermate != null)
    {
      try{
        print(partiteconfermate.length);
        for(var i=0;i<lenght;i++)
          {
            print(partiteconfermate[i].nome);
            if(partiteconfermate[i].id_giocatore==giocatore.id.key)
            {
              print("rimuovo:"+partiteconfermate[i].nome);
              partiteconfermatedarim.remove(partiteconfermate[i]);
            }
          }

        partiteconfermate=partiteconfermatedarim;
      } catch (error)
      {
        //print(partiteconfermate[i].indirizzo);
        print(error);
      }

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
    List<Squadra> squadre=[];

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
          backgroundColor: LightColors.kDarkBlue,
          title: Text("Torneo Attivi"),
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
              List<TorneoAccettato> partite=snapshot.data![0];
              return ListView.builder(
                  itemCount: partite.length,
                  itemBuilder: (context,index){
                    return Card(
                      color: LightColors.kLightYellow,
                      child: ListTile(
                        leading:Icon(Icons.assignment_outlined, color: LightColors.kDarkBlue, size: 50.0,),
                        onTap:() async  =>
                        {
                          squadre=await getSquadre(partite[index].id_torneo),
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  DettaglioTorneoAccettato(
                                      torneo: partite[index],
                                      giocatore: giocatore,
                                      squadre: squadre)

                          )),
                        },
                        title: Text(partite[index].nome),
                        subtitle: Column(
                          children: [
                            Text('Numero di partecipanti:'+partite[index].numero_di_partecipanti.toString(),style: TextStyle(
                              color: LightColors.kDarkBlue,
                              fontWeight: FontWeight.w800,
                            )),
                            Text('Sport:'+partite[index].sport.toString().split(".").last,style: TextStyle(
                              color: LightColors.kDarkBlue,
                              fontWeight: FontWeight.w800,
                            )),
                            Text("Distanza:"+partite[index].distanza.toString()+" km",style: TextStyle(
                              color: LightColors.kDarkBlue,
                              fontWeight: FontWeight.w800,
                            ))
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





