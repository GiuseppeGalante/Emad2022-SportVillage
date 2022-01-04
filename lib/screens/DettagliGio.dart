import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/screens/home.dart';
import 'package:flutter_app_emad/screens/DettagliGio.dart';

class DettagliGio extends StatelessWidget {

  const DettagliGio({required this.giocatore,Key? key}) : super(key: key);
  final Giocatore giocatore;
  static const appTitle = 'home sport village';


  @override
  Widget build(BuildContext context) {
    print(giocatore);
    return MaterialApp(
      title: appTitle,
      home: DettaglioGioState(title: appTitle, giocatore:giocatore),
    );
  }
}
class DettaglioGioState extends StatefulWidget
{
  var title;
  final Giocatore giocatore;

  DettaglioGioState({Key? key, required this.title, required this.giocatore}) : super(key: key);
  @override
  _DettaglioGioState createState() => _DettaglioGioState(title: title,giocatore: giocatore);
}




class _DettaglioGioState extends State<DettaglioGioState> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(_selectedIndex)
      {
        case 0:
          Navigator.push(context, MaterialPageRoute(
              builder: (context){
                return MyHomeGio(giocatore:giocatore);
              }
          ));
          break;
      }
    });
  }



  final List<Widget> star = <Widget>[Icon(Icons.star, size:50, color: Colors.blueGrey,),
    Icon(Icons.star, size:50, color: Colors.blueGrey,),
    Icon(Icons.star, size:50, color: Colors.blueGrey,),
    Icon(Icons.star_half, size:50, color: Colors.blueGrey,),
  ];

  var title;
  final Giocatore giocatore;
  _DettaglioGioState({Key? key,required this.title,required this.giocatore});
  @override
  Widget build(BuildContext context) {
    if(giocatore.bio=="")
      giocatore.bio="Nessuna Biografia";
    return MaterialApp(
        home:Scaffold(
          appBar: AppBar(
            title: Text("Profilo"),
          ),
          body: Column(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color.fromRGBO(198, 170, 255, 1), Color.fromRGBO(14, 209, 69, 1)]
                      )
                  ),
                  child: Container(
                    width: double.infinity,
                      height:MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding:EdgeInsets.only(top:10),
                            child: Card(
                                margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                                clipBehavior: Clip.antiAlias,
                                color: Colors.white,
                                elevation: 5.0,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                                    child:ListTile(
                                      leading: Icon(Icons.person,size: 50,color:Colors.blueGrey),
                              title: Text("Nome:",style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )),
                              subtitle: Text(giocatore.nome+" "+giocatore.cognome,style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                            )
                            ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          Card(
                            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                                child:ListTile(
                                  leading: Icon(Icons.person,size: 50,color:Colors.blueGrey),
                                  title: Text("Nome Utente:",style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  )),
                                  subtitle: Text(giocatore.nome_utente,style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.lightBlueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                )
                            ),
                          ),

                          SizedBox(
                            height: 10.0,
                          ),

                          Card(
                            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                                child:ListTile(
                                  leading: Icon(Icons.phone,size: 50,color:Colors.blueGrey),
                                  title: Text("Numero di Telefono:",style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  )),
                                  subtitle: Text(giocatore.numero_di_telefono,style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.lightBlueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                )
                            ),
                          ),

                          SizedBox(
                            height: 10.0,
                          ),

                          Card(
                            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                                child:ListTile(
                                  leading: Icon(Icons.email,size: 50,color:Colors.blueGrey),
                                  title: Text("Email:",style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  )),
                                  subtitle: Text(giocatore.email,style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.lightBlueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                )
                            ),
                          ),

                          SizedBox(
                            height: 10.0,
                          ),

                          Card(
                            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                                child:ListTile(
                                  leading: Icon(Icons.phone,size: 50,color:Colors.blueGrey),
                                  title: Text("Data di Nascita:",style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  )),
                                  subtitle: Text(giocatore.data_di_nascita,style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.lightBlueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                )
                            ),
                          ),

                        ],
                      ),
                    ),
              ),
            ],
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
        )
    );
  }
}
