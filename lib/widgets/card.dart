import 'package:flutter/material.dart';

class Cards  extends StatelessWidget {
  final Color cardColor;
  final String title;


  Cards({
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
        height: 140,
        width: 190,
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
                    leadingDistribution: TextLeadingDistribution.even,

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
