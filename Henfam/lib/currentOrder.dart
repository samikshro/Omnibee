import 'package:flutter/material.dart';

class CurrentOrder extends StatelessWidget {
  final String name;
  final String time;
  final String status;

  CurrentOrder(this.name, this.time, this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      width: double.infinity,
      height: 80,
      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Row(
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(15, 15, 90, 0),
                  child: Text(
                    this.name + " is delivering your order!",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 5, 0, 0),
                    child: Text(
                      this.time,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "pm ARRIVAL",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 20,
                    margin: EdgeInsets.fromLTRB(6, 10, 0, 0),
                    decoration: new BoxDecoration(
                      color: Colors.grey,
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
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: RaisedButton(
              shape: CircleBorder(
                side: BorderSide(color: Colors.amber),
              ),
              onPressed: () {},
              padding: EdgeInsets.all(13),
              color: Colors.amber,
              textColor: Colors.white,
              child: Icon(Icons.chat_bubble, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}
