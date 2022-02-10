import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/screens/home.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';

class DettaglioGio extends StatelessWidget {

  const DettaglioGio({required this.giocatore,Key? key}) : super(key: key);
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
  _DettaglioGiocatore createState() => _DettaglioGiocatore(title: title,giocatore: giocatore);
}



class _DettaglioGiocatore extends State<DettaglioGioState> {
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
    Icon(Icons.star, size:50, color: LightColors.kBlue,),
    Icon(Icons.star, size:50, color: LightColors.kBlue,),
    Icon(Icons.star_half, size:50, color: LightColors.kBlue,),
  ];

  var title;
  final Giocatore giocatore;
  _DettaglioGiocatore({Key? key,required this.title,required this.giocatore});
  @override
  Widget build(BuildContext context) {
    if(giocatore.bio=="")
      giocatore.bio="Nessuna Biografia";
    return MaterialApp(
        home:Scaffold(
          appBar: AppBar(
            backgroundColor: LightColors.kDarkBlue,
            title: Text("Dettagli"),
          ),
          body: Column(
            children: <Widget>[
              Container(
                color: LightColors.kLightYellow,
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
                              color: LightColors.kDarkBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Card(
                            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: LightColors.kBlue,
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
                                            color: LightColors.kBlue,
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
                                            color: LightColors.kDarkBlue,
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
                                            color:LightColors.kBlue,
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
                                            color: LightColors.kDarkBlue,
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
                                            color: LightColors.kBlue,
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
                                            color: LightColors.kDarkBlue,
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
                            color: LightColors.kLightYellow,
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
                                              color: LightColors.kBlue,
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
                color: LightColors.kLightYellow,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Bio:",
                        style: TextStyle(
                            color: LightColors.kBlue,
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
                          color: LightColors.kDarkBlue,
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
                color: LightColors.kLightYellow,
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
                            colors: [LightColors.kBlue,LightColors.kDarkBlue]
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        color: LightColors.kLightYellow,
                        constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text("Altro",
                          style: TextStyle(color: LightColors.kDarkBlue, fontSize: 26.0, fontWeight:FontWeight.w300),
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
                backgroundColor: LightColors.kDarkBlue,
                icon: Icon(Icons.home, color: LightColors.kLightYellow,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search,color: LightColors.kLightYellow,),
                label: 'Ricerca Partita',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,color: LightColors.kLightYellow,),
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