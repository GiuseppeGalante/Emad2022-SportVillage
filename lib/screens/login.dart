import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/screens/SceltaRegistrazione.dart';
import 'package:flutter_app_emad/screens/home.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:flutter_app_emad/screens/registrazioneAmministratoreCS.dart';
import 'package:flutter_app_emad/screens/registrazioneGiocatore.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';

class MainLogin extends StatelessWidget {
  const MainLogin({Key? key}) : super(key: key);

  static const appTitle = 'Sport Village';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: Struttura_Login(title: appTitle),
    );
  }
}

class Struttura_Login extends StatelessWidget {
  const Struttura_Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(backgroundColor:LightColors.kDarkYellow,
          title: Text(title)
      ),
      body: Container(
          child:TemplateLogin()
      ),
      //drawer:DrawerMenu(),
    );
  }
}

enum user { Giocatore, Amministratore }
class TemplateLogin extends StatefulWidget {
  const TemplateLogin({Key? key}) : super(key: key);

  @override
  State<TemplateLogin> createState() => _TemplateLogin();
}

class _TemplateLogin extends State<TemplateLogin> {

  final _formKey = GlobalKey<FormState>();
  user? _type = user.Giocatore;

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _tipo = TextEditingController();
  Giocatore giocatore = new Giocatore();
  Giocatore? gioc=null;
  AmministstratoreCentroSportivo amministratore = AmministstratoreCentroSportivo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:Theme(
            data: ThemeData(
                backgroundColor: LightColors.kDarkBlue
            ),
            child:Stack(
                children: [
                  Container(
                    color: LightColors.kDarkBlue
                  ),

                  Container(
                    child:SingleChildScrollView
                      (
                        child:Column(
                          children: [
                            Padding(
                                child:Center(
                                  child: Image(image:AssetImage("assets/images/logo_no_testo.png"),width: 100,)
                                    /*child:Text("Login",style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),)*/
                                ),
                                padding: EdgeInsets.only(top: 30,left: 30,right: 30)
                            ),
                            Padding(
                                padding: EdgeInsets.only(top:30,left: 30,right: 30),
                                child: Form(
                                    key: _formKey,
                                    child:Column(
                                      children:
                                      [
                                        Padding(
                                          padding:EdgeInsets.only(top:10),
                                          child:TextFormField(
                                              onChanged:(value) => {
                                                giocatore.nome_utente=value,
                                              amministratore.nome_utente=value
                                              },
                                              controller: _username,
                                              decoration: InputDecoration(
                                                icon: Icon(Icons.person,
                                                  color: Colors.white,
                                                  size: 30.0,),
                                                hintText: "Username",
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                              keyboardType: TextInputType.text,
                                              validator: (user) {
                                                if (user!.length != 0) {
                                                  if (user.length >= 8)
                                                    return null;
                                                  else
                                                    return "L'username deve essere lungo almeno 8 caratteri";
                                                }
                                                else {
                                                  return 'Campo Obbligatorio';
                                                }
                                              }
                                          ),
                                        ),
                                        Padding(
                                          padding:EdgeInsets.only(top:10),
                                          child:TextFormField(
                                              onChanged: (value) =>
                                              {
                                                giocatore.password = value,
                                                amministratore.password=value
                                              },
                                              controller: _password,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                icon: Icon(Icons.password,
                                                  color: Colors.white,
                                                  size: 30.0,),
                                                hintText: "Password",
                                                filled: true,
                                                fillColor: Colors.white,
                                              ),
                                              keyboardType: TextInputType.text,
                                              validator: (password) {
                                                if (password!.length != 0) {
                                                  if (password.length >= 8)
                                                    return null;
                                                  else
                                                    return 'La password deve essere lunga tra 8 e 16 caratteri';
                                                }
                                                else
                                                {
                                                  return 'Campo Obbligatorio';
                                                }
                                              }
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15.0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.white),
                                            onPressed: () {
                                              // Validate returns true if the form is valid, or false otherwise.
                                              if (_formKey.currentState!.validate()) {
                                                Login(_username,_password,_type);
                                                //if(_type == user.Giocatore)
                                                  //{
                                                    getGiocatore(giocatore).then((giocatori)=>
                                                    {
                                                      print(giocatori),
                                                      gioc=giocatori,
                                                      if(giocatori != null){

                                                        giocatore.id=giocatori.id,
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context){
                                                              return MyHomeGio(giocatore:giocatori);
                                                            }
                                                        ))
                                                      }

                                                    });
                                                  //}
                                                //else if (_type == user.Amministratore)
                                                  //{
                                                    print(amministratore.nome_utente);
                                                    print(amministratore.password);
                                                    getAmministratoreCS(amministratore).then((amministratori)=>
                                                    {
                                                      print(amministratori),
                                                      if(amministratori != null){
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context){
                                                              return MyHomeACS(amministratore:amministratori);
                                                            }
                                                        ))
                                                      }
                                                      else if(amministratori == null && gioc == null)
                                                        {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                              content: const Text('Email o Password Errata'),
                                                              backgroundColor: Colors.red,
                                                              action: SnackBarAction(textColor:Colors.white,
                                                                label: 'Ho capito', onPressed: () {},),
                                                            ),
                                                          ),
                                                        }

                                                    });
                                                 // }

                                              }
                                            },
                                            child: const Text('Login',style: TextStyle(
                                              color:Colors.black54,
                                              //fontWeight: FontWeight.bold
                                            ),),
                                          ),
                                        ),

                                      Column(
                                          children: <Widget>[
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.white),
                                                onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                                    return SceltaRegistrazioneForm();
                                                  }
                                                  ));

                                                }
                                                , child: Text("Registrati",
                                                         style: TextStyle(
                                                                         color:Colors.black54,),
                                                       )
                                            )
                                          ]

                                      )],
                                    )
                                )
                            )
                          ],
                        )
                    ),
                  ),
                ]
            )
        )
    );
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}


final databaseReference= FirebaseDatabase.instance.reference();
var details = {'Usrname':'tom','Password':'pass@123'};
Future<void> Login(username,password,_type) async {
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String tipo="";
  //createTassa(_targa.text,_costo.text,_datap.text,_annoc.text);
  switch(_type?.index)
      {
    case 0:
      tipo="Giocatore";
      break;
    case 1:
      tipo="Centro Sportivo";
      break;
  }
  var db = databaseReference.child("users/giocatori");
  Query query = databaseReference.orderByChild("Name");
  DataSnapshot event = await query.get();
  print(event.toString());*/
  //print("Username: "+username.text+" Password: "+password.text+" Type: "+tipo);
}

/*DatabaseReference saveGiocatore(Giocatore giocatore)
{
  var id = databaseReference.child("users/giocatori/").push();
  giocatore.id=id;
  id.set(giocatore.toJson());
  return id;
}*/