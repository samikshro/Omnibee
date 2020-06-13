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
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Location(location),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: EggScore(score),
          ),
        ]);
  }
}
