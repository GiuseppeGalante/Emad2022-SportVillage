import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'package:splashscreen/splashscreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Splash2(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: MainLogin(),
      loadingText: Text("Loading"),
      photoSize: 200.0,
      backgroundColor: Colors.blue,
      image: Image(image:AssetImage("assets/images/logo.png")),
      loaderColor: Colors.white,
    );
  }
}