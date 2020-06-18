import 'package:flutter/material.dart';

class EggScore extends StatelessWidget {
  final int score;

  EggScore(this.score);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          score.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(right: 6),
        ),
        Image(
          image: AssetImage('assets/egglogo.png'),
        )
      ],
    );
  }
}
