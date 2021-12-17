import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';

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
      home: MyHomeGioState(title: appTitle, giocatore:giocatore),
    );
  }
}



// Create a corresponding State class.
// This class holds data related to the form.
class MyHomeGioState extends StatelessWidget {


   const MyHomeGioState({Key? key, required this.title, required this.giocatore}) : super(key: key);

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
                                      padding: const EdgeInsets.only(top: 20.0, left: 70.0,bottom: 40),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          fixedSize: Size.fromWidth(270),
                                        ),

                                        onPressed: () {

                                        },
                                        child: const Text('Ricerca  torneo',style: TextStyle(
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
                              currentIndex: 0,
                              selectedItemColor: Colors.blue,
                               ),

    );
  }







}
