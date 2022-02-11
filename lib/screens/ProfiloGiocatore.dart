import 'dart:typed_data';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/screens/home.dart';
import 'package:flutter_app_emad/screens/DettaglioGiocatore.dart';
import 'package:flutter_app_emad/screens/visualizzaPartiteConfermate.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';
import 'package:flutter_app_emad/widgets/top_container.dart';
import 'package:flutter_app_emad/widgets/task_column.dart';
import 'package:flutter_app_emad/widgets/task_container.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_app_emad/widgets/active_project_card.dart';

class ProfiloGio extends StatelessWidget {
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }
  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

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
    double width = MediaQuery.of(context).size.width;
    var bottomNavigationBar;


    return MaterialApp(
        home:Scaffold(
          backgroundColor: LightColors.kLightYellow,
        body: SafeArea(
          child: Column(
            children: <Widget>[
            TopContainer(
              height: 200,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                           onTap: ()  {
                                Navigator.push(context, MaterialPageRoute(
                                builder: (context){
                                return MyHomeGio (giocatore:giocatore);
                                }
                                ));
                                },
                              child:Icon(Icons.home,
                                  color: LightColors.kDarkBlue, size: 30.0),
                            )


                          ],
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                        CircularPercentIndicator(
                          radius: 60.0,
                          lineWidth: 3.0,
                          animation: true,
                          percent: 0.75,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: LightColors.kRed,
                          backgroundColor: LightColors.kDarkYellow,
                          center: CircleAvatar(
                            backgroundColor: LightColors.kBlue,
                            radius: 20.0,
                            backgroundImage: AssetImage(
                                'assets/images/avatar.png',
                            ),
                          ),
                        ),
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              giocatore.nome+ ' '+giocatore.cognome ,
                              textAlign: TextAlign.start,

                              style: TextStyle(
                                fontSize: 35.0,
                                color: LightColors.kDarkBlue,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Username:  '+giocatore.nome_utente,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black45,
                                fontWeight: FontWeight.w400,
                               ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                )
            ]),
          ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                children: <Widget>[
                  Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                    child: Column(
                    children: <Widget>[
                      Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                      Text('Il mio Profilo',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.0),
                      GestureDetector(
                        onTap: ()  {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context){
                                return VisualizzaPartiteConfermate (giocatore:giocatore);
                              }
                          ));
                        },
                        child: TaskColumn(
                          icon: Icons.alarm,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'Partite prenotate',
                          subtitle: "Numero di partite prenotate:"+giocatore.partiteconfermate!.length.toString() ,
                        ),
                      )
                      ,
                      SizedBox(height: 40.0,),
                      TaskColumn(
                      icon: Icons.blur_circular,
                      iconBackgroundColor: LightColors.kDarkYellow,
                      title: 'Partite giocate',
                      subtitle: 'vittorie '+giocatore.vittorie.toString()+' '+'sconfitte  '+giocatore.sconfitte.toString()+'  pareggi '+giocatore.pareggi.toString(),
                    ),
                      SizedBox(height: 40.0),
                      TaskColumn(
                        icon: Icons.check_circle_outline,
                        iconBackgroundColor: LightColors.kBlue,
                        title: 'Bio Giocatore',
                        subtitle:giocatore.bio.toString(),
                      ),
                    ],
                    ),
                  ), Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Le mie skill'
                        ),
                        SizedBox(height: 2.0),
                        Row(
                          children: <Widget>[
                            ActiveProjectsCard(
                              cardColor: LightColors.kGreen,
                              loadingPercent: 0.7,
                              title: 'Partite vinte',
                              subtitle: '',
                                    ),
                            SizedBox(width: 10.0),
                            ActiveProjectsCard(
                              cardColor: LightColors.kRed,
                              loadingPercent: 0.1,
                              title: 'Partite con pareggi',
                              subtitle: '',
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            ActiveProjectsCard(
                              cardColor: LightColors.kDarkYellow,
                              loadingPercent: 0.2,
                              title: 'Partite Perse',
                              subtitle: '',
                            ),
                            SizedBox(width: 10.0),
                            ActiveProjectsCard(
                              cardColor: LightColors.kBlue,
                              loadingPercent: 0.3,
                              title: 'Gol Fatti ',
                              subtitle: '',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                ),
              ),
            ),
            ],
          ),
        ),
        ),
    );
  }
}
