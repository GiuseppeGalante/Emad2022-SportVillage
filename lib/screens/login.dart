import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/screens/home.dart';
import 'package:flutter_app_emad/screens/registrazioneAmministratoreCS.dart';
import 'package:flutter_app_emad/screens/registrazioneGiocatore.dart';

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
      appBar: AppBar(title: Text(title)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Theme(
            data: ThemeData(
                unselectedWidgetColor: Colors.white
            ),
            child:Stack(
                children: [
                  Container(
                    color: Colors.blue,
                  ),

                  Container(
                    child:SingleChildScrollView
                      (
                        child:Column(
                          children: [
                            Padding(
                                child:Center(
                                    child:Text("Login",style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),)
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
                                              onChanged:(value) => giocatore.nome_utente=value,
                                              controller: _username,
                                              decoration: InputDecoration(
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
                                              onChanged: (value) => giocatore.password=value,
                                              controller: _password,
                                              obscureText: true,
                                              decoration: InputDecoration(
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
                                        Row(
                                            children: [
                                              Expanded(
                                                child:
                                                ListTile(
                                                    title: const Text('Giocatore',style: TextStyle(
                                                        color:Colors.white
                                                    )),
                                                    leading: Radio<user>(
                                                      activeColor: Colors.white,
                                                      value: user.Giocatore,
                                                      groupValue: _type,
                                                      onChanged: (user? value) {
                                                        setState(() {
                                                          _type = value;
                                                        });
                                                        _type = value;
                                                      },
                                                    )
                                                ),
                                              ),
                                              Expanded(
                                                child: ListTile(
                                                    title: const Text('Centro Sportivo',style: TextStyle(
                                                        color:Colors.white
                                                    ),),
                                                    leading: Radio<user>(
                                                      activeColor: Colors.white,
                                                      value: user.Amministratore,
                                                      groupValue: _type,
                                                      onChanged: (user? value) {
                                                        setState(() {
                                                          _type = value;
                                                        });
                                                      },
                                                    )
                                                ),
                                              ),
                                            ]),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15.0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.white),
                                            onPressed: () {
                                              // Validate returns true if the form is valid, or false otherwise.
                                              if (_formKey.currentState!.validate()) {
                                                Login(_username,_password,_type);
                                                getGiocatore(giocatore).then((giocatori)=>
                                                {
                                                  print(giocatori),
                                                  if(giocatori != null){
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context){
                                                          return MyHomeGio(giocatore:giocatori);
                                                        }
                                                    ))
                                                  }

                                                });
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
                                          onPressed: (){
                                           Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return MyCustomFormGiocatore();
                                           }
                                           ));

                                          }
                                          , child: Text("Registrati come giocatore")
                                      ),ElevatedButton(
                                                onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                                    return MyCustomFormAmministratoreCS();
                                                  }
                                                  ));

                                                }
                                                , child: Text("Registrati come Amministratore centro sportivo")
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