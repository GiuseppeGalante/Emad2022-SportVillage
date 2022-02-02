import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/PartitaConfermata.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'dettaglioPartitaConfermata.dart';




class MapSample extends StatefulWidget {

  Giocatore giocatore;
  MapSample({required this.giocatore,  Key? key});
  @override
  State<MapSample> createState() => MapSampleState();
}



class MapSampleState extends State<MapSample> {

  List<Marker> markers=[];
  Future<List<LatLng>> getPositionsPartite(Giocatore giocatore) async
  {
    List<PartitaConfermata>? partite= await getPartiteConfermate();
    List<LatLng>latlng=[];
    for(int i=0;i<partite!.length;i++)
      {
        if(partite[i].indirizzo != "")
          {
          List<Location> locations = await locationFromAddress(partite[i].indirizzo);
            if(locations.isNotEmpty)
              {
                latlng.add(LatLng(locations.first.latitude,locations.first.longitude));
                markers.add(new Marker(
                  width: 300.0,
                  height: 300.0,
                  point: LatLng(locations.first.latitude,locations.first.longitude),
                  builder: (ctx) =>
                  new Container(
                    child: GestureDetector(
                      child: new Icon(Icons.place_sharp),
                      onTap:  (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                VisPartitaConfermata(partitaconfermata: partite[i],giocatore: giocatore,)

                        ));
                      },
                    ),
                  ),
                ));
              }

          }

      }
    return latlng;
  }

  bool found=true;
  @override
  Widget build(BuildContext context) {
    Giocatore giocatore=widget.giocatore;
    return Scaffold(
    body:FutureBuilder(
      future: Future.wait([Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high),getPositionsPartite(giocatore)]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          }else
            {
              Position position=snapshot.data![0];
              List<LatLng> latlng=snapshot.data![1];

              markers.add(new Marker(
                width: 300.0,
                height: 300.0,
                point: LatLng(position.latitude,position.longitude),
                builder: (ctx) =>
                new Container(
                  child: GestureDetector(
                    child: new Icon(Icons.person ),
                    onTap:  (){
                      print("click");
                    },
                  ),
                ),
              ));
              /*for(int i=0;i<latlng.length;i++)
                {
                  markers.add(new Marker(
                    width: 300.0,
                    height: 300.0,
                    point: latlng[i],
                    builder: (ctx) =>
                    new Container(
                      child: GestureDetector(
                        child: new Icon(Icons.place_sharp),
                        onTap:  (){
                          print("click");
                        },
                      ),
                    ),
                  ));
                }*/
              return new FlutterMap(
                options: new MapOptions(
                  center: new LatLng(position.latitude, position.longitude),
                  zoom: 16.0,
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate: "https://atlas.microsoft.com/map/tile/png?api-version=1&layer=basic&style=main&tileSize=256&view=Auto&zoom={z}&x={x}&y={y}&subscription-key={subscriptionKey}",
                    additionalOptions: {
                      'subscriptionKey': 'noX2Gr6mqcV3NOG1OL7qwih3u2ZNsmYC19X6RbHKmCs'
                    },
                  ),
                  new MarkerLayerOptions(
                    markers: markers,
                  ),
                ],
              );
            }
        }

    )


    );
  }



}
