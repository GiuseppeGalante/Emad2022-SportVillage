import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/screens/home.dart';
import 'package:flutter_app_emad/screens/DettaglioGiocatore.dart';

class ProfiloGio extends StatelessWidget {

  const ProfiloGio({required this.title,required this.giocatore,Key? key}) : super(key: key);
  final Giocatore giocatore;
  final String title;
  static const appTitle = 'home sport village';


  @override
  Widget build(BuildContext context) {
    print(giocatore);
    return MaterialApp(
      title: appTitle,
      home: ProfiloGioState(title: appTitle, giocatore:giocatore),
    );
  }
}
class ProfiloGioState extends StatefulWidget
{
  var title;
  final Giocatore giocatore;

  ProfiloGioState({Key? key, required this.title, required this.giocatore}) : super(key: key);
  @override
  _ProfiloGiocatore createState() => _ProfiloGiocatore(title: title,giocatore: giocatore);
}



class _ProfiloGiocatore extends State<ProfiloGioState> {
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
  _ProfiloGiocatore({Key? key,required this.title,required this.giocatore});
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
                height: 420.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                      padding:EdgeInsets.only(top:10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://www.corriere.it/methode_image/2020/12/07/Salute/Foto%20Salute%20-%20Trattate/furetto-kyJF-U32302148665584UE-656x492@Corriere-Web-Sezioni.jpg",
                        ),
                        radius: 50.0,
                      ),
              ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        giocatore.nome+" "+giocatore.cognome,
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(

                                  children: <Widget>[
                                    Text(
                                      "Vittorie",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      giocatore.vittorie.toString(),
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(

                                  children: <Widget>[
                                    Text(
                                      "Pareggi",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      giocatore.pareggi.toString(),
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(

                                  children: <Widget>[
                                    Text(
                                      "Sconfitte",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      giocatore.sconfitte.toString(),
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(

                                  children: <Widget>[
                                    Text(
                                      "Valutazione",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        for(int i=0;i<4;i++)
                                                 star[i]
                                      ],
                                    )
                                      ],
                                    )


                              ),
                            ],
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              )
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Bio:",
                    style: TextStyle(
                        color: Colors.blue,
                        fontStyle: FontStyle.normal,
                        fontSize: 28.0
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    giocatore.bio.toString(),
                    style: TextStyle(
                      fontSize: 22.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 300.00,

            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
                elevation: MaterialStateProperty.all<double>(0),
              ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return DettaglioGio(giocatore:giocatore);
                      }
                  ));
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.blue,Colors.lightBlueAccent]
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text("Altro",
                      style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight:FontWeight.w300),
                    ),
                  ),
                )
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
