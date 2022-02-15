
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/animation/FadeAnimation.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/entity/Service.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';
import 'package:flutter_app_emad/entity/TorneiPronti.dart';
import 'package:flutter_app_emad/screens/MappaView.dart';
import 'package:flutter_app_emad/screens/OrganizzaTorneo.dart';
import 'package:flutter_app_emad/screens/ProfiloGiocatore.dart';
import 'package:flutter_app_emad/screens/RicercaTorneo.dart';
import 'package:flutter_app_emad/screens/aggiungiCampo.dart';
import 'package:flutter_app_emad/screens/aggiungiCentroSportivo.dart';
import 'package:flutter_app_emad/screens/ricercaPartita.dart';
import 'package:flutter_app_emad/screens/richiediTorneo.dart';
import 'package:flutter_app_emad/screens/richiestaNuovaPartita.dart';
import 'package:flutter_app_emad/screens/visualizzaPartiteConfermate.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestaTorneo.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestePartita.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestePartita_New.dart';
import 'package:flutter_app_emad/widgets/signupContainer.dart';

class HomeACS extends StatefulWidget {
  AmministstratoreCentroSportivo amministratore;
  String title = 'home sport village';
  HomeACS({Key? key,required this.amministratore}) : super(key: key);


  @override
  State<HomeACS> createState() => _SelectServiceState(title:title, amministratore: amministratore);
}

class _SelectServiceState extends State<HomeACS> {
  AmministstratoreCentroSportivo amministratore;
  String title;
  _SelectServiceState({Key? key,required this.title,required this.amministratore});
  List<Service> services = [
    Service('Aggiungi Centro Sportivo', 'https://img.icons8.com/color/344/sports.png'),
    Service('Aggiungi Campo', 'https://img.icons8.com/color/344/stadium-.png'),
    Service('Richieste Partite', 'https://img.icons8.com/color/344/show-property.png'),
    Service('Richieste Tornei', 'https://img.icons8.com/color/344/list.png'),
  ];

  int selectedService = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: selectedService >= 0 ? FloatingActionButton(
          onPressed: () {
          },
          child: Icon(Icons.arrow_forward_ios, size: 20,),
          backgroundColor: Colors.blue,
        ) : null,
        body:
        SizedBox(
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
                      'Benvenuto \n'+amministratore.nome,
                      textAlign: TextAlign.center,
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
        ])
        ),
    );
  }

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {
        switch(index)
        {
          case 0: Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormCentroSportivo(amministratore:amministratore),
            ),
          );
          break;

          case 1: Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormCampo(amministratore:amministratore),
            ),
          );

          break;

          case 2: getRichiestePartite(acs:amministratore).then((value) =>
          {
            print(value),
            Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return VisualizzaRichiestePartita_New(amministratore:amministratore,richiestepartite: value,);
                }
            ))
          }
          );

          break;

          case 3: getRichiesteTornei(acs:amministratore).then((value) =>
          {
            Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return VisualizzaRichiesteTorneo(amministratore:amministratore,richiestetornei: value,);
                }
            ))
          }
          );

          break;


        }
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
              Text(name, style: TextStyle(fontSize: 18), textAlign: TextAlign.center,)
            ]
        ),
      ),
    );
  }
}