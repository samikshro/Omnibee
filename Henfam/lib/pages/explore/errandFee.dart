import 'package:flutter/material.dart';

class ErrandFee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      child: ExpansionTile(
        title: Text(
          "Errand Fees",
          style: TextStyle(fontSize: 18),
        ),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15),
            width: double.infinity,
            color: Colors.blue[50],
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
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 75,
                            padding: EdgeInsets.all(8),
                            color: Colors.amber,
                            child: Text('Distance'),
                          ),
                          Container(
                            width: 155,
                            padding: EdgeInsets.all(8),
                            color: Colors.white,
                            child: Text("\$50 per 3-min walk*"),
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
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 75,
                            padding: EdgeInsets.all(8),
                            color: Colors.blue[300],
                            child: Text('Effort'),
                          ),
                          Container(
                            width: 155,
                            padding: EdgeInsets.all(8),
                            color: Colors.white,
                            child: Text("15% price of food"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    '*A 3-min walk equates to 0.15 miles',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
