import 'package:flutter/material.dart';

class ErrandFee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        title: Text(
          "Errand Fees",
          style: TextStyle(fontSize: 18),
        ),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                ),
                Text(
                  'One Simple Fee, No Surprises:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                ),
                Text(
                  'Errand Fee = Distance + Effort',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 75,
                            padding: EdgeInsets.all(8),
                            child: Text('Distance'),
                          ),
                          Container(
                            width: 170,
                            padding: EdgeInsets.all(8),
                            child: Text("\$1.00 flat fee"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 75,
                            padding: EdgeInsets.all(8),
                            child: Text('Effort'),
                          ),
                          Container(
                            width: 170,
                            padding: EdgeInsets.all(8),
                            child: Text("17.5% price of food"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
