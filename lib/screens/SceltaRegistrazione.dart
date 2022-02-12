import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/entity/Squadre.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/DettaglioTorneiAccettati.dart';
import 'package:flutter_app_emad/screens/DettaglioTorneo.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/screens/registrazioneAmministratoreCS.dart';
import 'package:flutter_app_emad/screens/registrazioneGiocatore.dart';

import '../animation/FadeAnimation.dart';
import '../entity/Service.dart';
import '../widgets/signupContainer.dart';
import '../widgets/signup_clipper.dart';
import 'home.dart';



// Create a Form widget.
class SceltaRegistrazioneForm extends StatefulWidget {

  //CentroSportivo centroSportivo;

  SceltaRegistrazioneForm({ Key? key}) : super(key: key);
  @override
  _SceltaRegistrazioneFormState createState() => _SceltaRegistrazioneFormState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _SceltaRegistrazioneFormState extends State<SceltaRegistrazioneForm> {

  List<Service> services = [
    Service('Registrazione Giocatore', 'https://img.icons8.com/external-konkapp-flat-konkapp/128/000000/external-soccer-player-soccer-konkapp-flat-konkapp.png'),
    Service('Registrazione Amministratore \nCentro Sportivo', 'https://img.icons8.com/fluency/96/000000/administrator-male.png'),
  ];

  int selectedService = -1;

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 20, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            // hintText: 'Enter your full name',
            labelText: 'Name',
            labelStyle: TextStyle(
                color: Color.fromRGBO(226, 222, 211, 1),
                fontWeight: FontWeight.w500,
                fontSize: 13),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(226, 222, 211, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }





  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      floatingActionButton: selectedService >= 0 ? FloatingActionButton(
        onPressed: () {
          switch(selectedService)
          {
            case 0: Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyCustomFormGiocatore(),
              ),
            );
            break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyCustomFormAmministratoreCS(),
                ),
              );
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
            SingleChildScrollView(

              child: Column(
                children: <Widget>[
                FadeAnimation(1.2, Padding(
                padding: EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
                child: Text(
                  'Scegli il tipo di \nregistrazione',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ),
                  Container(
                    height: height+200,
                    width: 500,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(top: 10, left: 0, child: _backButton()),
          ],
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