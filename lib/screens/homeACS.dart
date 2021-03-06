import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/screens/aggiungiCampo.dart';
import 'package:flutter_app_emad/screens/aggiungiCentroSportivo.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestaTorneo.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestePartita.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';

// annarosa
// Create a Form widget.
class MyHomeACS extends StatelessWidget {

  const MyHomeACS({required this.amministratore,Key? key}) : super(key: key);
  final AmministstratoreCentroSportivo amministratore;
  static const appTitle = 'home sport village';


  @override
  Widget build(BuildContext context) {
    print(amministratore.centrisportivi);
    return MaterialApp(
      title: appTitle,
      home: MyHomeACSState(title: appTitle, amministratore:amministratore),
    );
  }
}

class MyHomeACSState extends StatefulWidget
{
  var title;
  final AmministstratoreCentroSportivo amministratore;


  MyHomeACSState({Key? key, required this.title, required this.amministratore}) : super(key: key);
  @override
  State<MyHomeACSState> createState() => _MyHomeACSState(title: title,amministratore: amministratore);
}


// Create a corresponding State class.
// This class holds data related to the form.
class _MyHomeACSState extends State<MyHomeACSState> {


  _MyHomeACSState({Key? key, required this.title, required this.amministratore});

  final AmministstratoreCentroSportivo amministratore;


  final String title;

  @override
  Widget build(BuildContext context) {
    //print(giocatore);
//Build a screen with 4 button and a bar on the top
    return Scaffold(
        appBar:AppBar(
          backgroundColor: LightColors.kDarkYellow,
          title: Text("Home"),
        ),
        body:Theme(
            data: ThemeData(
                unselectedWidgetColor: Colors.white
            ),
            child:Stack(
                children: [
                  Container(
                    color: LightColors.kDarkBlue,
                  ),

                  Container(
                      child:SingleChildScrollView
                        (
                          child:Column(
                            children: [
                              Padding(
                                  child:Center(
                                      child:Text("Benvenuto ${amministratore.nome}",style: TextStyle(
                                        fontSize: 30,
                                        color: LightColors.kDarkYellow,
                                        fontWeight: FontWeight.bold,
                                      ),)
                                  ),
                                  padding: EdgeInsets.only(top: 30,left: 30,right: 30)
                              ),
                              Padding(padding: EdgeInsets.only(top:30),
                                  child:Icon(Icons.add_business,
                                    size:90,
                                    color: LightColors.kDarkYellow,),
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
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context){
                                          return FormCentroSportivo(amministratore:amministratore);
                                        }
                                    ));
                                  },
                                  child: const Text('Aggiungi centro sportivo',style: TextStyle(
                                    color:Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top:30),
                                child:Icon(Icons.add_location_alt,
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
                                                //print(amministratore);
                                                return FormCampo(amministratore:amministratore);
                                              }
                                          ));
                                        },
                                        child: const Text('Aggiungi campo a centro sportivo',style: TextStyle(
                                          color:Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                        ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ]),
                              Padding(padding: EdgeInsets.only(top:30),
                                child:Icon(Icons.list_alt,
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
                                          getRichiestePartite(acs:amministratore).then((value) =>
                                          {
                                            print(value),
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context){
                                                  return VisualizzaRichiestePartita(amministratore:amministratore,richiestepartite: value,);
                                                }
                                            ))
                                          }
                                          );

                                        },
                                        child: const Text('Visualizza richieste partita',style: TextStyle(
                                          color: LightColors.kLavender,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
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
                                          getRichiesteTornei(acs:amministratore).then((value) =>
                                          {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context){
                                                  return VisualizzaRichiesteTorneo(amministratore:amministratore,richiestetornei: value,);
                                                }
                                            ))
                                          }
                                          );

                                          },
                                          child: const Text('Visualizza richieste Tornei',style: TextStyle(
                                          color:Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        ),
                                      ),
                                    )
                                  ])


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
                               icon: Icon(Icons.list_alt),
                                  label: 'Richieste Partite',
                                 ),
                           BottomNavigationBarItem(
                             icon: Icon(Icons.person),
                           label: 'Profilo',
                              ),
                              ],
                             currentIndex: 0,
                             selectedItemColor: Colors.blue,
                           ),

    );
  }







}
