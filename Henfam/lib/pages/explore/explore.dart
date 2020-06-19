import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';

import './lilBigButtons.dart';
import './lilMode.dart';
import './bigMode.dart';
import './locationEggScore.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  var _isLil = true;
  var _location = "Olin Library";
  var _score = 500;

  void _switchToLil() {
    setState(() {
      _isLil = true;
    });
  }

  void _switchToBig() {
    setState(() {
      _isLil = false;
    });
  }

  final _activities = const [
    {
      'picture': Image(
        image: AssetImage('assets/activity1.png'),
      ),
      'caption': 'Getting Food from Collegetown',
    },
    {
      'picture': Image(
        image: AssetImage('assets/activity2.png'),
      ),
      'caption': 'Getting Food from Campus',
    },
    {
      'picture': Image(
        image: AssetImage('assets/activity3.png'),
      ),
      'caption': 'Shopping for Groceries',
    },
    {
      'picture': Image(
        image: AssetImage('assets/activity4.png'),
      ),
      'caption': 'Shopping for General Items',
    },
    {
      'picture': Image(
        image: AssetImage('assets/activity5.png'),
      ),
      'caption': 'Other Errands',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Column(children: <Widget>[
                LocationEggScore(score: _score, location: _location),
                LilBigSwitch(_switchToLil, _switchToBig),
              ]),
              (_isLil) ? LilMode(_activities) : BigMode(),
            ],
          ),
        ),
      ),
    );
  }
}
