import 'package:firebase_database/firebase_database.dart';

enum Sesso{
  maschio,
  femmina,
  altro
}

abstract class Utente
{
  late DatabaseReference id;
  String nome="";
  String cognome="";
  String nome_utente="";
  String password="";
  String indirizzo="";
  String numero_di_telefono="";
  String email="";
  String data_di_nascita="";
  Sesso sesso=Sesso.maschio;
  String ?bio;

  @override
  String toString() {
    return 'Utente{id: ${id.toString()}, nome: $nome, cognome: $cognome, nome_utente: $nome_utente, password: $password, indirizzo: $indirizzo, numero_di_telefono: $numero_di_telefono, email: $email, data_di_nascita: $data_di_nascita, sesso: $sesso, bio: $bio}';
  }
}