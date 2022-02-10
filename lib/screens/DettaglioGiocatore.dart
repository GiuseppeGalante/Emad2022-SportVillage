import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/screens/home.dart';
import 'package:flutter_app_emad/screens/profile/InformazioniPersonaliGiocatore.dart';
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
    Icon(Icons.star, size:50,color: LightColors.kBlue,),
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
          backgroundColor: LightColors.kDarkBlue,
          appBar: AppBar(
            title: Text("Dettagli"),
          ),
          body: Container(
            color: LightColors.kLightYellow,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color.fromRGBO(198, 170, 255, 1), Color.fromRGBO(14, 209, 69, 1)]
                      )
                  ),
                  child: Column(
                    children: <Widget>[
                             Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 10.0,
                          ),
                            Card(
                            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: LightColors.kLightYellow,
                            elevation: 5.0,
                            child:ListTile(
                              title: Text("Informazioni Personali",style: TextStyle(
                                fontSize: 22.0,
                                color: LightColors.kBlue,
                                fontWeight: FontWeight.bold,
                              )),
                                trailing:  Icon(Icons.chevron_right,size: 50,color:LightColors.kBlue),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return InfoPersonaliGiocatore(giocatore: giocatore,);
                                }
                                ));
                                },
                            )
                            ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Card(
                              margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                              clipBehavior: Clip.antiAlias,
                              color: LightColors.kLightYellow,
                              elevation: 5.0,
                              child:ListTile(
                                title: Text("Biografia",style: TextStyle(
                                  fontSize: 22.0,
                                  color: LightColors.kBlue,
                                  fontWeight: FontWeight.bold,
                                )),
                                trailing:  Icon(Icons.chevron_right,size: 50,color:LightColors.kBlue),
                                onTap: (){

                                },
                              )
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Card(
                              margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                              clipBehavior: Clip.antiAlias,
                              color: LightColors.kLightYellow,
                              elevation: 5.0,
                              child:ListTile(
                                title: Text("Account",style: TextStyle(
                                  fontSize: 22.0,
                                  color: LightColors.kBlue,
                                  fontWeight: FontWeight.bold,
                                )),
                                trailing:  Icon(Icons.chevron_right,size: 50,color:LightColors.kBlue),
                                onTap: (){

                                },
                              )
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Card(
                              margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                              clipBehavior: Clip.antiAlias,
                              color: LightColors.kLightYellow,
                              elevation: 5.0,
                              child:ListTile(
                                title: Text("Informazioni di Contatto",style: TextStyle(
                                  fontSize: 22.0,
                                  color: LightColors.kBlue,
                                  fontWeight: FontWeight.bold,
                                )),
                                trailing:  Icon(Icons.chevron_right,size: 50,color:LightColors.kBlue,),
                                onTap: (){

                                },
                              )
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                  )
  ]
                  ),
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