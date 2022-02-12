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

  Widget _emailWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            // hintText: 'Enter your full name',
            labelText: 'Email',
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

  Widget _passwordWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Password',
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

  Widget _submitButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => SignUpPage()));
        },
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Sign up',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500,
                height: 1.6),
          ),
          SizedBox.fromSize(
            size: Size.square(70.0), // button width and height
            child: ClipOval(
              child: Material(
                color: Color.fromRGBO(76, 81, 93, 1),
                child: Icon(Icons.arrow_forward,
                    color: Colors.white), // button color
              ),
            ),
          ),
        ]),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: SizedBox(
        height: height,
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(height: height * .4),
                        _nameWidget(),
                        SizedBox(height: 20),
                        _emailWidget(),
                        SizedBox(height: 20),
                        _passwordWidget(),
                        SizedBox(height: 80),
                        _submitButton(),
                        SizedBox(height: height * .050),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(top: 60, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}