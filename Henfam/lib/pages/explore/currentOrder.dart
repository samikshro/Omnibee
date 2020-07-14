import 'package:flutter/material.dart';

class CurrentOrder extends StatelessWidget {
  final String name;
  final String time;
  final String status;

  CurrentOrder(this.name, this.time, this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    this.name + " is delivering your order!",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      this.time,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "pm ARRIVAL",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 20,
                    margin: EdgeInsets.fromLTRB(6, 10, 0, 0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(6, 10, 0, 0),
                    child: Text(
                      this.status.toUpperCase(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ]),
          Container(
            child: RaisedButton(
              shape: CircleBorder(
                side: BorderSide(),
              ),
              onPressed: () {},
              padding: EdgeInsets.all(13),
              child: Icon(Icons.chat_bubble, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}
