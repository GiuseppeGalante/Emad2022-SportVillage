import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/screens/aggiungiCampo.dart';
import 'package:flutter_app_emad/screens/aggiungiCentroSportivo.dart';

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



// Create a corresponding State class.
// This class holds data related to the form.
class MyHomeACSState extends StatelessWidget {


  const MyHomeACSState({Key? key, required this.title, required this.amministratore}) : super(key: key);

  final AmministstratoreCentroSportivo amministratore;


  final String title;

  @override
  Widget build(BuildContext context) {
    //print(giocatore);
//Build a screen with 4 button and a bar on the top
    return Scaffold(
        appBar:AppBar(
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
                                      child:Text("Benvenuto ${amministratore.nome}",style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),)
                                  ),
                                  padding: EdgeInsets.only(top: 30,left: 30,right: 30)
                              ),
                              Padding(padding: EdgeInsets.only(top:30),
                                  child:Icon(Icons.add_business,
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

                                        },
                                        child: const Text('Visualizza richieste partita',style: TextStyle(
                                          color:Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
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
