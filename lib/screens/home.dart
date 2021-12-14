import 'package:flutter/material.dart';

// Create a Form widget.
class MyHomeGio extends StatelessWidget {
  const MyHomeGio({Key? key}) : super(key: key);

  static const appTitle = 'home sport village';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomeGioState(title: appTitle),
    );
  }
}



// Create a corresponding State class.
// This class holds data related to the form.
class MyHomeGioState extends StatelessWidget {
  const MyHomeGioState({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  Widget build(BuildContext context) {
//Build a screen with 4 button and a bar on the top
    return Scaffold(
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
                                      child:Text("Home giocatore",style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),)
                                  ),
                                  padding: EdgeInsets.only(top: 30,left: 30,right: 30)
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 150.0),
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
                                      padding: const EdgeInsets.only(top: 50.0, left: 70.0),
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
                              Row(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(top: 50.0, left: 70.0),
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
                                      padding: const EdgeInsets.only(top: 50.0, left: 70.0),
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
        )

    );
  }







}