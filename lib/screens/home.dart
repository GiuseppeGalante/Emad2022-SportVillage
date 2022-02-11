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
import 'package:flutter_app_emad/theme/colors/light_colors.dart';
import 'package:flutter_app_emad/widgets/card.dart';
import 'package:flutter_app_emad/screens/MappaView.dart';

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

      body:Theme(
        data: ThemeData(
            unselectedWidgetColor: LightColors.kLightYellow
        ),
        child:Stack(
          children: [
            Container(
              color: LightColors.kDarkYellow,
            ),

            Container(
              color: LightColors.kLightYellow,
              child:SingleChildScrollView
                (
                child:Column(
                  children: [
                    Padding(
                        child:Center(
                            child:Text("Benvenuto ${giocatore.nome}",style: TextStyle(
                              fontSize: 40,
                              color: LightColors.kDarkBlue,
                              fontWeight: FontWeight.bold,
                            ),)
                        ),
                        padding: EdgeInsets.only(top: 30,left: 30,right: 30)
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: ()  {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return ProfiloGio (giocatore:giocatore, title: title,);
                                }
                            ));
                          },
                          child:Cards(cardColor:LightColors.kGreen, title: "Profilo"),
                        ),
                        SizedBox(width:20.0,height: 30.0),
                        GestureDetector(
                          onTap: ()  {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return  MapSample(giocatore: giocatore);
                                }
                            ));
                          },
                          child: Cards(
                            cardColor: LightColors.kRed,
                            title: 'Mappa',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: ()  {
                            getCentriSportivi().then((value) =>
    {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  List<CentroSportivo> centrisportivi=[];

                                  centrisportivi = value;
                                  return FormRichiestaNuovaPartita (giocatore:giocatore,centrisportivi:centrisportivi);
                                }

                            ))}
                           );

                          },
                          child :Cards(cardColor:LightColors.kBlue, title: "Richiedi nuova partita"),
                        ),
                        SizedBox(width: 30.0),
                        GestureDetector(
                          onTap: ()  {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return VisualizzaPartiteConfermate (giocatore:giocatore);
                                }
                            ));
                          },
                          child: Cards(
                            cardColor: LightColors.kLavender,
                            title: 'Partite confermate',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: ()  {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return VisRicercaPartita (giocatore:giocatore);
                                }
                            ));
                          },
                          child:Cards(cardColor:LightColors.kDarkYellow, title: "Ricerca Partita"),
                        ),

                        SizedBox(width: 30.0),
                        GestureDetector(
                          onTap: ()  {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                  return FormRichiestaTorneo(giocatore: giocatore);
                                }
                            ));
                          },
                          child: Cards(
                            cardColor: LightColors.kLightGreen,
                            title: 'Richiedi nuovo torneo',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: ()  {
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
                          child:Cards(cardColor:LightColors.kPalePink, title: "Ricerca torneo"),
                        ),
                        SizedBox(width: 30.0),
                        GestureDetector(
                          onTap: ()  {getTorneiPronti(giocatore.id.key.toString()).then((value) =>
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
                          child:Cards(cardColor:LightColors.kRed, title: "Organizza torneo"),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );


  }







}
