import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';

class LilBigSwitch extends StatelessWidget {
  final Function switchMode;
  final bool isLil;

  LilBigSwitch(this.switchMode, this.isLil);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 5),
          height: 50,
          width: 150,
          child: CustomSwitch(
            activeColor: Colors.amber,
            value: isLil,
            onChanged: switchMode,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        ),
        Image(
          image: AssetImage('assets/hen.png'),
        )
      ],
    );
  }
}
