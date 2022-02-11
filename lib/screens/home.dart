import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/Prenotazioni.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';
import 'package:flutter_app_emad/entity/TorneiPronti.dart';
import 'package:flutter_app_emad/screens/MappaView.dart';
import 'package:flutter_app_emad/screens/OrganizzaTorneo.dart';
import 'package:flutter_app_emad/screens/ProfiloGiocatore.dart';
import 'package:flutter_app_emad/screens/RicercaTorneo.dart';
import 'package:flutter_app_emad/screens/ricercaPartita.dart';
import 'package:flutter_app_emad/screens/richiediTorneo.dart';
import 'package:flutter_app_emad/screens/richiestaNuovaPartita.dart';
import 'package:flutter_app_emad/screens/visualizzaPartiteConfermate.dart';
import 'package:flutter_app_emad/screens/InfoCentriSportivi.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';

// annarosa
// Create a Form widget.
class MyHomeGio extends StatelessWidget {

 const MyHomeGio({required this.giocatore,Key? key}) : super(key: key);
 final Giocatore giocatore;
  static const appTitle = 'home sport village';


  @override
  Widget build(BuildContext context) {
    print(giocatore);
    return MaterialApp(
      title: appTitle,
      home: HomeGioState(title: appTitle, giocatore:giocatore),
    );
  }
}


class HomeGioState extends StatefulWidget
{
  var title;
  final Giocatore giocatore;


  HomeGioState({Key? key, required this.title, required this.giocatore}) : super(key: key);
  @override
  State<HomeGioState> createState() => _MyHomeGioState(title: title,giocatore: giocatore);
}

// Create a corresponding State class.
// This class holds data related to the form.
class _MyHomeGioState extends State<HomeGioState>{

  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(_selectedIndex)
      {
        case 2:
          Navigator.push(context, MaterialPageRoute(
              builder: (context){
                return ProfiloGio(title:title,giocatore:giocatore);
              }
          ));
              break;
      }
    });
  }

  _MyHomeGioState({Key? key, required this.title, required this.giocatore});


  final Giocatore giocatore;


  final String title;

  @override
  Widget build(BuildContext context) {
    //print(giocatore);
//Build a screen with 4 button and a bar on the top
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
        body:Theme(
            data: ThemeData(
                unselectedWidgetColor: Colors.white
            ),
            child:Stack(
                children: [
                  Container(
                    color: Colors.blue,
                  ),

                  Container(
                      child:SingleChildScrollView
                        (
                          child:Column(
                            children: [
                              Padding(
                                  child:Center(
                                      child:Text("Benvenuto ${giocatore.nome}",style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),)
                                  ),
                                  padding: EdgeInsets.only(top: 30,left: 30,right: 30)
                              ),
                              Padding(padding: EdgeInsets.only(top:30),
                                child:Icon(Icons.sports,
                                  size:90,
                                  color: Colors.white,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    fixedSize: Size.fromWidth(270),
                                    // size bottoni fissi
                                  ),
                                  onPressed: () {
                                    getCentriSportivi().then((value) =>
                                    {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context){
                                          List<CentroSportivo> centrisportivi=[];

                                            centrisportivi = value;
                                          return FormRichiestaNuovaPartita(giocatore:giocatore,centrisportivi:centrisportivi);
                                        }
                                    ))
                                    }
                                    );
                                  },
                                  child: const Text('Richiedi nuova partita',style: TextStyle(
                                    color:Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  ),
                                ),
                              ),
                              Row(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0, left: 70.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          fixedSize: Size.fromWidth(270),
                                        ),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context){
                                                return VisualizzaPartiteConfermate (giocatore:giocatore);
                                              }
                                          ));
                                        },
                                        child: const Text('Partite confermate',style: TextStyle(
                                          color:Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        ),
                                      ),
                                    )
                                  ]),
                              Row(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0, left: 70.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          fixedSize: Size.fromWidth(270),
                                        ),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context){
                                                return VisRicercaPartita (giocatore:giocatore);
                                              }
                                          ));
                                        },
                                        child: const Text('Ricerca  partita',style: TextStyle(
                                          color:Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        ),
                                      ),
                                    )
                                  ]),
                              Padding(padding: EdgeInsets.only(top:20),
                                child:Icon(Icons.emoji_events,
                                  size:90,
                                  color: Colors.white,),
                              ),
                              Row(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0, left: 70.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          fixedSize: Size.fromWidth(270),
                                        ),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context){
                                                return MapSample (giocatore: giocatore,);
                                              }
                                          ));
                                        },
                                        child: const Text('Visualizza Mappa',style: TextStyle(
                                          color:Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        ),
                                      ),
                                    )
                                  ]),
                              Row(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0, left: 70.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          fixedSize: Size.fromWidth(270),
                                        ),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context){
                                                return FormRichiestaTorneo (giocatore:giocatore);
                                              }
                                          ));

                                        },
                                        child: const Text('Richiedi nuovo torneo',style: TextStyle(
                                          color:Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        ),
                                      ),
                                    )
                                  ]),
                              Row(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0, left: 70.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          fixedSize: Size.fromWidth(270),
                                        ),

                                        onPressed: () {

                                          getTorneiAccettati().then((value) =>
                                          {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context){
                                                  return VisualizzaTorneo (tornei: value,giocatore:giocatore);
                                                }
                                            ))
                                          }
                                          );

                                        },
                                        child: const Text('Ricerca torneo',style: TextStyle(
                                          color:Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        ),
                                      ),
                                    )
                                  ]),


                              Row(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0, left: 70.0,bottom: 40),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          fixedSize: Size.fromWidth(270),
                                        ),

                                        onPressed: () {

                                          getTorneiPronti(giocatore.id.key.toString()).then((value) =>
                                          {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context){
                                                  var t=<TorneoPronto>[];
                                                  for(int i=0;i<value.length;i++) {
                                                    if (value[i].squadre_confermate.toInt() == value[i].numero_di_partecipanti.toInt())
                                                      t.add(value[i]);
                                                  }
                                                  return OrganizzaTorneo (tornei: t,giocatore:giocatore);
                                          }
                                            ))
                                          },
                                          );

                                        },
                                        child: const Text('Organizza torneo',style: TextStyle(
                                          color:Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        ),
                                      ),
                                    )
                                  ]),



                            ],
                          )
                      )
                  )
                ]
            )
        ),
        bottomNavigationBar: BottomNavigationBar(
                            items: const <BottomNavigationBarItem>[
                              BottomNavigationBarItem(
                              icon: Icon(Icons.home),
                              label: 'Home',
                               ),
                               BottomNavigationBarItem(
                                     icon: Icon(Icons.search),
                                               label: 'Ricerca Partita',
                                  ),
                                  BottomNavigationBarItem(
                                           icon: Icon(Icons.person),
                                                    label: 'Profilo',
                                        ),
                                     ],
                              currentIndex: _selectedIndex,
                              selectedItemColor: Colors.blue,
                              onTap: _onItemTapped,
                               ),

    );
  }







}
