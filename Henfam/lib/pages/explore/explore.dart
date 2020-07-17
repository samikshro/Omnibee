import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';

import './lilBigButtons.dart';
import './lilMode.dart';
import 'package:Henfam/pages/explore/big_explore/bigMode.dart';
import './locationEggScore.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  var _isLil = true;
  var _location = "Olin Library";
  var _score = 500;

  // void _switchToLil() {
  //   setState(() {
  //     _isLil = true;
  //   });
  // }

  void _switchToBig() {
    // setState(() {
    //   _isLil = false;
    // });
    Navigator.pushNamed(context, '/bigmode');
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Column(children: <Widget>[
                // LocationEggScore(score: _score, location: _location),
                // LilBigSwitch(_switchToLil, _switchToBig),
                RaisedButton(
                  child: Text(
                    "Run an Errand",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _switchToBig,
                ),
              ]),
              // (_isLil) ? LilMode(_activities) : BigMode(),
              LilMode(_activities)
            ],
          ),
        ),
      ),
    );
  }
}
