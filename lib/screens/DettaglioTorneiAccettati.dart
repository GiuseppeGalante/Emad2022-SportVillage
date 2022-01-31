import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/ComponenteSquadra.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/Squadre.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/RichiestaTorneo.dart';
import 'package:flutter_app_emad/entity/TorneiAccettati.dart';
import 'package:flutter_app_emad/entity/TorneiRifiutati.dart';
import 'package:flutter_app_emad/screens/DettaglioSquadreTorneo.dart';
import 'package:flutter_app_emad/screens/home.dart';
//import 'package:flutter_app_emad/screens/GestioneSquadre.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestaTorneo.dart';
import 'package:flutter_app_emad/screens/visualizzaRichiestePartita.dart';

class DettaglioTorneoAccettato extends StatelessWidget {


  const DettaglioTorneoAccettato({required this.torneo,required this.giocatore, required this.squadre,Key? key,}) : super(key: key);
  final TorneoAccettato torneo;
  final Giocatore giocatore;
  final List<Squadra> squadre;
  static const appTitle = 'home sport village';


  @override
  Widget build(BuildContext context) {
    print(torneo);
    return Scaffold(
      appBar: AppBar(
        title: Text("Squadre Torneo "+torneo.nome),
      ),

      body: DettaglioTorneoAccettatoState(torneo:torneo, giocatore:giocatore,squadre: squadre,),

    );
  }
}
class DettaglioTorneoAccettatoState extends StatefulWidget
{
  var title;
  final TorneoAccettato torneo;
  final Giocatore giocatore;
  List<Squadra> squadre;
  DettaglioTorneoAccettatoState({Key? key,required this.torneo,required this.giocatore,required this.squadre}) : super(key: key);
  @override
  _DettaglioTorneoState createState() => _DettaglioTorneoState(torneo: torneo,giocatore: giocatore,squadre: squadre);
}

class _DettaglioTorneoState extends State<DettaglioTorneoAccettatoState> {

  var title;
  final TorneoAccettato torneo;
  final Giocatore giocatore;
  List<Squadra> squadre=[];
  String _value="";
  _DettaglioTorneoState({Key? key,required this.torneo,required this.giocatore,required this.squadre});
  @override
  Widget build(BuildContext context) {
    print("TORNEO:  "+torneo.id_torneo);
    return Scaffold(
      body: SafeArea(
          child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height:MediaQuery.of(context).size.height-155,
                  child: ListView.builder(
                  itemCount: (torneo.numero_di_partecipanti).toInt(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                        children: <Widget>
                        [
                          Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 5.0,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                child: ListTile(

                                  leading:Icon(Icons.group_add, size: 50,color: Colors.blueGrey),
                                  title:Text(squadre[index].nome, style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  )),
                                  subtitle: (){
                                    if(squadre[index].partecipanti<squadre[index].max_partecipanti)
                                    {
                                      return Text("Prenotazioni Aperte",style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),);
                                    }else
                                      {
                                        return Text("Prenotazioni Chiuse",style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),);
                                      }
                                  }(),
                                    trailing: PopupMenuButton(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 20
                                              ),
                                              child:Icon(Icons.more_vert, size: 30,color: Colors.blueGrey),
                                            ),
                                        onSelected: (value) {
                                          setState(() {
                                            _value=value.toString();
                                            if(_value=="1")
                                              {
                                                if(squadre[index].partecipanti<squadre[index].max_partecipanti) {
                                                  showDialog<String>(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (
                                                          BuildContext context_alert) =>
                                                          AlertDialog(
                                                            title: const Text(
                                                                'Aggiunta alla squadra'),
                                                            content: const Text(
                                                                'Vuoi entrare in questa squadra?'),
                                                            actions: <Widget>[
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context_alert,
                                                                      'Cancel');
                                                                },
                                                                child: const Text('NO'),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () async {
                                                                  Navigator.pop(
                                                                      context_alert, 'OK');
                                                                  if (squadre[index].partecipanti < squadre[index].max_partecipanti) {
                                                                    Squadra s = new Squadra();
                                                                    Componente componente=new Componente();
                                                                    componente.id_squadra=squadre[index].id_squadra;
                                                                    componente.nome_utente=giocatore.nome_utente;
                                                                    componente.id_giocatore=giocatore.id.key!;
                                                                    var flag=1;
                                                                    var nflag=1;
                                                                    var j=0;
                                                                    var indice=0;
                                                                    var stop=0;
                                               while(j<squadre.length) {
                                                        await getComponenti(squadre[j].id_squadra.toString()).then((value) =>
                                                        {
                                                         for(int i = 0; i < value.length; i++)
                                                         {
                                                            if(value[i].id_giocatore == componente.id_giocatore)
                                                           {
                                                               nflag = 0,
                                                               print("FLAG INTERNO "+nflag.toString()),

                                                           },
                                                         },
                                                         }).whenComplete(() => (flag=flag & nflag));
                                                        print("Fine: "+(flag).toString());
                                                            j++;

                                              }
                                              //print("Evviva: "+flag.toString());






                                               if(flag==1)
                                                {
                                                s.aggiungiComponente(squadre[index].id_squadra.toString(),squadre[index].partecipanti +1);
                                                saveComponente(componente);
                                                if((squadre[index].partecipanti+1)==squadre[index].max_partecipanti)
                                                  {
                                                    TorneoAccettato t=new TorneoAccettato();
                                                    t.aggiungiSquadraCompletata(torneo.id.key.toString());
                                                  }


                                                ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                content: const Text(
                                                'Aggiunta Effettuata'),
                                                backgroundColor: Colors
                                                    .green,
                                                action: SnackBarAction(
                                                textColor: Colors
                                                    .white,
                                                label: 'OK',
                                                onPressed: () {},),
                                                ),
                                                );
                                                getSquadre(
                                                torneo.id_torneo).then((value) =>
                                                {
                                                Navigator.push(context,MaterialPageRoute(
                                                builder: (context) {
                                                return DettaglioTorneoAccettato(
                                                torneo: torneo,
                                                giocatore: giocatore,
                                                squadre: value);
                                                }
                                                ))
                                                }
                                                );
                                                }
                                               else
                                               {
                                                 ScaffoldMessenger.of(context).showSnackBar(
                                                   SnackBar(
                                                     content: const Text(
                                                         'Sei già iscritto ad una squadra'),
                                                     backgroundColor: Colors
                                                         .red,
                                                     action: SnackBarAction(
                                                       textColor: Colors
                                                           .white,
                                                       label: 'OK',
                                                       onPressed: () {},),
                                                   ),
                                                 );
                                               }





                                                                  }
                                                                },
                                                                child: const Text('SI'),
                                                              ),

                                                            ],
                                                          )
                                                  );
                                                }
                                              }
                                            else if(_value=="2")
                                              {
                                                getComponenti(squadre[index].id_squadra).then((value) =>
                                                {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (
                                                              context) {
                                                            return DettaglioSquadraTorneo(
                                                                squadra: squadre[index],
                                                                giocatore: giocatore,
                                                                componenti: value);
                                                          }
                                                      ))
                                                }
                                                );
                                              }
                                          });
                                        },
                                      itemBuilder: (context) =>[
                                      PopupMenuItem(
                                        child: ListTile(
                                          leading: Icon(Icons.add),
                                          title: Text('Aggiungiti'),
                                        ),
                                        value: "1",
                                      ),
                                        const PopupMenuItem(
                                          child: ListTile(
                                            leading: Icon(Icons.info),
                                            title: Text('Visualizza'),
                                          ),
                                          value:"2",
                                        ),
                                        ]
                                        ),


                                    /*Text((){
                                      if(squadre[index].partecipanti<squadre[index].max_partecipanti)
                                      {
                                        return squadre[index].partecipanti.toString()+"/"+squadre[index].max_partecipanti.toString();
                                      }
                                      else
                                        {
                                          return "Esauriti";
                                        }
                                    }())*/
                                    onTap: ()
                                    {
                                    }
                                    )
                            ),
                          ),
                          SizedBox(
                              height: 10.0
                          ),
                        ]);
                  }
                  ),
                ),
              ]
            )
          ),
    );
  }
}
