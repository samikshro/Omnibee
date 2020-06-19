import 'package:flutter/material.dart';
import 'package:Henfam/models/errandModel.dart';

class ErrandCard extends StatelessWidget {
  final String bigHenName;
  final String bigHenImage;
  final String timeFrame;
  final String location;
  final String destination;
  final ErrandType type;
  final int requestLimit;

  ErrandCard({
    this.bigHenName,
    this.bigHenImage,
    this.timeFrame,
    this.location,
    this.destination,
    this.type,
    this.requestLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Image(
            image: AssetImage(bigHenImage),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.grey[700],
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "$bigHenName is getting food from",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "$location",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ]),
                  ),
                ),
                Container(
                  color: Colors.grey[50],
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "$timeFrame",
                          ),
                          Text(
                            "$destination",
                          ),
                        ]),
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
