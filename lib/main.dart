import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_emad/theme/colors/light_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      backgroundColor: LightColors.kDarkYellow,
      image: Image(image:AssetImage("assets/images/logo.png")),
      loaderColor: Colors.white,
    );
  }
}