import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/home.dart';

class InfoPersonaliGiocatore extends StatelessWidget {

  const InfoPersonaliGiocatore({required this.giocatore,Key? key}) : super(key: key);
  final Giocatore giocatore;
  static const appTitle = 'home sport village';


  @override
  Widget build(BuildContext context) {
    print(giocatore);
    return MaterialApp(
      title: appTitle,
      home: InfoPersonaliGiocatoreState(title: appTitle, giocatore:giocatore),
    );
  }
}
class InfoPersonaliGiocatoreState extends StatefulWidget
{
  var title;
  final Giocatore giocatore;

  InfoPersonaliGiocatoreState({Key? key, required this.title, required this.giocatore}) : super(key: key);
  @override
  _InfoPersonaliGiocatore createState() => _InfoPersonaliGiocatore(title: title,giocatore: giocatore);
}



class _InfoPersonaliGiocatore extends State<InfoPersonaliGiocatoreState> {
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


  final TextEditingController _nome = TextEditingController();
  final TextEditingController _cognome = TextEditingController();
  final TextEditingController _nazionalita = TextEditingController();
  final TextEditingController _ddn = TextEditingController();
  final TextEditingController _sesso = TextEditingController();
  final TextEditingController _indirizzo = TextEditingController();

  final List<Widget> star = <Widget>[Icon(Icons.star, size:50, color: Colors.blueGrey,),
    Icon(Icons.star, size:50, color: Colors.blueGrey,),
    Icon(Icons.star, size:50, color: Colors.blueGrey,),
    Icon(Icons.star_half, size:50, color: Colors.blueGrey,),
  ];

  var title;
  final Giocatore giocatore;
  _InfoPersonaliGiocatore({Key? key,required this.title,required this.giocatore});
  @override
  Widget build(BuildContext context) {
    if(giocatore.bio=="")
      giocatore.bio="Nessuna Biografia";
    return MaterialApp(
        home:Scaffold(
          appBar: AppBar(
            title: Text("Informazioni Personali"),
          ),
          body: Container(
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
                            color: Colors.white,
                            elevation: 5.0,
                            child:ListTile(
                              leading: Icon(Icons.person,size: 50,color:Colors.blueGrey),
                              title: Text("Nome",style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )),
                              subtitle:TextFormField(
                                onChanged:(value) => {
                                giocatore.nome=value,
                              },
                                controller: _nome,
                                decoration: InputDecoration(
                                  alignLabelWithHint: true,
                                  hintText: giocatore.nome,
                                  fillColor: Colors.white,
                                ),
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    fontSize: 20.0
                                  ),
                                  validator: (nome) {
                                    if (nome!.length == 0)
                                     {
                                      return 'Campo Obbligatorio';
                                     }
                                  }
                              ),
                            )
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child:ListTile(
                              leading: Icon(Icons.person,size: 50,color:Colors.blueGrey),
                              title: Text("Nome",style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )),
                              subtitle:TextFormField(
                                  onChanged:(value) => {
                                    giocatore.cognome=value,
                                  },
                                  controller: _cognome,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: giocatore.cognome,
                                    fillColor: Colors.white,
                                  ),
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                      fontSize: 20.0
                                  ),
                                  validator: (cognome) {
                                    if (cognome!.length == 0)
                                    {
                                      return 'Campo Obbligatorio';
                                    }
                                  }
                              ),
                            )
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child:ListTile(
                              leading: Icon(Icons.info,size: 50,color:Colors.blueGrey),
                              title: Text("Sesso",style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )),
                              subtitle:TextFormField(
                                  onChanged:(value) => {
                                    giocatore.sesso=value.toLowerCase() as Sesso,
                                  },
                                  controller: _sesso,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: giocatore.sesso.name[0].toUpperCase()+giocatore.sesso.name.substring(1),
                                    fillColor: Colors.white,
                                  ),
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                      fontSize: 20.0
                                  ),
                                  validator: (nome) {
                                    if (nome!.length == 0)
                                    {
                                      return 'Campo Obbligatorio';
                                    }
                                  }
                              ),
                            )
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child:ListTile(
                              leading: Icon(Icons.calendar_today,size: 50,color:Colors.blueGrey),
                              title: Text("Data di Nascita",style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )),
                              subtitle:TextFormField(
                                  onChanged:(value) => {
                                    giocatore.data_di_nascita=value,
                                  },
                                  controller: _ddn,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: giocatore.data_di_nascita,
                                    fillColor: Colors.white,
                                  ),
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                      fontSize: 20.0
                                  ),
                                  validator: (ddn) {
                                    if (ddn!.length == 0)
                                    {
                                      return 'Campo Obbligatorio';
                                    }
                                    else
                                      {
                                        if(ddn.length>10 || ddn.length<10)
                                          {
                                            return 'Data Non Valida';
                                          }
                                      }
                                  }
                              ),
                            )
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child:ListTile(
                              leading: Icon(Icons.home,size: 50,color:Colors.blueGrey),
                              title: Text("Indirizzo",style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )),
                              subtitle:TextFormField(
                                  onChanged:(value) => {
                                    giocatore.indirizzo=value,
                                  },
                                  controller: _indirizzo,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: giocatore.indirizzo,
                                    fillColor: Colors.white,
                                  ),
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                      fontSize: 20.0
                                  ),
                                  validator: (indirizzo) {
                                    if (indirizzo!.length == 0)
                                    {
                                      return 'Campo Obbligatorio';
                                    }
                                  }
                              ),
                            )
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                            margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child:ListTile(
                              leading: Icon(Icons.flag,size: 50,color:Colors.blueGrey),
                              title: Text("Nazionalità",style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              )),
                              subtitle:TextFormField(
                                  onChanged:(value) => {
                                    giocatore.nazionalita=value,
                                  },
                                  controller: _nazionalita,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    hintText: giocatore.nazionalita,
                                    fillColor: Colors.white,
                                  ),
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                      fontSize: 20.0
                                  ),
                                  validator: (nazionalita) {
                                    if (nazionalita!.length == 0)
                                    {
                                      return 'Campo Obbligatorio';
                                    }
                                  }
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ElevatedButton(
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
                        /*Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return DettaglioGio(giocatore:giocatore);
                            }
                        ));*/
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [Colors.blue,Colors.lightBlueAccent]
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text("Salva",
                            style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight:FontWeight.w300),
                          ),
                        ),
                      )
                  )

                ]
            ),


          ),

          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Ricerca Partita',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
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