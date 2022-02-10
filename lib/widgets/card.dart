import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  final Color cardColor;
  final String title;


  Card({
    required this.cardColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(

        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(10.0),
        height: 100,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
           child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),

              ],
            ),

        ),

    );
  }
}
