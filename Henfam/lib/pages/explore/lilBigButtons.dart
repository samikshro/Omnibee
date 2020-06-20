import 'package:flutter/material.dart';

class LilBigSwitch extends StatelessWidget {
  final Function switchToLil;
  final Function switchToBig;

  LilBigSwitch(this.switchToLil, this.switchToBig);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: 130,
          child: RaisedButton(
            color: Colors.amber[700],
            child: Text(
              "LIL",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: switchToLil,
          ),
        ),
        Image(
          image: AssetImage('assets/hen.png'),
        ),
        Container(
          width: 130,
          child: RaisedButton(
            child: Text(
              "BIG",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: switchToBig,
          ),
        ),
      ],
    );
  }
}
