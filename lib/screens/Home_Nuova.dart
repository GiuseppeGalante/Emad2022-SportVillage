
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/animation/FadeAnimation.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/Service.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';
import 'package:flutter_app_emad/entity/TorneiPronti.dart';
import 'package:flutter_app_emad/screens/PartiteConfermate_New.dart';
import 'package:flutter_app_emad/screens/Design.dart';
import 'package:flutter_app_emad/screens/MappaView.dart';
import 'package:flutter_app_emad/screens/OrganizzaTorneo.dart';
import 'package:flutter_app_emad/screens/ProfiloGiocatore.dart';
import 'package:flutter_app_emad/screens/RicercaTorneo.dart';
import 'package:flutter_app_emad/screens/ricercaPartita.dart';
import 'package:flutter_app_emad/screens/richiediTorneo.dart';
import 'package:flutter_app_emad/screens/richiestaNuovaPartita.dart';
import 'package:flutter_app_emad/screens/visualizzaPartiteConfermate.dart';
import 'package:flutter_app_emad/widgets/signupContainer.dart';

class HomeGiocatore extends StatefulWidget {
  Giocatore giocatore;
  String title = 'home sport village';
  HomeGiocatore({Key? key,required this.giocatore}) : super(key: key);


  @override
  State<HomeGiocatore> createState() => _SelectServiceState(giocatore: giocatore, titolo: title);
}

class _SelectServiceState extends State<HomeGiocatore> {
  Giocatore giocatore;
  String titolo;
  _SelectServiceState({Key? key,required this.titolo,required this.giocatore});
  List<Service> services = [
    Service('Profilo', 'https://img.icons8.com/color/344/customer-skin-type-7.png'),
    Service('Mappa', 'https://img.icons8.com/color/344/map-marker.png'),
    Service('Richiedi Partita', 'https://img.icons8.com/color/344/stadium.png'),
    Service(' Partite \n Confermate', 'https://img.icons8.com/color/344/verified-account.png'),
    Service('Ricerca Partita', 'https://img.icons8.com/color/344/man-winner.png'),
    Service('Ricerca Torneo', 'https://img.icons8.com/color/344/trophy.png'),
    Service('Richiedi Torneo', 'https://img.icons8.com/color/344/leaderboard.png'),
    Service(' Organizza \n Torneo', 'https://img.icons8.com/color/344/calendar--v1.png'),
  ];

  int selectedService = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: selectedService >= 0 ? FloatingActionButton(
          onPressed: () {
            switch(selectedService)
            {
              case 0: Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfiloGio(giocatore: giocatore,title: titolo,),
                ),
              );
              break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapSample(giocatore: giocatore,),
                  ),
                );
                break;
              case 2:
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
                break;

              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VisualizzaPartiteConfermate_New (giocatore:giocatore),
                  ),
                );
                break;

              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VisRicercaPartita (giocatore:giocatore),
                  ),
                );
                break;

              case 5:
                getTorneiAccettati().then((value) =>
                {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return VisualizzaTorneo (giocatore:giocatore);
                      }
                  ))
                }
                );
                break;

              case 6:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormRichiestaTorneo(giocatore: giocatore),
                  ),
                );
                break;

              case 7:
                getTorneiPronti(giocatore.id.key.toString()).then((value) =>
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

                break;


            }


          },
          child: Icon(Icons.arrow_forward_ios, size: 20,),
          backgroundColor: Colors.blue,
        ) : null,
        body: SizedBox(
            height: 1500,
            child: Stack(
                children: [
            Positioned(
            height: MediaQuery
                .of(context)
                .size
                .height * 1,
            child: SignUpContainer()),
        NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                  child: FadeAnimation(1.2, Padding(
                    padding: EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
                    child: Text(
                      'Di quale servizio \nnecessiti?',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ))
            ];
          },
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: services.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FadeAnimation((1.0 + index) / 4, serviceContainer(services[index].imageURL, services[index].name, index));
                        }
                    ),
                  ),
                ]
            ),
          ),
        )
  ]
    ),
        ),
    );
  }

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedService == index)
            selectedService = -1;
          else
            selectedService = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: selectedService == index ? Colors.blue.shade50 : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index ? Colors.blue : Colors.blue.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(image, height: 80),
              SizedBox(height: 20,),
              Text(name, style: TextStyle(fontSize: 20),)
            ]
        ),
      ),
    );
  }
}