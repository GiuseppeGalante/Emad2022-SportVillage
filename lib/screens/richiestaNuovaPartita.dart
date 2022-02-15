import 'dart:async';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/entity/AmministratoreCentroSportivo.dart';
import 'package:flutter_app_emad/entity/Campo.dart';
import 'package:flutter_app_emad/entity/CentroSportivo.dart';
import 'package:flutter_app_emad/entity/Giocatore.dart';
import 'package:flutter_app_emad/entity/Prenotazioni.dart';
import 'package:flutter_app_emad/entity/RichiestaNuovaPartita.dart';
import 'package:flutter_app_emad/entity/Sport.dart';
import 'package:flutter_app_emad/entity/Utente.dart';
import 'package:flutter_app_emad/screens/Home_Nuova.dart';
import 'package:flutter_app_emad/screens/homeACS.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../animation/FadeAnimation.dart';
import '../widgets/signupContainer.dart';
import 'InfoCentroSportivo.dart';
import 'home.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';



// Create a Form widget.
class FormRichiestaNuovaPartita extends StatefulWidget {
  Giocatore giocatore;
  //CentroSportivo centroSportivo;
  List<CentroSportivo>centrisportivi=[];
  FormRichiestaNuovaPartita({required this.giocatore, required this.centrisportivi, Key? key}) : super(key: key);

  @override
  _FormRichiestaNuovaPartitaState createState() => _FormRichiestaNuovaPartitaState();

}

// Create a corresponding State class.
// This class holds data related to the form.
class _FormRichiestaNuovaPartitaState extends State<FormRichiestaNuovaPartita> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _pswKey = GlobalKey<FormFieldState>();


  DateTime selectedDate = DateTime.now();
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 0);


  bool late=false;
  late String _idCentro="";
  late CentroSportivo centroSportivo = getCentroSportivo(_idCentro) as CentroSportivo;
  List<CentroSportivo> filtered=[];

  String idAdmin="";
  RichiestaNuovaPartita richiestaNuovaPartita = RichiestaNuovaPartita();
  List<int> partecipanti=[];
  int? n_partecipanti=null;

  String nomeCampo="";
  late Map<String, Campo> mapping_campo = new Map();
  List<Campo> campi=[];

  String _idCampo="";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showMonthPicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {

        selectedDate = picked;
        richiestaNuovaPartita.data=selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString();
      });
    }


    var days= daysInMonth(selectedDate);
    var listOfDates = new List<int>.generate(days, (i) => i + 1);
    print(listOfDates);
    _days=listOfDates;

  }

  int daysInMonth(DateTime date){
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  /*Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {

        selectedDate = picked;
        richiestaNuovaPartita.data=selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString();
      });
    }
  }*/

  /*Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      builder: (context, child) =>
          MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!,),

    );

    if (picked_s != null && picked_s != selectedTime && picked_s.minute==0) {
      setState(() {

        selectedTime = picked_s;
        richiestaNuovaPartita.orario= selectedTime.hour.toString()+":"+selectedTime.minute.toString()+"0";
      });
    }
    else
      {
        if(picked_s?.minute==0) {
          richiestaNuovaPartita.orario= selectedTime.hour.toString()+":"+selectedTime.minute.toString()+"0";
        }else
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Orario non disponibile'),
              backgroundColor: LightColors.kRed,
              action: SnackBarAction(textColor:LightColors.kLightYellow,
                label: 'OK', onPressed: () {},),
            ),
          );
        }
      }
  }*/

  void onTimeChanged(TimeOfDay newTime) {
    if (newTime != null && newTime != _time) {
      setState(() {

        _time= newTime;
        _selectedHour=_time.hour.toString()+":"+newTime.minute.toString()+"0";
        richiestaNuovaPartita.orario= _time.hour.toString()+":"+newTime.minute.toString()+"0";
      });
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Orario non disponibile'),
          backgroundColor: Colors.red,
          action: SnackBarAction(textColor:Colors.white,
            label: 'OK', onPressed: () {},),
        ),
      );
    }
  }


  late Map<String,CentroSportivo> mapping=new Map();

  int _selectedDay = 2;
  int _selectedRepeat = 0;
  String _selectedHour = '9:00';
  List<int> _selectedExteraCleaning = [];

  ItemScrollController _scrollController = ItemScrollController();

  final List<String>_month=[
    "Gennaio",
    "Febbraio",
    "Marzo",
    "Aprile",
    "Maggio",
    "Giugno",
    "Luglio",
    "Agosto",
    "Settembre",
    "Ottobre",
    "Novembre",
    "Dicembre",
  ];

  List<dynamic> _days= [1,2,3,4,5,6,7,8,9,10];

  final List<String> _hours = <String>[
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
  ];

  final List<String> _repeat = [
    'No repeat',
    'Every day',
    'Every week',
    'Every month'
  ];

  final List<dynamic> _exteraCleaning = [
    ['Washing', 'https://img.icons8.com/office/2x/washing-machine.png', '10'],
    ['Fridge', 'https://img.icons8.com/cotton/2x/fridge.png', '8'],
    ['Oven', 'https://img.icons8.com/external-becris-lineal-color-becris/2x/external-oven-kitchen-cooking-becris-lineal-color-becris.png', '8'],
    ['Vehicle', 'https://img.icons8.com/external-vitaliy-gorbachev-blue-vitaly-gorbachev/2x/external-bycicle-carnival-vitaliy-gorbachev-blue-vitaly-gorbachev.png', '20'],
    ['Windows', 'https://img.icons8.com/external-kiranshastry-lineal-color-kiranshastry/2x/external-window-interiors-kiranshastry-lineal-color-kiranshastry-1.png', '20'],
  ];

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      _scrollController.scrollTo(
        index: 24,
        duration: Duration(seconds: 3),
        curve: Curves.easeInOut,
      );
    });

    super.initState();
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
    Giocatore giocatore=widget.giocatore;
    List<CentroSportivo>centrisportivi=widget.centrisportivi;

    return Scaffold(
        backgroundColor: Colors.white,
        body:
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: SizedBox(
                    height: 2500,
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
                                  child: FadeAnimation(1, Padding(
                                    padding: EdgeInsets.only(top: 60.0, right: 20.0, left: 20.0),
                                    child: Text(
                                      'Richiesta nuova \npartita',
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.grey.shade900,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ))
                            ];
                          },
                          body:
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(height: 20,),
                                  FadeAnimation(1, Row(
                                    children: [
                                      Text(_month[selectedDate.month-1], style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      Spacer(),
                                      IconButton(
                                        padding: EdgeInsets.all(0),
                                        onPressed: () => _selectDate(context),
                                        icon: Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.grey.shade700,),
                                      )
                                    ],
                                  )),
                                  Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(width: 1.5, color: Colors.grey.shade200),
                                    ),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _days.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return FadeAnimation((1 + index) / 6, GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectedDay = _days[index];
                                                richiestaNuovaPartita.data=_selectedDay.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString();
                                                //print(richiestaNuovaPartita.data);
                                              });
                                            },
                                            child: AnimatedContainer(
                                              duration: Duration(milliseconds: 300),
                                              width: 62,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: _selectedDay.toString() == _days[index].toString() ? Colors.blue.shade100.withOpacity(0.5) : Colors.blue.withOpacity(0),
                                                border: Border.all(
                                                  color: _selectedDay.toString() == _days[index].toString() ? Colors.blue : Colors.white.withOpacity(0),
                                                  width: 1.5,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(_days[index].toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                            ),
                                          ));
                                        }
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  FadeAnimation(1.2, Text("Scegli l'ora", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                                  SizedBox(height: 10,),
                                  FadeAnimation(1.2, Container(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: ()=>{

                                              Navigator.of(context).push(
                                                showPicker(
                                                  context: context,
                                                  value: _time,
                                                  onChange: onTimeChanged,
                                                  is24HrFormat:true,
                                                  disableMinute:true,
                                                  minHour:9,
                                                  maxHour:22,
                                                  blurredBackground: true,
                                                  // Optional onChange to receive value as DateTime
                                                  onChangeDateTime: (DateTime dateTime) {
                                                    print(dateTime);
                                                  },
                                                ),
                                              )

                                          },
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.network("https://i.ibb.co/zSBj40J/output-onlinegiftools-6.gif",width: 50,),
                                              Text("Ora selezionata: "+_selectedHour, style: GoogleFonts.alata(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                            ],
                                          ) ,
                                        )


                                      ],
                                    ),
                                  ),
                                      /*Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(width: 1.5, color: Colors.grey.shade200),
                                    ),
                                    child: ScrollablePositionedList.builder(
                                        itemScrollController: _scrollController,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _hours.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              onTimeChanged(new TimeOfDay(hour: int.parse(_hours[index]), minute: 0));
                                              setState(() {
                                                _selectedHour = _hours[index];
                                              });
                                              print(_time);
                                            },
                                            child: AnimatedContainer(
                                              duration: Duration(milliseconds: 300),
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: _selectedHour == _hours[index] ? Colors.orange.shade100.withOpacity(0.5) : Colors.orange.withOpacity(0),
                                                border: Border.all(
                                                  color: _selectedHour == _hours[index] ? Colors.orange : Colors.white.withOpacity(0),
                                                  width: 1.5,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(_hours[index]+":00", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  )*/
                                  ),
                                  SizedBox(height: 10,),
                                  FadeAnimation(1.2, Text("Scegli sport", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                                  SizedBox(height: 10,),
                                  Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left:12),
                                        child:DropdownButtonFormField<Sport>(
                                          isExpanded: true,
                                          hint: Text("Scegli Sport",style: TextStyle(
                                            color: LightColors.kDarkBlue,
                                            fontWeight: FontWeight.w800,
                                          ),),
                                          onChanged: (value){
                                            setState(() {
                                              richiestaNuovaPartita.sport=new SportClass(value!);
                                              filtered=[];
                                              n_partecipanti=richiestaNuovaPartita.sport.partecipanti.first;
                                              partecipanti=richiestaNuovaPartita.sport.partecipanti;
                                              for(int i=0;i<centrisportivi.length;i++)
                                              {

                                                for(int k=0; k<centrisportivi[i].campi.length;k++) {
                                                  print(centrisportivi[i].campi[k].tipo.sport.toString()+":"+value.toString());
                                                  if(centrisportivi[i].campi[k].tipo.sport.toString() == value.toString() && !filtered.contains(centrisportivi[i])) {
                                                    filtered.add(centrisportivi[i]);
                                                    _idCentro=filtered[0].nome!;
                                                  }
                                                }
                                              }
                                            });
                                          },
                                          validator: (value){
                                            if(value==null)
                                            {
                                              return "Campo obbligatorio";
                                            }
                                          },
                                          onSaved: (value) => richiestaNuovaPartita.sport=new SportClass(value!),
                                          items: [
                                            DropdownMenuItem<Sport>(
                                              child: Text("Calcio",style: TextStyle(color:LightColors.kDarkBlue),),
                                              value: Sport.calcio,
                                            ),DropdownMenuItem<Sport>(
                                              child: Text("Pallavolo",style: TextStyle(color:LightColors.kDarkBlue),),
                                              value: Sport.pallavolo,
                                            ),DropdownMenuItem<Sport>(
                                              child: Text("Tennis",style: TextStyle(color:LightColors.kDarkBlue),),
                                              value: Sport.tennis,
                                            ),DropdownMenuItem<Sport>(
                                              child: Text("Padel",style: TextStyle(color:LightColors.kDarkBlue),),
                                              value: Sport.padel,
                                            ),DropdownMenuItem<Sport>(
                                              child: Text("Ping Pong",style: TextStyle(color:LightColors.kDarkBlue),),
                                              value: Sport.pingpong,
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  SizedBox(height: 20,),
                                  FadeAnimation(1.4, Text("Centro Sportivo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 50,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child:
                                    Padding(
                                      padding: EdgeInsets.only(left:18),
                                      child:
                                      SizedBox(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              hint: Text('Seleziona centro',style: TextStyle(
                                                color: LightColors.kDarkBlue,
                                                fontWeight: FontWeight.w800,
                                              ),),
                                              value: _idCentro,
                                              onChanged: (value) {
                                                setState(() {
                                                  _idCentro=value!;
                                                });
                                                getCampiBySport(mapping[_idCentro]!.id.key.toString(), richiestaNuovaPartita.sport.sport.toString().substring(6)).then((value) => campi = value).whenComplete(() =>{
                                                  setState(() {
                                                    _idCampo = campi[0].nome;
                                                  })
                                                });
                                              },
                                              items: filtered.map((e) {
                                                mapping[e.nome!]=e;
                                                //print(e);
                                                return DropdownMenuItem<String>(
                                                  child: new Text(e.nome!),
                                                  value: e.nome,

                                                );

                                              }
                                              ).toList(),
                                            ),


                                      ),
                                    ),

                                  ),
                                  SizedBox(height: 20,),
                                  FadeAnimation(1.4, Text("Campo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 50,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child:
                                    Padding(
                                      padding: EdgeInsets.only(left:18),
                                      child:
                                      SizedBox(
                                            child: DropdownButtonFormField<String>(
                                              isExpanded: true,
                                              hint: Text('Scegli un campo',style: TextStyle(
                                                color: LightColors.kDarkBlue,
                                                fontWeight: FontWeight.w800,
                                              ),),
                                              onChanged: (value) {
                                                setState(() {
                                                  nomeCampo = value!;
                                                });
                                              },
                                              validator: (value) {
                                                if (value == null) {
                                                  return "Campo obbligatorio";
                                                }
                                              },
                                              items: campi.map((e) {
                                                mapping_campo[e.nome] = e;
                                                return DropdownMenuItem<String>(
                                                  child: new Text(e.nome),
                                                  value: e.nome,

                                                );
                                              }
                                              ).toList(),
                                            ),


                                      ),
                                    ),

                                  ),
                                  SizedBox(height: 20,),
                                  FadeAnimation(1.4, Text("Seleziona numero di partecipanti", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 50,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child:
                                    Padding(
                                      padding: EdgeInsets.only(left:18),
                                      child:
                                      SizedBox(
                                        child: DropdownButton<int>(
                                          isExpanded: true,
                                          hint: Text('Seleziona numero di partecipanti',style: TextStyle(
                                            color: LightColors.kDarkBlue,
                                            fontWeight: FontWeight.w800,
                                          ),),
                                          value: n_partecipanti,
                                          onChanged: (value){
                                            setState(() {
                                              richiestaNuovaPartita.numero_di_partecipanti=value!;
                                              n_partecipanti=value;
                                            });
                                          },
                                          items: partecipanti.map((e)
                                          {
                                            return DropdownMenuItem<int>(
                                              child: new Text(e.toString(),style: TextStyle(
                                                color: LightColors.kDarkBlue,
                                                fontWeight: FontWeight.w800,
                                              ),),
                                              value: e,
                                            );
                                          }

                                          ) .toList(),
                                        ),


                                      ),
                                    ),

                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    alignment: AlignmentDirectional.center,
                                    height: 50,
                                    margin: const EdgeInsets.only(bottom: 20.0),
                                    child:ElevatedButton(

                                      style: ElevatedButton.styleFrom(

                                        primary: LightColors.kLightYellow,
                                      ),
                                      onPressed: (){
                                        if(_formKey.currentState!.validate()){
                                          print("Nessun errore");
                                          List<String> data_divisa=[];
                                          List<String> ora_divisa=[];
                                          data_divisa=richiestaNuovaPartita.data.split("/");
                                          print(data_divisa);
                                          ora_divisa=richiestaNuovaPartita.orario.split(":");
                                          DateTime d=new DateTime(int.parse(data_divisa[2]),int.parse(data_divisa[1]),int.parse(data_divisa[0]));
                                          TimeOfDay t=new TimeOfDay(hour: int.parse(ora_divisa[0]), minute: int.parse(ora_divisa[1]));
                                          print(d);
                                          print(t);
                                          getPrenotazioni(mapping_campo[nomeCampo]!.id.key!,d,t).then((value) =>
                                          {
                                            print(mapping_campo[nomeCampo]!.id.key!),
                                            if(value==true)
                                              {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: const Text('Orario già occupato'),
                                                    backgroundColor: LightColors.kRed,
                                                    action: SnackBarAction(textColor:Colors.white,
                                                      label: 'OK', onPressed: () {},),
                                                  ),
                                                )
                                              }else
                                              {
                                                _formKey.currentState?.save(),
                                                richiestaNuovaPartita.id_giocatore=giocatore.id.key!,
                                                richiestaNuovaPartita.id_centro_sportivo=mapping[_idCentro]!.id.key,
                                                richiestaNuovaPartita.id_amministratore=mapping[_idCentro]!.id_amministratore!,
                                                richiestaNuovaPartita.campo=mapping_campo[_idCampo]!.id.key!,
                                                saveRichiestaNuovaPartita(richiestaNuovaPartita),
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: const Text('Richiesta partita effettuata con successo'),
                                                    backgroundColor: LightColors.kGreen,
                                                    action: SnackBarAction(textColor:Colors.white,
                                                      label: 'OK', onPressed: () {},),
                                                  ),
                                                ),
                                                Timer(Duration(seconds: 2), ()
                                                {
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context){
                                                        return HomeGiocatore(giocatore:giocatore);
                                                      }
                                                  ));
                                                }),
                                              }
                                          },
                                          );

                                        }

                                      }
                                      , child: Text("Richiedi nuova partita",
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: LightColors.kDarkBlue,
                                        fontWeight: FontWeight.w800,
                                      ),),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          )
                        ),

                      ],
                    )
                ),
              ),
            )

    );
  }

}

