
import 'package:flutter/material.dart';
import 'package:flutter_app_emad/widgets/signup_clipper.dart';

class SignUpContainer extends StatelessWidget {
  const SignUpContainer({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipperTwo(),
          child: Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Color.fromRGBO(91, 192, 235, 1),
            ),
          ),
        ),
        ClipPath(
          clipper: WaveClipperOne(),
          child: Container(
            height: MediaQuery.of(context).size.height * .55,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Color.fromRGBO(253, 231, 76, 1),
            ),
          ),
        ),

      ],
    );
  }
}