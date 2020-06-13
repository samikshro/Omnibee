import 'package:flutter/material.dart';

import './eggScore.dart';
import './location.dart';

class LocationEggScore extends StatelessWidget {
  final int score;
  final String location;

  LocationEggScore({
    @required this.score,
    @required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 15),
      ),
      Location(location),
      Padding(
        padding: EdgeInsets.only(right: 225),
      ),
      EggScore(score),
    ]);
  }
}
